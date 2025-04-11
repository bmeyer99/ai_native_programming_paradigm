# Intent Translation Mechanism for ANRF Generation

## Overview

This document details the proposed mechanism for translating human intent, expressed through various modalities, into the structured, multi-layered AI-Native Representation Format (ANRF). This process, often referred to as `Gen(I -> R)`, is a core capability of the AI-Native Programming Paradigm.

## Goal

To accurately and reliably convert diverse forms of human intent (natural language, examples, sketches, constraints) into a well-formed ANRF instance, populating all three layers (IML, SML, EL) with consistent and semantically correct information.

## Proposed Architecture: Multi-Stage Hybrid Approach

Based on the analysis in `ai-capabilities.md` and `model-architecture.md`, a multi-stage, hybrid approach is recommended, combining the strengths of Large Language Models (LLMs) for understanding and structured models for precision.

**Stages:**

1.  **Intent Capture & Clarification**: Processing raw input and resolving ambiguities.
2.  **IML Population**: Extracting and structuring high-level intent, rationale, and constraints.
3.  **SML Generation**: Creating the semantic model (entities, relationships, contracts).
4.  **EL Generation**: Generating the executable graph based on SML.
5.  **Cross-Layer Linking & Validation**: Ensuring consistency and correctness.

```mermaid
graph LR
    A[Human Intent Input <br/>(NL, Examples, Sketches)] --> B(Stage 1: Intent Capture & Clarification <br/>- LLM Dialogue Agent);
    B --> C(Stage 2: IML Population <br/>- LLM Information Extraction);
    C --> D(Stage 3: SML Generation <br/>- Structured Prediction Model / GNN);
    D --> E(Stage 4: EL Generation <br/>- Code Generation Model / GNN);
    E --> F(Stage 5: Cross-Layer Linking & Validation <br/>- Rule Engine / Verifier);
    F --> G[Generated ANRF Instance];

    %% Feedback Loops
    B --> A; %% Clarification Loop
    F --> B; %% Validation Failure requiring Clarification
    F --> C; %% Validation Failure requiring IML update
    F --> D; %% Validation Failure requiring SML update
    F --> E; %% Validation Failure requiring EL update
```

## Stage Details

### Stage 1: Intent Capture & Clarification

*   **Input**: Raw human intent (text, code, images, etc.) via Interaction Gateway.
*   **AI Model**: Primarily LLM-based Dialogue Agent, potentially multi-modal.
*   **Process**:
    *   Parse and understand the initial intent expression.
    *   Identify ambiguities, underspecification, or potential conflicts.
    *   Engage in interactive dialogue with the user (via Interaction Gateway) to clarify intent.
    *   Normalize the clarified intent into a structured intermediate format (e.g., detailed requirements list, feature specification).
*   **Output**: Structured, clarified intent specification.

### Stage 2: IML Population

*   **Input**: Structured, clarified intent specification from Stage 1.
*   **AI Model**: LLM fine-tuned for information extraction and structuring.
*   **Process**:
    *   Extract key elements: purpose, constraints, design rationale (if provided), domain concepts.
    *   Structure this information according to the `metadata-schema.md` for the IML.
    *   Generate initial natural language descriptions.
    *   Identify relevant domain knowledge tags.
*   **Output**: Populated IML component of the ANRF.

### Stage 3: SML Generation

*   **Input**: Structured intent (Stage 1), populated IML (Stage 2).
*   **AI Model**: Structured prediction model (e.g., specialized Transformer, Sequence-to-Graph) or Graph Neural Network (GNN).
*   **Process**:
    *   Identify core semantic entities (functions, types, variables) based on intent.
    *   Define semantic properties (types, contracts, effects) based on IML constraints and descriptions.
    *   Establish semantic relationships (dependencies, uses) between entities.
    *   Generate the semantic graph and entity map according to `semantic-mapping.md`.
    *   Translate IML constraints into formal verification conditions (VCs).
*   **Output**: Populated SML component of the ANRF.

### Stage 4: EL Generation

*   **Input**: Populated SML (Stage 3).
*   **AI Model**: Code generation model (e.g., Transformer variant trained on code, GNN for graph generation).
*   **Process**:
    *   Translate SML entities and relationships into EL nodes and edges (operations, control flow).
    *   Select appropriate algorithms and data structures based on SML specifications and IML constraints (e.g., performance requirements).
    *   Ensure generated EL code satisfies the semantic contracts defined in SML.
    *   Generate code optimized for a target architecture if specified.
*   **Output**: Populated EL component of the ANRF.

### Stage 5: Cross-Layer Linking & Validation

*   **Input**: Populated IML, SML, EL components.
*   **AI Model**: Potentially AI-assisted rule engine or verifier. Primarily rule-based validation.
*   **Process**:
    *   Establish bidirectional references between corresponding elements in IML, SML, and EL.
    *   Validate structural integrity of the generated ANRF instance.
    *   Perform initial semantic consistency checks (e.g., type checking across layers, contract satisfaction).
    *   Verify consistency between IML constraints and SML/EL implementation details.
    *   If validation fails, trigger feedback to earlier stages for correction (potentially involving user clarification).
*   **Output**: Validated, fully linked ANRF instance.

## Data Flow and Intermediate Representations

*   A well-defined intermediate representation is needed between Stage 1 (Clarified Intent) and subsequent stages (IML, SML, EL generation). This could be a structured specification language or a detailed feature description format.
*   Data flows primarily sequentially, but validation failures in Stage 5 can trigger backward loops to earlier stages for refinement or clarification.

## Handling Ambiguity

*   **Stage 1**: Explicit interactive clarification dialogue is the primary mechanism.
*   **Later Stages**: If ambiguity persists or arises during generation (e.g., multiple valid implementations for a semantic contract), the AI can:
    *   Use heuristics or learned preferences (potentially from user context).
    *   Generate multiple alternatives and present them to the user for selection (via Interaction Gateway).
    *   Default to a conservative implementation and flag it for later review.

## Key AI Capabilities Required

*   **Natural Language Understanding & Dialogue**: For Stage 1.
*   **Information Extraction & Structuring**: For Stage 2.
*   **Structured Prediction (Sequence-to-Graph, Graph Generation)**: For Stage 3 & 4.
*   **Code Generation**: For Stage 4.
*   **Constraint Satisfaction**: Implicitly needed across stages, especially 3 & 4.
*   **Multi-Modal Processing**: If handling non-textual intent input.
*   **Consistency Checking & Validation**: For Stage 5 (potentially AI-assisted).

## Future Enhancements

*   **Direct Intent-to-EL**: Explore end-to-end models that generate EL directly while co-generating consistent SML/IML, potentially simplifying the pipeline but increasing complexity for verification.
*   **Learning from Existing Code**: Train models to reverse-engineer ANRF (especially SML/IML) from existing codebases to bootstrap datasets and improve generation quality.

This multi-stage hybrid approach provides a balance between leveraging the understanding capabilities of LLMs and the precision of structured models, with built-in clarification and validation loops essential for reliable intent translation.