# AI-Native Representation Format (ANRF) Specification - v1

## Overview
This document defines the AI-Native Representation Format (ANRF), a structured representation designed to balance machine optimization with semantic preservation. This v1 specification is stable for Phase 1 (Internal Dogfooding) implementation.

## Core Principles
- **Layered Structure**: Separates execution code from semantic information
- **Bidirectional References**: Maintains connections between layers
- **Semantic Preservation**: Retains intent and meaning alongside optimized code
- **Verification Support**: Enables formal analysis and correctness checking
- **Extensibility**: Allows for evolution while maintaining backward compatibility

## Format Structure

### 1. Layered Architecture

ANRF uses a three-layer architecture:

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

#### 1.1 Intent Layer
Contains high-level intent, design decisions, and requirements that drove the code generation.

#### 1.2 Semantic Layer
Maps between intent and execution, containing relationships, types, and constraints.

#### 1.3 Execution Layer
Contains optimized code ready for execution, focusing on performance.

##### Execution Modes and Runtime Integration (v1.1, Material Change)

The execution layer now explicitly supports multiple execution modes:
- **Interpretation**: Direct execution of ANRF for rapid prototyping and debugging.
- **Just-In-Time (JIT) Compilation**: Runtime compilation to intermediate representations (e.g., WASM, Python bytecode).
- **Ahead-of-Time (AOT) Compilation**: Static compilation to native or platform-specific binaries for production.

**Sandboxing and Resource Limits**: Execution metadata must specify sandboxing requirements and resource quotas (CPU, memory, I/O) to ensure secure and isolated execution.

**Runtime Policy Enforcement**: Properties can specify runtime security policies (e.g., network/file access restrictions) and audit logging requirements.

**Execution Hooks**: The execution layer supports pre- and post-execution hooks for verification and monitoring, referenced in execution metadata.

These changes are material and require cascade validation across verification, security, and tooling documentation.

### 2. Concrete Format Definition (v1)

For Phase 1, ANRF is serialized using Protocol Buffers (protobuf) for efficient binary representation with good language support.

```protobuf
syntax = "proto3";

message ANRF {
  string anrf_id = 1;          // Unique identifier
  string version = 2;          // Format version (v1)
  IntentLayer intent = 3;      // Intent layer
  SemanticLayer semantic = 4;  // Semantic layer
  ExecutionLayer execution = 5; // Execution layer
  map<string, string> metadata = 6; // Additional metadata
}

message IntentLayer {
  string intent_type = 1;      // E.g., "function", "class", "module"
  string description = 2;      // Natural language description
  repeated Constraint constraints = 3; // Explicit constraints
  repeated string tags = 4;    // Categorization tags
  map<string, string> properties = 5; // Additional properties
}

message Constraint {
  string type = 1;             // Constraint type
  string description = 2;      // Human-readable description
  string formal_spec = 3;      // Optional formal specification
}

message SemanticLayer {
  repeated Node nodes = 1;     // Semantic graph nodes
  repeated Edge edges = 2;     // Semantic graph edges
  repeated TypeDef types = 3;  // Type definitions
  map<string, string> symbol_table = 4; // Symbol references
}

message Node {
  string node_id = 1;          // Unique node identifier
  string node_type = 2;        // Node type (e.g., "variable", "function", "expression")
  string label = 3;            // Human-readable label
  map<string, string> properties = 4; // Node properties
  repeated string execution_refs = 5; // References to execution layer
  repeated string intent_refs = 6;    // References to intent layer
}

message Edge {
  string edge_id = 1;          // Unique edge identifier
  string source_id = 2;        // Source node ID
  string target_id = 3;        // Target node ID
  string edge_type = 4;        // Edge type (e.g., "calls", "depends_on", "contains")
  map<string, string> properties = 5; // Edge properties
}

message TypeDef {
  string type_id = 1;          // Type identifier
  string name = 2;             // Type name
  string type_kind = 3;        // E.g., "primitive", "struct", "function", "union"
  repeated TypeField fields = 4; // For composite types
  string parent_type = 5;      // For inheritance
  map<string, string> properties = 6; // Type properties
}

message TypeField {
  string name = 1;             // Field name
  string type_id = 2;          // Type reference
  bool optional = 3;           // Whether field is optional
  map<string, string> properties = 4; // Field properties
}

message ExecutionLayer {
  string format = 1;           // Execution format (e.g., "graph", "bytecode", "ir")
  bytes code = 2;              // Actual execution code in binary format
  repeated ExecNode nodes = 3; // For graph-based representation
  repeated ExecEdge edges = 4; // For graph-based representation
  map<string, string> properties = 5; // Execution properties
}

message ExecNode {
  string node_id = 1;          // Unique node identifier
  string operation = 2;        // Operation type
  repeated string inputs = 3;  // Input references
  repeated string outputs = 4; // Output references
  map<string, string> properties = 5; // Operation properties
}

message ExecEdge {
  string edge_id = 1;          // Unique edge identifier
  string source_id = 2;        // Source node ID
  string target_id = 3;        // Target node ID
  string edge_type = 4;        // Edge type
  map<string, string> properties = 5; // Edge properties
}
```

