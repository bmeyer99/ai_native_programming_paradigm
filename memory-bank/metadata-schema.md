# ANRF Metadata Schema

## Version 1.1.0 (2025-04-11)

This document defines the metadata schema for the AI-Native Representation Format (ANRF), with a focus on the secure-by-default approach. It specifies the structure, validation rules, and relationships between metadata components across all three layers of the ANRF.

## 1. Overview

The ANRF metadata schema provides a comprehensive framework for maintaining semantic information alongside optimized code. With the secure-by-default approach, security metadata is now a mandatory component of the ANRF, ensuring that all code is memory-safe and properly sandboxed by default.

### 1.1 Core Principles

- **Completeness**: Metadata must capture all essential information for understanding, verification, and execution
- **Consistency**: Metadata must be consistent across all three layers (Intent, Semantic, Execution)
- **Verifiability**: Metadata must support formal verification of properties
- **Security-First**: Security metadata is mandatory and enforced by validation rules
- **Extensibility**: Metadata schema can evolve while maintaining backward compatibility

### 1.2 Layer Structure

The ANRF consists of three interconnected layers, each with its own metadata requirements:

- **Intent Layer (IML)**: Captures high-level intent, requirements, and constraints
- **Semantic Layer (SML)**: Defines semantic meaning, relationships, and guarantees
- **Execution Layer (EL)**: Specifies execution details, optimizations, and runtime behavior

## 2. Common Metadata Structure

All ANRF instances must include the following common metadata:

```json
{
  "anrf_version": "1.1.0",
  "creation_timestamp": "2025-04-11T12:00:00Z",
  "creator_id": "string",
  "security": {
    "safety_level": "enum(MemorySafe, TypeSafe, ResourceBounded)",
    "isolation_requirements": {
      "process_isolation": "boolean",
      "memory_isolation": "boolean",
      "resource_limits": {
        "cpu": "number",
        "memory": "number",
        "time": "number",
        "network": "boolean",
        "filesystem": "enum(None, ReadOnly, ReadWrite)"
      }
    },
    "override_status": "boolean",
    "override_justification": "string | null",
    "override_approval": {
      "approver_id": "string | null",
      "approval_timestamp": "string | null",
      "approval_context": "string | null"
    },
    "audit_trail": [
      {
        "event_type": "enum(Creation, Modification, Override, Verification)",
        "timestamp": "string",
        "actor_id": "string",
        "description": "string"
      }
    ]
  },
  "dependencies": [
    {
      "id": "string",
      "version": "string",
      "security_compatibility": "boolean"
    }
  ],
  "verification_status": {
    "verified": "boolean",
    "verification_timestamp": "string | null",
    "verification_method": "string | null",
    "verification_results": "object | null"
  }
}
```

## 3. Intent Layer Metadata (IML)

The Intent Layer metadata captures the high-level intent and requirements, including security intentions:

```json
{
  "intent": {
    "description": "string",
    "requirements": [
      {
        "id": "string",
        "description": "string",
        "type": "enum(Functional, Security, Performance, Reliability)",
        "priority": "enum(Critical, High, Medium, Low)",
        "verification_approach": "string"
      }
    ],
    "security_intentions": {
      "memory_safety_required": "boolean",
      "isolation_required": "boolean",
      "resource_constraints_required": "boolean",
      "override_intention": {
        "allowed": "boolean",
        "conditions": "string | null",
        "justification": "string | null"
      }
    },
    "constraints": [
      {
        "id": "string",
        "description": "string",
        "type": "enum(Security, Performance, Compatibility, Resource)",
        "enforcement_level": "enum(Mandatory, Recommended, Optional)"
      }
    ]
  }
}
```

## 4. Semantic Layer Metadata (SML)

The Semantic Layer metadata defines the semantic meaning and relationships, including formal security properties:

```json
{
  "semantics": {
    "entities": [
      {
        "id": "string",
        "name": "string",
        "type": "string",
        "properties": {
          "property_name": "property_value"
        },
        "security_properties": {
          "memory_safe": "boolean",
          "type_safe": "boolean",
          "resource_bounded": "boolean",
          "formal_guarantees": [
            {
              "property_type": "enum(MemorySafety, TypeSafety, ResourceBounds, DataIsolation)",
              "property_description": "string",
              "verification_approach": "string"
            }
          ]
        }
      }
    ],
    "relationships": [
      {
        "source_id": "string",
        "target_id": "string",
        "type": "string",
        "properties": {
          "property_name": "property_value"
        },
        "security_implications": {
          "information_flow": "enum(None, Controlled, Unrestricted)",
          "privilege_escalation_risk": "boolean",
          "resource_sharing": "boolean"
        }
      }
    ],
    "invariants": [
      {
        "id": "string",
        "description": "string",
        "formal_representation": "string",
        "security_relevance": "boolean"
      }
    ],
    "security_contracts": [
      {
        "id": "string",
        "description": "string",
        "preconditions": ["string"],
        "postconditions": ["string"],
        "invariants": ["string"]
      }
    ]
  }
}
```

