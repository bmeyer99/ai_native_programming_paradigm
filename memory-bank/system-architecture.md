# System Architecture for AI-Native Programming Paradigm

## Overview
This document outlines the technical architecture for the AI-Native Programming Paradigm, including core services, infrastructure components, data flow, and integration points. It evolves across implementation phases.

## Core Principles
- **Service-Oriented**: Key functionalities are encapsulated in independent services.
- **Scalable**: Architecture designed to handle increasing load and complexity.
- **Extensible**: Allows for future addition of new capabilities and integrations.
- **Secure**: Incorporates security considerations at all levels.
- **Resilient**: Designed for fault tolerance and graceful degradation.

## High-Level Architecture Diagram

```mermaid
graph TD
    subgraph Developer Tools
        IDEPlugin[IDE Plugin (v1)]
        CICD[CI/CD Pipeline (v1)]
        Collab[Collaboration Tools (v1)]
    end

    subgraph Core Platform - Phase 1
        APIGateway[API Gateway (v1)]

        subgraph Services
            IntentService[Intent Analysis Service (v1)]
            GenService[Generation Service (v1)]
            ViewService[Viewing Service (v1)]
            VerifyService[Verification Service (v1)]
            ExecService[Execution Service (v1)]
        end

        subgraph Infrastructure
            ANRFRegistry[ANRF Registry (v1)]
            MetadataDB[Metadata DB (v1)]
            ModelRegistry[AI Model Registry (v1)]
            Monitoring[Monitoring & Logging (v1)]
        end
    end

    IDEPlugin --> APIGateway
    CICD --> APIGateway
    Collab --> APIGateway

    APIGateway --> IntentService
    APIGateway --> GenService
    APIGateway --> ViewService
    APIGateway --> VerifyService
    APIGateway --> ExecService

    IntentService --> MetadataDB
    GenService --> ANRFRegistry
    GenService --> MetadataDB
    GenService --> ModelRegistry
    ViewService --> ANRFRegistry
    ViewService --> MetadataDB
    VerifyService --> ANRFRegistry
    VerifyService --> MetadataDB
    VerifyService --> ModelRegistry
    ExecService --> ANRFRegistry

    IntentService --> Monitoring
    GenService --> Monitoring
    ViewService --> Monitoring
    VerifyService --> Monitoring
    ExecService --> Monitoring
    APIGateway --> Monitoring
```

## Phase 1: Internal Dogfooding - Technical Specifications

### 1. Core Platform Services (v1)

#### a. Intent Analysis Service (v1)
*   **Purpose**: Translate basic developer intent (text input) into a structured format for the Generation Service.
*   **Technology**: Python (FastAPI), spaCy/NLTK for basic NLP, rule-based constraint parsing.
*   **API (`/intent/analyze`)**:
    *   Input: `{ "inputText": "string", "context": { "module": "string", "function": "string" } }`
    *   Output: `{ "structuredIntent": { ... }, "constraints": [ ... ], "analysisId": "uuid" }` or `{ "error": "string" }`
*   **Dependencies**: Metadata DB (for context), Monitoring Service.
*   **Deployment**: Containerized service (Docker).

#### b. Generation Service (v1)
*   **Purpose**: Generate ANRF instances from structured intent. Provide basic confidence scores.
*   **Technology**: Python (FastAPI), Hugging Face Transformers (fine-tuned Code-Llama/StarCoder), basic Conformal Prediction library.
*   **API (`/generate`)**:
    *   Input: `{ "structuredIntent": { ... }, "constraints": [ ... ], "analysisId": "uuid" }`
    *   Output: `{ "anrfId": "uuid", "confidenceScore": "float (0-1)", "generationId": "uuid" }` or `{ "error": "string" }`
*   **Dependencies**: ANRF Registry (write), Metadata DB (write), AI Model Registry (read models), Monitoring Service.
*   **Deployment**: Containerized service (Docker), potentially GPU-enabled nodes.

#### c. Viewing Service (v1)
*   **Purpose**: Translate ANRF instances into basic human-readable formats (e.g., pseudocode).
*   **Technology**: Python (FastAPI), template engine (e.g., Jinja2), ANRF parsing library.
*   **API (`/view/{anrfId}`)**:
    *   Input: Path parameter `anrfId`. Query parameter `format` (e.g., `pseudocode`, `structure`).
    *   Output: `{ "content": "string", "format": "string" }` or `{ "error": "string" }`
*   **Dependencies**: ANRF Registry (read), Metadata DB (read), Monitoring Service.
*   **Deployment**: Containerized service (Docker).

#### d. Verification Service (v1)
*   **Purpose**: Perform basic structural consistency and type checks on ANRF.
*   **Technology**: Python (FastAPI), ANRF validation library, basic type checker.
*   **API (`/verify/{anrfId}`)**:
    *   Input: Path parameter `anrfId`. Query parameter `checks` (e.g., `structure`, `types`).
    *   Output: `{ "results": [ { "check": "string", "status": "PASS|FAIL|WARN", "details": "string" } ], "verificationId": "uuid" }` or `{ "error": "string" }`