### 3. Metadata Schema

#### 3.1 Intent Layer Metadata
- **Intent Type**: Function, class, module, etc.
- **Description**: Natural language description of intent
- **Constraints**: Explicit constraints (performance, security, etc.)
- **Tags**: Categorization and search tags
- **Properties**: Additional key-value properties

#### 3.2 Semantic Layer Metadata
- **Nodes**: Semantic graph nodes (variables, functions, expressions)
- **Edges**: Relationships between nodes (calls, depends_on, contains)
- **Types**: Type definitions and relationships
- **Symbol Table**: Mapping of symbols to nodes

#### 3.3 Execution Layer Metadata
- **Format**: Execution representation format
- **Code**: Binary representation of executable code
- **Nodes/Edges**: For graph-based execution representations
- **Properties**: Execution-specific properties, including:
  - `execution_mode`: "interpretation", "jit", or "aot"
  - `sandboxing`: Boolean or configuration object
  - `resource_limits`: Object specifying CPU, memory, I/O quotas
  - `runtime_policies`: Security and access control policies
  - `execution_hooks`: References to pre/post-execution verification or monitoring hooks

### 4. Cross-Layer References

References between layers are maintained through IDs:
- Intent layer elements reference semantic nodes via node IDs
- Semantic nodes reference execution elements via execution_refs
- Execution elements can reference semantic nodes via properties

## Validation Rules

### 1. Structural Validation
- All required fields must be present
- IDs must be unique within their scope
- References must point to existing elements

### 2. Semantic Validation
- Type references must be valid
- Graph must not contain cycles (unless explicitly allowed)
- Symbol references must resolve to valid nodes

### 3. Cross-Layer Validation
- Cross-layer references must be valid
- Semantic layer must completely cover execution layer
- Intent constraints must be verifiable against semantic layer

## Example ANRF Instance

### Simple Function Example