## 5. Execution Layer Metadata (EL)

The Execution Layer metadata specifies execution details and runtime behavior, including security enforcement:

```json
{
  "execution": {
    "target_environment": {
      "platform": "string",
      "runtime_version": "string",
      "security_features": {
        "hardware_memory_protection": "boolean",
        "address_space_layout_randomization": "boolean",
        "control_flow_integrity": "boolean",
        "sandboxing_support": "boolean"
      }
    },
    "resource_requirements": {
      "cpu": "number",
      "memory": "number",
      "time_complexity": "string",
      "space_complexity": "string"
    },
    "optimizations": [
      {
        "type": "string",
        "description": "string",
        "security_impact": "enum(None, Low, Medium, High)",
        "security_verification": "string"
      }
    ],
    "security_enforcement": {
      "memory_safety_mechanisms": [
        {
          "mechanism": "enum(BoundsChecking, PointerValidation, MemoryIsolation, GarbageCollection)",
          "scope": "enum(Global, Function, Block)",
          "enforcement_point": "enum(Compilation, JIT, Runtime)"
        }
      ],
      "sandboxing_mechanisms": [
        {
          "mechanism": "enum(ProcessIsolation, MemoryIsolation, ResourceLimiting, CapabilityModel)",
          "scope": "enum(Global, Function, Module)",
          "enforcement_point": "enum(Compilation, JIT, Runtime)"
        }
      ],
      "override_mechanisms": {
        "enabled": "boolean",
        "scope": "enum(Global, Function, Module, Block)",
        "enforcement_point": "enum(Compilation, JIT, Runtime)",
        "audit_requirements": "enum(None, LogOnly, ApprovalRequired)"
      }
    }
  }
}
```

## 6. Validation Rules

The following validation rules enforce the secure-by-default approach:

### 6.1 Common Validation Rules

1. The `anrf_version` field must be present and valid
2. The `security` section must be present and complete
3. The `safety_level` must be specified and valid
4. The `isolation_requirements` must be specified and valid
5. If `override_status` is true, `override_justification` must be non-empty
6. If `override_status` is true, `override_approval` must be complete

### 6.2 Intent Layer Validation Rules

1. The `intent` section must be present and complete
2. The `security_intentions` section must be present and complete
3. If `override_intention.allowed` is true, `override_intention.justification` must be non-empty
4. At least one security-related requirement must be present

### 6.3 Semantic Layer Validation Rules

1. The `semantics` section must be present and complete
2. All entities must have `security_properties` specified
3. All entities must have `memory_safe` set to true by default
4. If any entity has `memory_safe` set to false, the corresponding override must be present in the common metadata
5. At least one formal security guarantee must be present

### 6.4 Execution Layer Validation Rules

1. The `execution` section must be present and complete
2. The `security_enforcement` section must be present and complete
3. At least one `memory_safety_mechanism` must be specified
4. At least one `sandboxing_mechanism` must be specified
5. If `override_mechanisms.enabled` is true, it must match the `override_status` in the common metadata

## 7. Cross-Layer Validation Rules

1. Security properties must be consistent across all three layers
2. Override status must be consistent across all three layers
3. Security enforcement mechanisms must align with security properties
4. Verification status must be consistent with security properties

## 8. Migration Guidance

For existing ANRF instances created before version 1.1.0:

1. Add the mandatory `security` section to the common metadata
2. Set `safety_level` to "MemorySafe" by default
3. Configure `isolation_requirements` based on the code's behavior
4. Set `override_status` to false by default
5. Add `security_intentions` to the Intent Layer
6. Add `security_properties` to all entities in the Semantic Layer
7. Add `security_enforcement` to the Execution Layer
8. Run validation to ensure all security-related fields are properly set
9. If validation fails, review and update the security properties or add appropriate overrides with justification

## 9. Example ANRF Instance

