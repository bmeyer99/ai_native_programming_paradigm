# AI Model Architecture and Integration Service Interfaces

This document outlines potential AI system designs for optimized code generation and understanding within the AI-Native Programming Paradigm, and defines the interfaces for the AI Integration Service component.

## Core Transformation Architectures

### Gen (I → R) Architecture
- **Proposed:** Hybrid LLM & Structured Model.
  - **LLM Component:** Handles initial intent parsing, natural language understanding, and interactive clarification.
  - **Structured Component:** (e.g., Specialized Transformer, GNN) Takes structured output from LLM/clarification phase and generates the precise R format. Requires a defined intermediate representation.
- **Alternatives:** End-to-end sequence-to-sequence models (simpler but potentially less precise), multi-modal models (for handling diverse intent inputs like diagrams).

### Opt (R → R') Architecture
- **Proposed:** Guided Reinforcement Learning (RL) with Formal Constraints.
  - **RL Agent:** Proposes optimization transformations on R.
  - **Formal Verifier:** A separate (potentially non-AI) component that rigorously checks if the proposed transformation R' satisfies R' ⊑ R before application.
- **Alternatives:** AI-Driven Heuristic Selection (AI selects from a library of pre-verified, provably correct optimization rules), Neurosymbolic models (integrating neural learning with symbolic reasoning for potentially provably correct optimizations).

### View (R → H) Architecture
- **Proposed:** Metadata-Guided Generative Models.
  - **Generative Component:** (e.g., Fine-tuned LLM) Generates human-readable views (text, summaries, potentially diagram descriptions) based on R.
  - **Guidance Mechanism:** Uses metadata embedded within R to ensure relevance and accuracy of the generated view H.
- **Alternatives:** Retrieval-Augmented Generation (RAG) to pull relevant documentation or examples, specialized models for specific view types (e.g., graph visualization generation).

## Supporting Architectures
- **Verification Models:** Could range from specialized classifiers trained to detect violations of ≈ or ⊑, to AI systems assisting formal verification tools.
- **Clarification Dialogue System:** An LLM-based conversational agent specifically trained for resolving ambiguities in software requirements/intent.
- **Integrated Pipeline:** The overall architecture involves orchestrating these models, potentially with shared embeddings or intermediate representations, along with non-AI components like formal verifiers and the final R-to-machine-code compiler.

---

## AI Integration Service Interfaces

The AI Integration Service acts as an abstraction layer, providing a unified interface for other system components to interact with various AI models.

**Protocol:** RESTful API (HTTPS) or gRPC (for performance-critical internal communication). JSON will be used for request/response bodies.

**Asynchronous Handling:** For potentially long-running tasks (generation, complex optimization), the API will follow an asynchronous pattern:
1.  Client sends a request to initiate a task.
2.  API immediately returns a `task_id` and a `status_url`.
3.  Client polls the `status_url` or receives a notification (e.g., via webhook, WebSocket) when the task is complete.
4.  Client retrieves results from a `result_url` provided in the status update.

### Common Data Structures

```json
// Represents a fragment or reference to an ANRF instance
"AnrfReference": {
  "type": "object",
  "properties": {
    "anrf_id": { "type": "string", "description": "Unique ID of the full ANRF instance" },
    "element_ids": { "type": "array", "items": { "type": "string" }, "description": "Optional list of specific element IDs within the ANRF instance to focus on" }
  },
  "required": ["anrf_id"]
}

// Represents context for the AI task
"TaskContext": {
  "type": "object",
  "properties": {
    "user_id": { "type": "string" },
    "session_id": { "type": "string" },
    "project_context": { "type": "object", "description": "Project-specific conventions, dependencies, etc." },
    "domain_context": { "type": "object", "description": "Domain-specific knowledge or constraints" },
    "user_preferences": { "type": "object", "description": "User-specific settings (e.g., preferred explanation style)" }
  }
}

// Represents AI model configuration hints
"ModelConfig": {
  "type": "object",
  "properties": {
    "preferred_model": { "type": "string", "description": "Hint for a specific model or capability (e.g., 'gpt-4-code', 'gnn-optimizer-v2')" },
    "parameters": { "type": "object", "description": "Model-specific parameters (e.g., temperature, optimization level)" }
  }
}

// Standard asynchronous task response
"AsyncTaskResponse": {
  "type": "object",
  "properties": {
    "task_id": { "type": "string" },
    "status": { "type": "string", "enum": ["PENDING", "RUNNING", "COMPLETED", "FAILED"] },
    "status_url": { "type": "string", "format": "uri" },
    "result_url": { "type": ["string", "null"], "format": "uri" },
    "error_message": { "type": ["string", "null"] }
  },
  "required": ["task_id", "status", "status_url"]
}
```

### API Endpoints

#### 1. Intent Translation (`/translate/intent-to-anrf`)

*   **Method:** POST
*   **Request Body:**
    ```json
    {
      "intent_input": {
        "type": "object",
        "properties": {
          "modality": { "type": "string", "enum": ["natural_language", "code_example", "visual_sketch", "multi_modal"] },
          "content": { "type": "object", "description": "Content based on modality (e.g., text, code string, image data)" }
        },
        "required": ["modality", "content"]
      },
      "context": { "$ref": "#/components/schemas/TaskContext" },
      "model_config": { "$ref": "#/components/schemas/ModelConfig" },
      "callback_url": { "type": "string", "format": "uri", "description": "Optional webhook URL for status updates" }
    }
    ```