```json
{
  "anrf_id": "func_123456",
  "version": "v1",
  "intent": {
    "intent_type": "function",
    "description": "Calculate the sum of an array of numbers",
    "constraints": [
      {
        "type": "performance",
        "description": "Linear time complexity O(n)"
      },
      {
        "type": "safety",
        "description": "Handle empty arrays gracefully"
      }
    ],
    "tags": ["math", "array", "utility"],
    "properties": {
      "author": "AI",
      "created_at": "2025-04-07T01:00:00Z"
    }
  },
  "semantic": {
    "nodes": [
      {
        "node_id": "func_sum",
        "node_type": "function",
        "label": "sum",
        "properties": {
          "return_type": "type_number"
        },
        "execution_refs": ["exec_node_1"],
        "intent_refs": []
      },
      {
        "node_id": "param_numbers",
        "node_type": "parameter",
        "label": "numbers",
        "properties": {
          "type": "type_number_array"
        },
        "execution_refs": ["exec_node_2"],
        "intent_refs": []
      },
      {
        "node_id": "var_result",
        "node_type": "variable",
        "label": "result",
        "properties": {
          "type": "type_number"
        },
        "execution_refs": ["exec_node_3"],
        "intent_refs": []
      }
    ],
    "edges": [
      {
        "edge_id": "edge_1",
        "source_id": "func_sum",
        "target_id": "param_numbers",
        "edge_type": "has_parameter"
      },
      {
        "edge_id": "edge_2",
        "source_id": "func_sum",
        "target_id": "var_result",
        "edge_type": "declares"
      }
    ],
    "types": [
      {
        "type_id": "type_number",
        "name": "Number",
        "type_kind": "primitive"
      },
      {
        "type_id": "type_number_array",
        "name": "Number[]",
        "type_kind": "array",
        "fields": [],
        "parent_type": "",
        "properties": {
          "element_type": "type_number"
        }
      }
    ],
    "symbol_table": {
      "sum": "func_sum",
      "numbers": "param_numbers",
      "result": "var_result"
    }
  },
  "execution": {
    "format": "graph",
    "code": "",
    "nodes": [
      {
        "node_id": "exec_node_1",
        "operation": "function_def",
        "inputs": ["exec_node_2"],
        "outputs": ["exec_node_7"],
        "properties": {
          "name": "sum"
        }
      },
      {
        "node_id": "exec_node_2",
        "operation": "parameter",
        "inputs": [],
        "outputs": ["exec_node_4"],
        "properties": {
          "name": "numbers"
        }
      },
      {
        "node_id": "exec_node_3",
        "operation": "variable_def",
        "inputs": [],
        "outputs": ["exec_node_4"],
        "properties": {
          "name": "result",
          "initial_value": "0"
        }
      },
      {
        "node_id": "exec_node_4",
        "operation": "for_each",
        "inputs": ["exec_node_2", "exec_node_3"],
        "outputs": ["exec_node_5", "exec_node_6"],
        "properties": {
          "iterator": "num"
        }
      },
      {
        "node_id": "exec_node_5",
        "operation": "add",
        "inputs": ["exec_node_3", "exec_node_4"],
        "outputs": ["exec_node_3"],
        "properties": {}
      },
      {
        "node_id": "exec_node_6",
        "operation": "end_loop",
        "inputs": ["exec_node_5"],
        "outputs": ["exec_node_7"],
        "properties": {}
      },
      {
        "node_id": "exec_node_7",
        "operation": "return",
        "inputs": ["exec_node_3"],
        "outputs": [],
        "properties": {}
      }
    ],
    "edges": [
      {
        "edge_id": "exec_edge_1",
        "source_id": "exec_node_1",
        "target_id": "exec_node_2",
        "edge_type": "control_flow"
      },
      {
        "edge_id": "exec_edge_2",
        "source_id": "exec_node_2",
        "target_id": "exec_node_3",
        "edge_type": "control_flow"
      },
      {
        "edge_id": "exec_edge_3",
        "source_id": "exec_node_3",
        "target_id": "exec_node_4",
        "edge_type": "control_flow"
      },
      {
        "edge_id": "exec_edge_4",
        "source_id": "exec_node_4",
        "target_id": "exec_node_5",
        "edge_type": "loop_body"
      },
      {
        "edge_id": "exec_edge_5",
        "source_id": "exec_node_5",
        "target_id": "exec_node_6",
        "edge_type": "control_flow"
      },
      {
        "edge_id": "exec_edge_6",
        "source_id": "exec_node_6",
        "target_id": "exec_node_7",
        "edge_type": "control_flow"
      }
    ],
    "properties": {
      "complexity": "O(n)"
    }
  },
  "metadata": {
    "generated_by": "AI",
    "generation_date": "2025-04-07T01:00:00Z",
    "confidence_score": "0.95"
  }
}
```

## Guidelines for Generating Synthetic ANRF Examples

### 1. Start with Intent
1. Define a clear intent (function, class, module)
2. Specify constraints and requirements
3. Add appropriate tags and properties

### 2. Build Semantic Layer
1. Create nodes for functions, parameters, variables
2. Define edges to represent relationships
3. Specify types for all elements
4. Build a complete symbol table

### 3. Construct Execution Layer
1. Choose appropriate execution format (graph recommended for v1)
2. Create execution nodes for operations
3. Connect nodes with edges for control and data flow
4. Ensure references to semantic layer are maintained

### 4. Validate the Example
1. Check structural validity
2. Verify semantic consistency
3. Ensure cross-layer references are valid

### 5. Scaling Approach
For generating 5,000-10,000 examples:
1. Start with template functions covering common patterns
2. Systematically vary:
   - Function complexity (simple to moderate)
   - Parameter types and counts
   - Control flow patterns
   - Data structures used
3. Ensure diversity in intent descriptions and constraints
4. Generate variations programmatically using templates

## Implementation Notes for Phase 1

### Serialization
- Primary: Protocol Buffers (.proto definition provided)
- Alternative: JSON for debugging and human readability

### Storage
- Store in object storage as specified by Systems Architect
- Use naming convention: `anrf/{anrfId}/{version}.anrf`

### Processing Libraries
- Develop Python library for ANRF manipulation:
  - Parsing/serialization
  - Validation
  - Layer access
  - Reference resolution

### Versioning
- Format version: v1
- Individual ANRF version: tracked in metadata

## Future Evolution (Post-Phase 1)
- Enhanced execution layer formats
- Richer semantic relationships
- Formal verification integration
- Performance optimizations
- Extended cross-language support

## Change Log
- 2025-04-07: Created stable v1 ANRF specification for Phase 1 implementation