```json
{
  "anrf_version": "1.1.0",
  "creation_timestamp": "2025-04-11T12:00:00Z",
  "creator_id": "ai-model-v3",
  "security": {
    "safety_level": "MemorySafe",
    "isolation_requirements": {
      "process_isolation": true,
      "memory_isolation": true,
      "resource_limits": {
        "cpu": 1.0,
        "memory": 256,
        "time": 1000,
        "network": false,
        "filesystem": "ReadOnly"
      }
    },
    "override_status": false,
    "override_justification": null,
    "override_approval": {
      "approver_id": null,
      "approval_timestamp": null,
      "approval_context": null
    },
    "audit_trail": [
      {
        "event_type": "Creation",
        "timestamp": "2025-04-11T12:00:00Z",
        "actor_id": "ai-model-v3",
        "description": "Initial creation with secure-by-default settings"
      }
    ]
  },
  "dependencies": [],
  "verification_status": {
    "verified": true,
    "verification_timestamp": "2025-04-11T12:01:00Z",
    "verification_method": "static-analysis",
    "verification_results": {
      "memory_safety_verified": true,
      "resource_bounds_verified": true
    }
  },
  "intent": {
    "description": "A secure string processing function",
    "requirements": [
      {
        "id": "REQ-001",
        "description": "Process strings securely without buffer overflows",
        "type": "Security",
        "priority": "Critical",
        "verification_approach": "Static analysis and formal verification"
      }
    ],
    "security_intentions": {
      "memory_safety_required": true,
      "isolation_required": true,
      "resource_constraints_required": true,
      "override_intention": {
        "allowed": false,
        "conditions": null,
        "justification": null
      }
    },
    "constraints": [
      {
        "id": "CON-001",
        "description": "Must not allocate more than 256MB of memory",
        "type": "Resource",
        "enforcement_level": "Mandatory"
      }
    ]
  },
  "semantics": {
    "entities": [
      {
        "id": "ENT-001",
        "name": "processString",
        "type": "Function",
        "properties": {
          "input_type": "String",
          "output_type": "String",
          "pure": true
        },
        "security_properties": {
          "memory_safe": true,
          "type_safe": true,
          "resource_bounded": true,
          "formal_guarantees": [
            {
              "property_type": "MemorySafety",
              "property_description": "No buffer overflows or out-of-bounds access",
              "verification_approach": "Static analysis"
            }
          ]
        }
      }
    ],
    "relationships": [],
    "invariants": [
      {
        "id": "INV-001",
        "description": "Output string length is always less than or equal to input string length",
        "formal_representation": "len(output) <= len(input)",
        "security_relevance": true
      }
    ],
    "security_contracts": [
      {
        "id": "SEC-001",
        "description": "String processing maintains memory safety",
        "preconditions": ["input != null"],
        "postconditions": ["output != null", "no memory safety violations"],
        "invariants": ["INV-001"]
      }
    ]
  },
  "execution": {
    "target_environment": {
      "platform": "any",
      "runtime_version": "1.0",
      "security_features": {
        "hardware_memory_protection": true,
        "address_space_layout_randomization": true,
        "control_flow_integrity": true,
        "sandboxing_support": true
      }
    },
    "resource_requirements": {
      "cpu": 0.1,
      "memory": 10,
      "time_complexity": "O(n)",
      "space_complexity": "O(n)"
    },
    "optimizations": [],
    "security_enforcement": {
      "memory_safety_mechanisms": [
        {
          "mechanism": "BoundsChecking",
          "scope": "Function",
          "enforcement_point": "Runtime"
        }
      ],
      "sandboxing_mechanisms": [
        {
          "mechanism": "ProcessIsolation",
          "scope": "Global",
          "enforcement_point": "Runtime"
        }
      ],
      "override_mechanisms": {
        "enabled": false,
        "scope": "Function",
        "enforcement_point": "Compilation",
        "audit_requirements": "ApprovalRequired"
      }
    }
  }
}
```

## 10. Conclusion

This metadata schema establishes security as a first-class concern in the ANRF, making memory safety and sandboxing the default for all code. By requiring explicit security metadata and enforcing validation rules, we ensure that all ANRF instances adhere to the secure-by-default approach while maintaining the flexibility needed for exceptional cases through explicit, auditable override mechanisms.

The schema is designed to evolve over time while maintaining backward compatibility, allowing for the incorporation of new security features and requirements as they emerge. The migration guidance provides a clear path for updating existing ANRF instances to comply with the new security requirements.