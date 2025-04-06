# AI Model Architecture

## 1. Overview

This document outlines the architecture of the AI systems responsible for code generation, confidence scoring, verification assistance, and explanation within the AI-Native Programming Paradigm.

## 2. Core AI Services

### 2.1. AI Generation Service
*(Details TBD)*

### 2.2. AI Confidence Scoring Service (Phase 1 MVP Design)

*   **Objective:** Provide reliable, explainable, and computationally efficient confidence scores for AI-generated code components.
*   **Phase 1 Models:**
    1.  **Calibrated Softmax Probability:**
        *   **Technique:** Apply temperature scaling or isotonic regression to the output probabilities of the code generation model to improve calibration.
        *   **Input:** Generated code representation (ANRF), potentially generation context.
        *   **Output:** Calibrated probability score (0.0 - 1.0).
        *   **Metadata Written:**
            *   `confidence_score`: Calibrated probability value.
            *   `confidence_type`: "calibrated_probability".
            *   `confidence_rationale`: "Confidence based on calibrated output probability distribution of the generation model."
        *   **Considerations:** Requires a held-out calibration dataset. Relatively lightweight computation post-generation. Provides a measure of *aleatoric* uncertainty (inherent randomness).
    2.  **Simple Out-of-Distribution (OOD) Heuristic:**
        *   **Technique:** Thresholding on the maximum calibrated softmax probability (MSP). Inputs with max probability below a certain threshold are flagged as potentially OOD. Alternatively, Mahalanobis distance on penultimate layer embeddings if available and efficient.
        *   **Input:** Calibrated softmax probability (from Model 1) or embeddings.
        *   **Output:** Binary OOD flag (True/False) or a heuristic OOD score.
        *   **Metadata Written (if OOD detected):**
            *   `confidence_score_adjustment`: Negative adjustment factor or flag.
            *   `confidence_flags`: ["potential_ood"].
            *   `confidence_rationale_addendum`: "Input characteristics may differ from typical training data."
        *   **Considerations:** Very lightweight. Provides a basic measure of *epistemic* uncertainty (model ignorance). Threshold needs careful tuning. Less robust than dedicated OOD models but suitable for MVP.
*   **Integration:**
    *   Receives requests from the IDE Integration Layer/Gateway or directly from the AI Generation Service post-generation.
    *   Reads generated code representation (ANRF) and potentially context metadata.
    *   Writes confidence metadata fields back to the ANRF via the Metadata Store API.
    *   **Metadata Update Notification:** Upon successful write to the Metadata Store, the AI Service (or the Metadata Store itself, if capable) will publish an event (e.g., to a shared event bus like Kafka/Redis PubSub) containing the ANRF reference and updated metadata keys. The IDE Integration Layer/Gateway subscribes to these events to receive notifications. A fallback polling mechanism on the Gateway may be implemented for resilience.
    *   **Gateway Caching:** Acknowledges that the IDE Integration Layer/Gateway will likely implement caching for confidence scores to optimize performance and reduce load on the Metadata Store. The event-driven notification mechanism facilitates cache invalidation.
*   **API:**
    *   Exposes an asynchronous endpoint (e.g., `POST /confidence { "anrf_reference": "..." }`).
    *   Returns immediately with a `202 Accepted` status and a task ID.
    *   Actual results (metadata updates) are delivered via the asynchronous notification mechanism.
*   **Error Handling:**
    *   **Input Errors:** Invalid ANRF reference, missing context -> Return `4xx` error immediately.
    *   **Model Inference Errors:** Internal model failure -> Log error, potentially notify monitoring system, may not update metadata or could write an error flag.
    *   **Metadata Store Write Errors:** Failure to write metadata -> Implement retry logic (e.g., exponential backoff). If retries fail, log error and potentially notify monitoring/alerting system. The Gateway should handle the lack of an update notification gracefully (e.g., timeout).
    *   **Notification Errors:** Failure to publish update event -> Log error, rely on Gateway's potential polling fallback or timeout mechanisms.
*   **Performance:** Designed for low latency (< 500ms target for Phase 1 P95 for model inference + metadata write) to support real-time feedback loops. Minimal resource consumption is critical.
*   **Future Enhancements (Phase 2+):** MC Dropout, Deep Ensembles, Conformal Prediction, more sophisticated OOD detection. The architecture (service endpoint, metadata fields, event-driven updates) allows adding new confidence types transparently.

### 2.3. AI Verification Assistance Service
*(Details TBD - Phase 2 onwards)*

### 2.4. AI Explanation Service
*(Details TBD)*

## 3. Training & Evaluation

### 3.1. Confidence Model Training (Phase 1)
*   **Calibration Data:** Requires a labeled dataset (generated code + correctness/quality label) separate from the main generation model training set.
*   **OOD Threshold Tuning:** Requires analysis of probability distributions on validation data and potentially a small set of known OOD examples.
*   **Metrics:**
    *   Expected Calibration Error (ECE) for calibrated probabilities.
    *   AUC-ROC or FPR@95TPR for OOD detection performance.
    *   Correlation analysis between confidence scores and downstream bug/quality metrics (long-term evaluation).

*(Further details on training infrastructure and datasets in `training-requirements.md`)*

## 4. Security & Safety
*(Refer to `ai-security-framework.md`)*

## 5. Integration Framework
*(Refer to `system-architecture.md` and `integration-interfaces.md`)*