*   **Dependencies**: ANRF Registry (read), Metadata DB (read), Monitoring Service.
*   **Deployment**: Containerized service (Docker).

#### e. Execution Service (v1)
*   **Purpose**: Provide a basic execution environment for ANRF (interpretation or simple compilation). Primarily for debugging/testing.
*   **Technology**: Python (FastAPI), ANRF interpreter/simple JIT compiler (target: e.g., WASM or Python bytecode).
*   **API (`/execute/{anrfId}`)**:
    *   Input: Path parameter `anrfId`. Body `{ "inputs": { ... } }`
    *   Output: `{ "output": { ... }, "logs": [ "string" ], "executionId": "uuid" }` or `{ "error": "string" }`
*   **Dependencies**: ANRF Registry (read), Monitoring Service.
*   **Deployment**: Containerized service (Docker).

### 2. Basic Infrastructure (v1)

#### a. API Gateway (v1)
*   **Purpose**: Single entry point for all external requests, basic routing, authentication (API keys for Phase 1).
*   **Technology**: Nginx, Kong, or cloud provider gateway (e.g., AWS API Gateway).
*   **Configuration**: Route requests to appropriate backend services. Implement basic rate limiting.
*   **Dependencies**: Core Platform Services, Monitoring Service.

#### b. ANRF Registry (v1)
*   **Purpose**: Store and version ANRF instances.
*   **Technology**: Object storage (e.g., AWS S3, MinIO) with versioning enabled. Naming convention: `anrf/{anrfId}/{version}.anrf`.
*   **Interface**: S3 API or equivalent.
*   **Dependencies**: Generation Service (write), Viewing/Verification/Execution Services (read).

#### c. Metadata DB (v1)
*   **Purpose**: Store metadata related to intent, generation, verification, ANRF structure, and relationships.
*   **Technology**: PostgreSQL or similar relational database.
*   **Schema (Initial)**: Tables for `Intents`, `Generations`, `ANRFs`, `Verifications`, `Contexts`, `Feedback`. Focus on linking IDs (e.g., `analysisId`, `generationId`, `anrfId`).
*   **Dependencies**: Intent, Generation, Viewing, Verification Services.

#### d. AI Model Registry (v1)
*   **Purpose**: Store and version AI models used by services.
*   **Technology**: MLflow Tracking Server or simple object storage (e.g., S3) with versioning.
*   **Interface**: MLflow API or S3 API.
*   **Dependencies**: Generation Service, Verification Service (read models).

#### e. Monitoring & Logging (v1)
*   **Purpose**: Collect logs and basic metrics from services.
*   **Technology**: Centralized logging (e.g., ELK stack - Elasticsearch, Logstash, Kibana or Grafana Loki). Basic metrics collection (e.g., Prometheus client libraries in services, Prometheus server, Grafana for dashboards).
*   **Configuration**: Services push logs; Prometheus scrapes metrics endpoints. Basic dashboards for service health and request counts.
*   **Dependencies**: All services, API Gateway.

### 3. Service APIs and Data Formats

*   **Communication**: RESTful APIs using JSON.
*   **Authentication**: Simple API Key authentication via API Gateway for Phase 1.
*   **ANRF Format**: Initial binary or structured format (e.g., Protocol Buffers, MessagePack) as defined by Language Designer. Versioning essential.
*   **Identifiers**: Use UUIDs for all major entities (analysis, generation, ANRF, verification, execution).

### 4. Deployment Architecture (v1)

*   **Platform**: Kubernetes (e.g., EKS, GKE, K3s) or Docker Compose for simplicity in early stages.
*   **Containerization**: All services packaged as Docker containers.
*   **CI/CD**: Basic pipeline (e.g., GitHub Actions, Jenkins) for building containers and deploying to the chosen platform. Manual triggers for Phase 1.

### 5. Development Environment Setup (v1)

*   **Local Setup**: Docker Compose configuration to run all services and infrastructure locally.
*   **Shared Dev Cluster**: Optional Kubernetes cluster for shared testing.
*   **Tooling**: Standard language toolchains (Python), Docker, `kubectl` (if using Kubernetes).
*   **Documentation**: README files for each service explaining setup and basic usage.

### 6. Technical Dependencies

*   **Programming Languages**: Primarily Python 3.9+.
*   **Frameworks**: FastAPI, Hugging Face Transformers, spaCy/NLTK, MLflow, Prometheus client, logging libraries.
*   **Infrastructure**: Docker, Kubernetes (optional), PostgreSQL, Object Storage (S3 compatible), ELK/Loki+Prometheus+Grafana.
*   **External Services**: Cloud provider services (if applicable for deployment, storage, etc.).

## Change Log
- 2025-04-07: Added detailed technical specifications for Phase 1 (Internal Dogfooding).
- 2025-04-05: Initial high-level architecture created.