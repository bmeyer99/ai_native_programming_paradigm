# AI Model Training Requirements and Development Plan

## Overview
This document outlines the data requirements, training methodologies, evaluation frameworks, and development plans for the AI models supporting the AI-Native Programming Paradigm, evolving across implementation phases.

## Phase 1: Internal Dogfooding - Development and Training Plan

**Goal**: Establish functional baseline AI models for core workflow validation during internal dogfooding. Focus on feasibility and basic integration over performance optimization.

### 1. Model Selection & Fine-tuning Strategy

*   **Intent Analysis Service (v1)**:
    *   **Model**: DistilBERT (or similar lightweight Transformer) fine-tuned for intent classification and keyword/entity extraction.
    *   **Fine-tuning Data**:
        *   Source: Internal technical documentation, simple requirement specifications (e.g., user stories, feature descriptions), synthetically generated examples mapping text to structured intent.
        *   Size Estimate: ~1,000-5,000 examples.
        *   Format: Pairs of (input text, structured intent JSON).
    *   **Fine-tuning Process**: Standard supervised fine-tuning using Hugging Face `Trainer` or similar. Focus on classifying intent type (e.g., create function, modify class) and extracting key parameters.
    *   **Constraint Parsing**: Implement rule-based parsing (e.g., using regex or simple grammar) for basic constraints mentioned in the intent text. This is separate from the ML model initially.

*   **Generation Service (v1)**:
    *   **Model**: Code-Llama 7B (or StarCoder variant) fine-tuned specifically for generating ANRF based on structured intent.
    *   **Fine-tuning Data**:
        *   Source: Synthetically generated (structured intent -> ANRF) pairs, small internal codebase manually translated to ANRF format.
        *   Size Estimate: ~5,000-10,000 examples. Requires close collaboration with Language Designer for ANRF format stability.
        *   Format: Pairs of (structured intent JSON, ANRF instance).
    *   **Fine-tuning Process**: Supervised fine-tuning focusing on generating structurally valid ANRF that matches the input intent. Use techniques to handle structured output if necessary (e.g., constrained decoding, specific tokenization).

*   **Verification Service (v1 - AI Checkers)**:
    *   **Model**: Primarily rule-based for Phase 1. No ML model training required initially.
    *   **Development**: Implement Python functions based on ANRF specifications for:
        *   Structural Consistency Checks (e.g., validating graph structure, layer linkages).
        *   Basic Type Checking (using type information embedded in ANRF metadata).

### 2. Service Implementation Plan

*   **Technology**: Python 3.9+, FastAPI for API framework.
*   **Intent Analysis Service**:
    *   Implement API endpoint `/intent/analyze`.
    *   Load fine-tuned NLU model for inference.
    *   Integrate rule-based constraint parser.
    *   Interact with Metadata DB for context (if needed, may be simple context passing initially).
    *   Format output according to API specification.
    *   Integrate logging client.
*   **Generation Service**:
    *   Implement API endpoint `/generate`.
    *   Load fine-tuned Code LLM from Model Registry for inference.
    *   Implement basic Conformal Prediction logic (e.g., using nonconformity scores based on sequence probability) to generate a single sequence-level confidence score.
    *   Interact with ANRF Registry (write) and Metadata DB (write) to store results.
    *   Format output according to API specification.
    *   Integrate logging client.
*   **Verification Service**:
    *   Implement API endpoint `/verify/{anrfId}`.
    *   Implement rule-based structural and type checking logic.
    *   Interact with ANRF Registry (read) and Metadata DB (read).
    *   Format output according to API specification.
    *   Integrate logging client.

### 3. Data Requirements & Preparation (Phase 1)

*   **Intent Data**: Need ~1k-5k examples mapping natural language/simple specs to structured intent format. Requires manual creation or semi-automated generation based on templates.
*   **ANRF Generation Data**: Need ~5k-10k examples mapping structured intent to valid ANRF. Requires a stable v1 ANRF format definition from Language Designer. Significant effort needed for manual translation or synthetic generation tool development.
*   **Data Storage**: Store raw and processed training data in designated object storage buckets (e.g., S3).
*   **Versioning**: Use simple versioning for datasets (e.g., timestamped folders).

### 4. Training & Evaluation Pipeline (v1)

*   **Process**: Semi-automated initially.
    1.  **Data Prep**: Scripts to format raw data into training pairs. Manual execution.
    2.  **Fine-tuning**: Execute fine-tuning scripts (e.g., Python scripts using Hugging Face `Trainer`). Manual trigger. Requires GPU resources for LLM fine-tuning.
    3.  **Evaluation**: Run evaluation scripts against a hold-out test set. Metrics:
        *   Intent Analysis: Classification accuracy, F1 score for entity extraction.
        *   Generation: ANRF structural validity (pass/fail), BLEU/ROUGE scores against reference ANRF (limited utility), semantic equivalence checks (manual review initially).
    4.  **Model Registration**: Manually upload trained model artifacts and evaluation results to the v1 Model Registry (MLflow Tracking Server or S3). Tag models appropriately (e.g., `phase-1`, `intent-v1`).
*   **Infrastructure**: Requires access to compute resources (CPU/GPU) for training, object storage for data/models, and the v1 Model Registry.

### 5. Integration Points (Phase 1)

*   **Model Loading**: Services load models from the v1 Model Registry based on tags/versions.
*   **Data Storage**: Generation Service writes to ANRF Registry and Metadata DB. Verification/Viewing Services read from them.
*   **Monitoring**: All services push logs and basic metrics to the central Monitoring & Logging system.

### 6. Confidence Scoring (Phase 1)

*   **Implementation**: Implement a basic Conformal Prediction wrapper around the Generation Service's LLM.
*   **Method**: Use sequence likelihood or similar simple nonconformity measure. Calibrate on a small hold-out set to provide a single, sequence-level confidence score (e.g., probability that the generated ANRF is "correct" based on calibration data).
*   **Output**: Include the `confidenceScore` (float 0-1) in the `/generate` API response.

## Future Phases (High-Level Plan)

*   **Phase 2**: Introduce RLHF for Generation, GNNs for Verification, automated retraining pipelines (MLOps v1), more sophisticated confidence scoring (token-level).
*   **Phase 3**: Domain adaptation, scalable generation architectures, AI assistance for formal methods, RL for optimization, advanced MLOps (A/B testing, drift detection).
*   **Phase 4**: Security hardening, multi-objective optimization, potential personalization/federated learning, mature MLOps.

## Change Log
- 2025-04-07: Added detailed development and training plan for Phase 1 AI models.
- 2025-04-07: Initial document structure created based on AI Capability Roadmap.