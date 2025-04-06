# Transition Patterns for Migrating to ANRF

## Overview

This document outlines patterns and methods for migrating existing codebases, written in traditional programming languages, to the AI-Native Representation Format (ANRF). The goal is to provide practical pathways that respect existing investments while enabling gradual adoption of the AI-native paradigm.

## Core Principles

1.  **Incremental Migration**: Allow migration of components or modules rather than requiring a full rewrite.
2.  **Interoperability**: Enable ANRF code to interact seamlessly with legacy code during the transition.
3.  **Semantic Enrichment**: Leverage AI to infer and populate ANRF layers (especially IML and SML) from existing code and artifacts.
4.  **Value-Driven**: Prioritize migration of components where ANRF offers the most significant immediate benefits (e.g., performance-critical sections, complex logic).
5.  **Tooling Support**: Provide automated tools to assist the migration process.

## Migration Patterns

### Pattern 1: Wrapper/Facade

*   **Concept**: Encapsulate existing legacy components within an ANRF wrapper. The wrapper exposes an interface defined in ANRF (SML), while the implementation (EL) calls out to the legacy code.
*   **Process**:
    1.  Define the component's interface semantically in ANRF SML.
    2.  Generate an ANRF wrapper where the EL calls the legacy component's API (e.g., via FFI, RPC, or direct linking).
    3.  Optionally, use AI to infer initial IML (intent, constraints) based on legacy code analysis and documentation.
*   **Pros**: Low initial effort, allows ANRF code to interact with legacy systems immediately, isolates legacy code.
*   **Cons**: Performance overhead due to wrapper calls, limited ability to optimize the wrapped legacy code using ANRF tools, semantic information (SML/IML) might be incomplete initially.
*   **Use Case**: Integrating large, stable legacy libraries or services into an ANRF-based system.

### Pattern 2: Strangler Fig

*   **Concept**: Gradually replace functionality within a legacy system with new ANRF components. A routing layer (potentially ANRF-aware) directs calls to either the new ANRF implementation or the old legacy implementation.
*   **Process**:
    1.  Identify a module or feature to migrate.
    2.  Implement the feature using ANRF, potentially starting from intent specification.
    3.  Deploy the ANRF component alongside the legacy system.
    4.  Update the routing layer to direct relevant calls to the new ANRF component.
    5.  Gradually expand the scope of migrated functionality, "strangling" the legacy system over time.
*   **Pros**: Incremental migration with continuous delivery, reduces risk compared to big-bang rewrite, allows leveraging ANRF benefits for new/migrated features.
*   **Cons**: Requires careful management of the routing layer, potential for temporary inconsistencies during migration, complexity in managing hybrid system state.
*   **Use Case**: Modernizing large monolithic applications incrementally.

### Pattern 3: AI-Assisted Code Translation & Enrichment

*   **Concept**: Use AI tools to semi-automatically translate traditional source code into a baseline ANRF representation, focusing initially on the EL and basic SML, and then enrich it.
*   **Process**:
    1.  **Initial Translation (Code -> EL/Basic SML)**: Use AI models (trained on code translation) to parse legacy code and generate a corresponding EL graph and basic SML structure (e.g., function signatures, basic types, call graph).
    2.  **Semantic Enrichment (-> Full SML)**: Use AI (analyzing code, tests, documentation, commit history) and potentially developer input to infer richer SML details like contracts, semantic types, and relationships.
    3.  **Intent Inference (-> IML)**: Use AI (analyzing documentation, requirements, commit messages, code structure) and developer input to populate the IML with purpose, rationale, and constraints.
    4.  **Verification & Refinement**: Verify the generated ANRF for consistency and semantic equivalence (using AI-assisted verification) and refine with developer oversight.
*   **Pros**: Potentially faster migration for large codebases, leverages AI for laborious tasks, creates a richer ANRF representation than simple wrapping.
*   **Cons**: Translation accuracy depends heavily on AI capabilities and training data, significant human review and refinement likely needed, risk of semantic errors during translation, requires sophisticated AI tooling.
*   **Use Case**: Migrating existing codebases where deeper integration with ANRF benefits (optimization, verification) is desired.

### Pattern 4: Intent-First Rewrite

*   **Concept**: For critical or complex components, rewrite them from scratch using the intent-driven workflow of the AI-native paradigm.
*   **Process**:
    1.  Analyze the legacy component to understand its core intent and requirements.
    2.  Specify this intent formally in ANRF IML.
    3.  Use the AI-native workflow (Gen, Opt, Verify) to generate a new ANRF implementation from the intent specification.
    4.  Replace the legacy component with the new ANRF implementation.
*   **Pros**: Fully leverages the benefits of the AI-native paradigm (intent alignment, optimization, verification), results in clean, well-structured ANRF code.
*   **Cons**: Highest initial effort, requires developers proficient in intent specification, essentially a rewrite.
*   **Use Case**: Migrating components where the original code is poorly structured, difficult to maintain, or requires significant improvement/re-architecture.

## Hybrid Approaches

These patterns are not mutually exclusive and can be combined. For example:
*   Use the **Wrapper/Facade** pattern for stable external dependencies.
*   Use the **Strangler Fig** pattern for the main application logic.
*   Use **AI-Assisted Translation** for well-defined internal libraries.
*   Use **Intent-First Rewrite** for performance-critical or highly complex modules.

## Tooling Requirements

*   **Code Analyzers**: Tools to parse and understand legacy code structure and semantics.
*   **ANRF Generators**: AI models and tools for translating code and inferring SML/IML (Pattern 3).
*   **FFI/RPC Generators**: Tools to automate wrapper generation (Pattern 1).
*   **Routing/Proxy Tools**: Frameworks to manage traffic redirection (Pattern 2).
*   **Verification Tools**: Tools (AI-assisted and formal) to validate migrated ANRF code.
*   **IDE Integration**: Support for visualizing and managing hybrid codebases.

## Conclusion

Migrating to ANRF requires a strategic approach. By employing patterns like Wrappers, Strangler Fig, AI-Assisted Translation, and Intent-First Rewrites, organizations can transition incrementally, manage risk, and progressively realize the benefits of the AI-Native Programming Paradigm while respecting their existing codebase investments. The choice of pattern depends on the specific component, migration goals, and available resources. Robust tooling, particularly AI-powered analysis and translation, will be critical enablers for efficient migration.