*   **Response Body (Success - 202 Accepted):** `{ "$ref": "#/components/schemas/AsyncTaskResponse" }`
*   **Result (Retrieved from `result_url`):**
    ```json
    {
      "status": "COMPLETED",
      "result": {
        "anrf_reference": { "$ref": "#/components/schemas/AnrfReference" }, // Reference to the newly created/updated ANRF
        "confidence_score": { "type": "number" },
        "ambiguity_report": { "type": ["object", "null"], "description": "Details on ambiguities encountered and how they were resolved or need clarification" }
      }
    }
    ```

#### 2. Optimization Suggestion (`/optimize/suggest`)

*   **Method:** POST
*   **Request Body:**
    ```json
    {
      "anrf_reference": { "$ref": "#/components/schemas/AnrfReference" },
      "optimization_goal": { "type": "string", "enum": ["performance", "size", "readability", "custom"], "description": "Primary goal for optimization" },
      "constraints": { "type": "array", "items": { "type": "string" }, "description": "Constraints to maintain (e.g., semantic properties, resource limits)" },
      "context": { "$ref": "#/components/schemas/TaskContext" },
      "model_config": { "$ref": "#/components/schemas/ModelConfig" },
      "max_suggestions": { "type": "integer", "default": 3 },
      "callback_url": { "type": "string", "format": "uri", "description": "Optional webhook URL" }
    }
    ```
*   **Response Body (Success - 202 Accepted):** `{ "$ref": "#/components/schemas/AsyncTaskResponse" }`
*   **Result (Retrieved from `result_url`):**
    ```json
    {
      "status": "COMPLETED",
      "result": {
        "suggestions": [
          {
            "suggestion_id": { "type": "string" },
            "description": { "type": "string", "description": "Explanation of the suggested optimization" },
            "estimated_impact": { "type": "object", "description": "Predicted impact on goals/constraints" },
            "confidence_score": { "type": "number" },
            "anrf_diff": { "type": "object", "description": "Proposed changes to ANRF (e.g., in a diff format)" },
            "verification_status": { "type": "string", "enum": ["PRE_VERIFIED", "NEEDS_VERIFICATION"], "description": "Indicates if the suggestion is based on pre-verified transformations" }
          }
          // ... more suggestions
        ]
      }
    }
    ```

#### 3. Explanation Generation (`/explain/anrf`)

*   **Method:** POST
*   **Request Body:**
    ```json
    {
      "anrf_reference": { "$ref": "#/components/schemas/AnrfReference" },
      "explanation_type": { "type": "string", "enum": ["summary", "rationale", "behavior", "comparison"], "description": "Type of explanation requested" },
      "target_audience": { "type": "string", "enum": ["expert", "novice", "domain_specialist"], "description": "Target audience expertise level" },
      "abstraction_level": { "type": "string", "enum": ["intent", "semantic", "execution"], "description": "Desired level of abstraction" },
      "context": { "$ref": "#/components/schemas/TaskContext" },
      "model_config": { "$ref": "#/components/schemas/ModelConfig" }
    }
    ```
*   **Response Body (Success - 200 OK):**
    ```json
    {
      "explanation": {
        "format": { "type": "string", "enum": ["markdown", "natural_language", "structured_json"] },
        "content": { "type": "object" }, // Content depends on format
        "confidence_score": { "type": "number" },
        "related_elements": { "type": "array", "items": { "$ref": "#/components/schemas/AnrfReference" } }
      }
    }
    ```

#### 4. Verification Assistance (`/verify/assist`)

*   **Method:** POST
*   **Request Body:**
    ```json
    {
      "anrf_reference": { "$ref": "#/components/schemas/AnrfReference" },
      "verification_task": {
        "type": "object",
        "properties": {
          "task_type": { "type": "string", "enum": ["property_generation", "semantic_equivalence", "bug_finding", "proof_guidance"] },
          "property_to_verify": { "type": ["string", "null"], "description": "Specific property or invariant" },
          "reference_anrf": { "$ref": "#/components/schemas/AnrfReference", "description": "Reference ANRF for equivalence checks" }
        },
        "required": ["task_type"]
      },
      "context": { "$ref": "#/components/schemas/TaskContext" },
      "model_config": { "$ref": "#/components/schemas/ModelConfig" },
      "callback_url": { "type": "string", "format": "uri", "description": "Optional webhook URL" }
    }
    ```
*   **Response Body (Success - 202 Accepted):** `{ "$ref": "#/components/schemas/AsyncTaskResponse" }`
*   **Result (Retrieved from `result_url`):**
    ```json
    {
      "status": "COMPLETED",
      "result": {
        "verification_outcome": { "type": "object", "description": "Result specific to task_type (e.g., generated properties, potential bugs, equivalence status, proof steps)" },
        "confidence_score": { "type": "number" },
        "explanation": { "type": ["string", "null"] }
      }
    }
    ```

### Error Handling

*   Standard HTTP status codes (4xx for client errors, 5xx for server/AI errors).
*   Response body for errors:
    ```json
    {
      "error": {
        "code": { "type": "string" }, // e.g., "VALIDATION_ERROR", "AI_MODEL_FAILED", "TIMEOUT"
        "message": { "type": "string" },
        "details": { "type": ["object", "null"] }
      }
    }
    ```
*   Low-confidence results from AI models will be indicated via `confidence_score` in the response, allowing upstream services or the UI to handle them appropriately (e.g., request user confirmation, try alternative models).

### Model Selection/Configuration

*   The `model_config` parameter in requests allows clients (or the Interaction Gateway based on user settings) to suggest specific models or parameters.
*   The AI Integration Service will use this as a hint but may override it based on internal logic, model availability, or performance considerations.
*   The service maintains an internal registry of available AI models and their capabilities.

This interface design provides a flexible and extensible way for the system architecture components to leverage diverse AI capabilities for working with ANRF.