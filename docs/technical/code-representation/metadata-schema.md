# AI-Native Representation Format (ANRF) Metadata Schema - v1

## Overview
This document provides a detailed specification of the metadata schema for the AI-Native Representation Format (ANRF). The metadata schema defines how semantic information is preserved alongside optimized code, enabling AI understanding, human-readable translation, and formal verification.

## Core Metadata Principles
- **Comprehensive**: Captures all necessary semantic information
- **Structured**: Organized in a well-defined hierarchy
- **Linked**: Maintains bidirectional references between layers
- **Extensible**: Allows for future additions without breaking compatibility
- **Queryable**: Supports efficient retrieval and analysis

## Metadata Organization

The ANRF metadata is organized into three primary layers, each with its own schema:

```
┌─────────────────────────────────┐
│           Intent Layer          │
│  (High-level intent and design) │
├─────────────────────────────────┤
│         Semantic Layer          │
│ (Relationships and constraints) │
├─────────────────────────────────┤
│        Execution Layer          │
│    (Optimized execution code)   │
└─────────────────────────────────┘
```

## 1. Intent Layer Metadata

The Intent Layer captures the high-level purpose, requirements, and design decisions that drove the code generation.

### 1.1 Core Intent Metadata

| Field | Type | Description | Required |
|-------|------|-------------|----------|
| `intent_type` | string | Type of intent (function, class, module, etc.) | Yes |
| `description` | string | Natural language description of intent | Yes |
| `constraints` | array | Explicit constraints on implementation | No |
| `tags` | array | Categorization and search tags | No |
| `properties` | map | Additional key-value properties | No |

### 1.2 Constraint Types

| Constraint Type | Description | Example |
|-----------------|-------------|---------|
| `performance` | Performance requirements | "Linear time complexity O(n)" |
| `security` | Security requirements | "Input validation required" |
| `compatibility` | Compatibility requirements | "Must work with Python 3.9+" |
| `reliability` | Reliability requirements | "Must handle network failures" |
| `resource` | Resource usage constraints | "Memory usage under 100MB" |

### 1.3 Intent Properties

Common properties that may appear in the `properties` map:

| Property | Description | Example |
|----------|-------------|---------|
| `author` | Author of the intent | "AI" or "Human" |
| `created_at` | Creation timestamp | "2025-04-07T01:00:00Z" |
| `priority` | Implementation priority | "high" |
| `domain` | Application domain | "finance" |
| `rationale` | Reasoning behind intent | "Needed for efficient data processing" |

## 2. Semantic Layer Metadata

The Semantic Layer maps between intent and execution, containing relationships, types, and constraints.

### 2.1 Node Types

| Node Type | Description | Properties |
|-----------|-------------|------------|
| `function` | Function definition | name, return_type, visibility |
| `parameter` | Function parameter | name, type, default_value |
| `variable` | Variable declaration | name, type, scope, mutability |
| `expression` | Expression node | expression_type, result_type |
| `control_flow` | Control flow construct | flow_type (if, loop, etc.) |
| `type_def` | Type definition | name, kind, fields |
| `module` | Module or namespace | name, imports |
| `class` | Class definition | name, parent_classes, members |

### 2.2 Edge Types

| Edge Type | Description | Properties |
|-----------|-------------|------------|
| `calls` | Function call relationship | arguments, return_handling |
| `contains` | Containment relationship | visibility |
| `depends_on` | Dependency relationship | dependency_type |
| `inherits` | Inheritance relationship | override_behavior |
| `references` | Reference to another node | reference_type |
| `defines` | Definition relationship | scope |
| `has_parameter` | Function-parameter relationship | position, optional |
| `has_member` | Class-member relationship | access_level |

### 2.3 Type System

The type system in the Semantic Layer supports:

| Type Kind | Description | Example |
|-----------|-------------|---------|
| `primitive` | Primitive types | int, float, bool, string |
| `array` | Array/list types | int[], string[] |
| `struct` | Composite structure | Person{name, age} |
| `function` | Function types | (int, int) -> int |
| `union` | Union types | int \| string |
| `generic` | Generic types | List<T> |
| `reference` | Reference types | &Person |
| `nullable` | Nullable types | int? |

### 2.4 Symbol Table

The symbol table maps identifiers to nodes in the semantic graph:

```json
"symbol_table": {
  "sum": "func_sum",
  "numbers": "param_numbers",
  "result": "var_result"
}
```

## 3. Execution Layer Metadata

The Execution Layer contains the optimized code ready for execution, focusing on performance.

### 3.1 Execution Formats

