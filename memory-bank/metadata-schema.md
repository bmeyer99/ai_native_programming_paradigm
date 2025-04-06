# Metadata Schema for AI-Native Representation Format

## Overview

The metadata schema defines how semantic information is preserved alongside optimized code in the AI-Native Representation Format (ANRF). This schema is crucial for maintaining the connection between human intent and machine-optimized code, enabling both efficient execution and human understanding.

## Core Principles

1. **Bidirectional Linkage**: Metadata must maintain bidirectional references between intent, semantics, and execution
2. **Semantic Preservation**: Metadata must capture sufficient information to preserve meaning across transformations
3. **Extensibility**: The schema must be extensible to accommodate new types of metadata
4. **Efficiency**: Metadata storage and access must be efficient to minimize runtime overhead
5. **Verifiability**: Metadata must support formal verification of semantic preservation

## Metadata Categories

The metadata schema is organized into four main categories:

### 1. Structural Metadata

Structural metadata describes the organization and structure of the code:

- **Entity Definitions**: Descriptions of program entities (variables, functions, types, etc.)
- **Dependency Relationships**: Relationships between entities (uses, contains, extends, etc.)
- **Scope Information**: Lexical and dynamic scoping information
- **Control Flow**: Control flow relationships and constraints

### 2. Semantic Metadata

Semantic metadata captures the meaning and behavior of the code:

- **Type Information**: Detailed type specifications beyond what's needed for execution
- **Behavioral Contracts**: Pre/post-conditions, invariants, and other behavioral specifications
- **Effect Annotations**: Side effects, purity, and other computational effect information
- **Semantic Tags**: Domain-specific semantic annotations

### 3. Intent Metadata

Intent metadata preserves the human design decisions and rationale:

- **Purpose Annotations**: Why a particular component exists
- **Design Rationale**: Why specific implementation choices were made
- **Constraints**: Business rules, performance requirements, and other constraints
- **Natural Language Descriptions**: Human-readable explanations

### 4. Provenance Metadata

Provenance metadata tracks the history and origin of the code:

- **Source Mappings**: Links to original source code
- **Transformation History**: Record of applied transformations
- **Authorship Information**: Who created or modified the code
- **Version Information**: Version and timestamp data

## Schema Structure

Each metadata category is structured as a hierarchical schema:

```
Metadata
├── Structural
│   ├── Entities
│   │   ├── Variables
│   │   ├── Functions
│   │   ├── Types
│   │   └── ...
│   ├── Dependencies
│   ├── Scopes
│   └── ControlFlow
├── Semantic
│   ├── Types
│   ├── Contracts
│   ├── Effects
│   └── SemanticTags
├── Intent
│   ├── Purpose
│   ├── Rationale
│   ├── Constraints
│   └── Descriptions
└── Provenance
    ├── SourceMappings
    ├── TransformationHistory
    ├── Authorship
    └── VersionInfo
```

## Metadata Representation

Metadata is represented using a combination of:

1. **Structured Records**: JSON-like structures for most metadata
2. **Semantic Graphs**: Graph representations for relationship metadata
3. **Formal Specifications**: Machine-readable formal specifications for contracts and invariants
4. **Natural Language**: Embedded natural language descriptions with semantic annotations

### Example Metadata Record

```json
{
  "id": "func:calculate_total",
  "type": "Function",
  "structural": {
    "signature": {
      "parameters": [{"name": "items", "type": "Array<Item>"}],
      "returnType": "Number",
      "effects": ["reads:items", "pure"]
    },
    "dependencies": ["type:Item", "func:apply_discount"]
  },
  "semantic": {
    "contract": {
      "preconditions": ["items.length > 0", "items.every(i => i.price >= 0)"],
      "postconditions": ["return >= 0"]
    },
    "effects": {
      "purity": "pure",
      "determinism": "deterministic",
      "complexity": "O(n)"
    }
  },
  "intent": {
    "purpose": "Calculate the total price of all items including applicable discounts",
    "rationale": "Uses a loop instead of reduce for better performance with large arrays",
    "constraints": ["Must handle empty arrays", "Must be O(n) or better"]
  },
  "provenance": {
    "source": {"file": "shopping.js", "line": 42},
    "transformations": [
      {"type": "loop_unrolling", "timestamp": "2025-04-01T10:30:00Z"},
      {"type": "constant_folding", "timestamp": "2025-04-01T10:30:01Z"}
    ],
    "author": "AI:GPT-5",
    "version": "1.0.0"
  }
}
```

## Cross-Layer References

Metadata includes references that link elements across the three layers of ANRF:

### Reference Types

1. **Identity References**: Direct one-to-one mappings between elements
2. **Compositional References**: One-to-many or many-to-one mappings
3. **Semantic References**: References based on semantic equivalence rather than structural identity
4. **Constraint References**: References that enforce invariants across layers

### Reference Format

References are represented as URIs with a custom scheme:

```
anrf:[layer]/[category]/[type]/[identifier]
```

Examples:
- `anrf:execution/instruction/add/inst123`: References an add instruction in the execution layer
- `anrf:semantic/type/number/type456`: References a number type in the semantic layer
- `anrf:intent/purpose/calculate_total/func789`: References the purpose of a function in the intent layer

## Storage and Indexing

Metadata is stored using an efficient indexing scheme:

1. **Primary Index**: By unique identifier
2. **Secondary Indices**:
   - By reference (for quick lookup of related elements)
   - By type (for filtering by metadata type)
   - By layer (for layer-specific operations)
3. **Full-text Index**: For natural language descriptions

## Metadata Evolution

The metadata schema supports evolution through:

1. **Schema Versioning**: Explicit versioning of the schema
2. **Extension Points**: Designated points for schema extensions
3. **Compatibility Layers**: Mechanisms for handling schema changes
4. **Migration Tools**: Tools for migrating metadata between schema versions

## Metadata Access API

The metadata schema defines a standard API for accessing and manipulating metadata:

1. **Query Operations**:
   - `getMetadata(id)`: Retrieve metadata by ID
   - `queryMetadata(filter)`: Query metadata using a filter expression
   - `traverseReferences(id, direction)`: Traverse references from/to an element
2. **Modification Operations**:
   - `addMetadata(element)`: Add new metadata
   - `updateMetadata(id, updates)`: Update existing metadata
   - `deleteMetadata(id)`: Delete metadata
3. **Verification Operations**:
   - `verifyConsistency()`: Verify internal consistency of metadata
   - `verifyReferences()`: Verify that all references are valid
   - `verifyConstraints()`: Verify that all constraints are satisfied

## Metadata Serialization

Metadata is serialized using a compact binary format for storage and a JSON-based format for interchange:

1. **Binary Format**:
   - Compact representation for storage
   - Indexed for efficient access
   - Includes compression for large metadata
2. **Interchange Format**:
   - JSON-based for interoperability
   - Includes schema information
   - Supports partial serialization for incremental updates

## Security Considerations

The metadata schema includes security features:

1. **Integrity Protection**: Cryptographic signatures to detect tampering
2. **Access Control**: Metadata-level access control for sensitive information
3. **Privacy Annotations**: Annotations for privacy-sensitive metadata
4. **Provenance Tracking**: Secure tracking of metadata modifications

## Integration with Formal Verification

The metadata schema is designed to support formal verification:

1. **Verification Conditions**: Metadata includes verification conditions for formal proofs
2. **Invariant Specifications**: Formal specifications of invariants that must be preserved
3. **Proof Hints**: Hints for automated theorem provers
4. **Verification Status**: Tracking of verification status for different properties