| Format | Description | Use Cases |
|--------|-------------|-----------|
| `graph` | Computation graph | Data flow, parallel operations |
| `bytecode` | Virtual machine bytecode | Sequential execution |
| `ir` | Intermediate representation | Compiler optimization |
| `native` | Native machine code | Direct execution |
| `ast` | Abstract syntax tree | Source-level operations |

### 3.2 Execution Node Types

For graph-based execution representation:

| Operation | Description | Properties |
|-----------|-------------|------------|
| `function_def` | Function definition | name, signature |
| `parameter` | Parameter node | name, position |
| `variable_def` | Variable definition | name, initial_value |
| `constant` | Constant value | value, type |
| `arithmetic` | Arithmetic operation | operator (+, -, *, /) |
| `comparison` | Comparison operation | operator (==, !=, <, >) |
| `logical` | Logical operation | operator (and, or, not) |
| `control` | Control flow | type (if, switch, loop) |
| `memory` | Memory operation | type (load, store, allocate) |
| `call` | Function call | target, arguments |
| `return` | Return statement | value |

### 3.3 Execution Edge Types

| Edge Type | Description | Properties |
|-----------|-------------|------------|
| `control_flow` | Control flow edge | condition |
| `data_flow` | Data flow edge | data_type |
| `loop_body` | Loop body connection | iterator |
| `exception` | Exception handling | exception_type |

### 3.4 Execution Properties

Common properties that may appear in the execution layer:

| Property | Description | Example |
|----------|-------------|---------|
| `complexity` | Computational complexity | "O(n)" |
| `memory_usage` | Memory usage estimate | "O(n)" |
| `parallelizable` | Whether execution can be parallelized | true/false |
| `side_effects` | Whether operation has side effects | true/false |
| `optimization_level` | Level of optimization applied | "high" |

## 4. Cross-Layer References

References between layers are maintained through IDs:

### 4.1 Intent to Semantic References

Intent elements can reference semantic nodes to indicate which parts of the semantic graph fulfill specific intent aspects:

```json
"intent": {
  "constraints": [
    {
      "type": "performance",
      "description": "Linear time complexity O(n)",
      "semantic_refs": ["node_loop", "node_operation"]
    }
  ]
}
```

### 4.2 Semantic to Execution References

Semantic nodes reference execution elements to link semantic concepts to their implementation:

```json
"semantic": {
  "nodes": [
    {
      "node_id": "func_sum",
      "node_type": "function",
      "execution_refs": ["exec_node_1"]
    }
  ]
}
```

### 4.3 Execution to Semantic References

Execution elements can reference semantic nodes through properties:

```json
"execution": {
  "nodes": [
    {
      "node_id": "exec_node_1",
      "properties": {
        "semantic_ref": "func_sum"
      }
    }
  ]
}
```

## 5. Metadata Processing

### 5.1 Querying Patterns

Common query patterns for ANRF metadata:

1. **Intent-based queries**: Find implementation of specific intent
2. **Semantic structure queries**: Analyze dependencies, call graphs
3. **Type-based queries**: Find all usages of a type
4. **Cross-layer queries**: Trace from intent to execution

### 5.2 Metadata Validation

Validation rules for ANRF metadata:

1. **Structural validation**: Schema conformance
2. **Reference validation**: All references must be valid
3. **Semantic validation**: Type consistency, graph properties
4. **Cross-layer validation**: Layer coverage and consistency

### 5.3 Metadata Generation

Guidelines for generating metadata:

1. Start with intent description
2. Build semantic graph based on intent
3. Generate execution representation
4. Establish cross-layer references
5. Validate the complete metadata

## 6. Metadata Evolution

The metadata schema is designed to evolve over time:

### 6.1 Versioning

- Format version: Tracked in the root `version` field
- Schema version: May be tracked separately for each layer

### 6.2 Extension Mechanisms

- New fields can be added to existing structures
- New node/edge types can be added
- New properties can be added to existing types
- Custom extensions can be added in properties maps

### 6.3 Backward Compatibility

- Required fields must always be present
- Removed fields should be deprecated before removal
- Version-specific processing may be required

## 7. Implementation Guidelines for Phase 1

### 7.1 Metadata Storage

- Store as part of ANRF file (Protocol Buffers or JSON)
- Index key metadata fields for efficient retrieval

### 7.2 Processing Libraries

- Develop Python library for metadata manipulation
- Implement validation functions
- Create helper functions for common queries

### 7.3 Integration with AI Models

- Extract features from metadata for AI training
- Generate metadata as part of AI output
- Validate AI-generated metadata

## Change Log
- 2025-04-07: Created detailed metadata schema specification for ANRF v1