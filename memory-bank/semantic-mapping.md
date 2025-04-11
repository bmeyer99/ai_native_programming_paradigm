# Semantic Mapping for ANRF

## Version 1.1.0 (2025-04-11)

This document defines how meaning is preserved in the AI-Native Representation Format (ANRF), with a focus on the secure-by-default approach. It specifies the mapping between intent and encoded form, behavioral guarantees, and verification approaches.

## 1. Overview

Semantic mapping in ANRF ensures that meaning and intent are preserved across all three layers (Intent, Semantic, Execution) and throughout transformations. With the secure-by-default approach, security properties are now first-class citizens in this mapping, ensuring that security guarantees are maintained throughout the representation lifecycle.

### 1.1 Core Principles

- **Semantic Fidelity**: The meaning of code must be preserved across all representations
- **Intent Preservation**: High-level intent must be traceable to low-level implementation
- **Security Preservation**: Security properties must be preserved during all transformations
- **Verification Support**: Semantic mapping must support formal verification of properties
- **Bidirectional Mapping**: Transformations must be reversible with minimal information loss

### 1.2 Semantic Layers

The ANRF semantic mapping spans three interconnected layers:

- **Intent Layer (IML)**: High-level intent, requirements, and constraints
- **Semantic Layer (SML)**: Formal semantic meaning, relationships, and guarantees
- **Execution Layer (EL)**: Concrete implementation and runtime behavior

## 2. Security Property Mapping

Security properties are mapped across all three layers to ensure consistent enforcement:

### 2.1 Memory Safety Mapping

| Intent Layer | Semantic Layer | Execution Layer |
|--------------|----------------|-----------------|
| `memory_safety_required` flag | `memory_safe` property on entities | Memory safety enforcement mechanisms |
| Memory safety requirements | Formal memory safety guarantees | Bounds checking, pointer validation |
| Memory safety constraints | Memory safety invariants | Memory isolation implementation |

### 2.2 Sandboxing Mapping

| Intent Layer | Semantic Layer | Execution Layer |
|--------------|----------------|-----------------|
| `isolation_required` flag | Isolation properties on entities | Sandboxing enforcement mechanisms |
| Resource constraint requirements | Resource bound guarantees | Resource limit implementation |
| Isolation constraints | Isolation invariants | Process/memory isolation implementation |

### 2.3 Override Mapping

| Intent Layer | Semantic Layer | Execution Layer |
|--------------|----------------|-----------------|
| `override_intention` | Override properties on affected entities | Override mechanism implementation |
| Override conditions | Formal override constraints | Runtime override enforcement |
| Override justification | Semantic implications of override | Audit logging implementation |

## 3. Cross-Layer Semantic Preservation

### 3.1 Intent to Semantic Mapping

The mapping from Intent Layer to Semantic Layer ensures that high-level security requirements are translated into formal semantic properties:

```
map_intent_to_semantic(intent) {
  semantic = new SemanticLayer()
  
  // Map security intentions to semantic properties
  for each entity in semantic.entities {
    entity.security_properties.memory_safe = intent.security_intentions.memory_safety_required
    entity.security_properties.resource_bounded = intent.security_intentions.resource_constraints_required
    
    // Add formal guarantees based on security intentions
    if (intent.security_intentions.memory_safety_required) {
      entity.security_properties.formal_guarantees.add(
        new FormalGuarantee(
          type: "MemorySafety",
          description: "No buffer overflows or out-of-bounds access",
          verification_approach: "Static analysis"
        )
      )
    }
    
    // Map override intentions
    if (intent.security_intentions.override_intention.allowed) {
      entity.override_status = true
      entity.override_justification = intent.security_intentions.override_intention.justification
    }
  }
  
  // Map security constraints to invariants
  for each constraint in intent.constraints {
    if (constraint.type == "Security" || constraint.type == "Resource") {
      semantic.invariants.add(
        new Invariant(
          description: constraint.description,
          security_relevance: true
        )
      )
    }
  }
  
  return semantic
}
```

### 3.2 Semantic to Execution Mapping

The mapping from Semantic Layer to Execution Layer ensures that formal security properties are implemented with concrete enforcement mechanisms:

```
map_semantic_to_execution(semantic) {
  execution = new ExecutionLayer()
  
  // Map security properties to enforcement mechanisms
  execution.security_enforcement.memory_safety_mechanisms = []
  execution.security_enforcement.sandboxing_mechanisms = []
  
  for each entity in semantic.entities {
    if (entity.security_properties.memory_safe) {
      execution.security_enforcement.memory_safety_mechanisms.add(
        new MemorySafetyMechanism(
          mechanism: "BoundsChecking",
          scope: entity.type == "Function" ? "Function" : "Global",
          enforcement_point: "Runtime"
        )
      )
    }
    
    if (entity.security_properties.resource_bounded) {
      execution.security_enforcement.sandboxing_mechanisms.add(
        new SandboxingMechanism(
          mechanism: "ResourceLimiting",
          scope: entity.type == "Function" ? "Function" : "Global",
          enforcement_point: "Runtime"
        )
      )
    }
    
    // Map override status
    execution.security_enforcement.override_mechanisms.enabled = 
      entity.security_properties.hasOverride()
    
    if (execution.security_enforcement.override_mechanisms.enabled) {
      execution.security_enforcement.override_mechanisms.scope = 
        entity.type == "Function" ? "Function" : "Global"
      execution.security_enforcement.override_mechanisms.audit_requirements = 
        "ApprovalRequired"
    }
  }
  
  // Map invariants to runtime checks
  for each invariant in semantic.invariants {
    if (invariant.security_relevance) {
      // Add runtime verification for security invariants
      execution.verification_hooks.add(
        new VerificationHook(
          condition: invariant.formal_representation,
          enforcement_point: "Runtime",
          action: "EnforceOrTerminate"
        )
      )
    }
  }
  
  return execution
}
```

### 3.3 Bidirectional References

Bidirectional references ensure that security context is maintained across all three layers:

```
establish_bidirectional_references(intent, semantic, execution) {
  // Create references from Intent to Semantic
  for each requirement in intent.requirements {
    if (requirement.type == "Security") {
      requirement.semantic_references = 
        semantic.entities.filter(e => e.security_properties.relates_to(requirement))
    }
  }
  
  // Create references from Semantic to Execution
  for each entity in semantic.entities {
    entity.execution_references = 
      execution.security_enforcement.mechanisms.filter(m => m.applies_to(entity))
  }
  
  // Create references from Execution to Semantic
  for each mechanism in execution.security_enforcement.mechanisms {
    mechanism.semantic_references = 
      semantic.entities.filter(e => mechanism.applies_to(e))
  }
  
  // Create references from Semantic to Intent
  for each entity in semantic.entities {
    entity.intent_references = 
      intent.requirements.filter(r => r.semantic_references.includes(entity))
  }
}
```

## 4. Security Property Preservation During Transformations

### 4.1 Transformation Rules

All transformations must preserve security properties:

1. **Memory Safety Preservation**: Transformations must not introduce memory safety violations
2. **Resource Bound Preservation**: Transformations must not exceed resource constraints
3. **Isolation Preservation**: Transformations must maintain isolation boundaries
4. **Override Preservation**: Transformations must preserve override status and justification

### 4.2 Transformation Verification

Each transformation must be verified for security property preservation:

```
verify_transformation_security(original, transformed) {
  // Verify memory safety preservation
  assert(transformed.all_entities_memory_safe() || 
         (original.has_memory_safety_override() && transformed.has_memory_safety_override()))
  
  // Verify resource bound preservation
  assert(transformed.resource_usage() <= original.resource_constraints())
  
  // Verify isolation preservation
  assert(transformed.maintains_isolation_boundaries(original.isolation_boundaries()))
  
  // Verify override preservation
  assert(transformed.override_status() == original.override_status())
  assert(transformed.override_justification() == original.override_justification())
  
  return true
}
```

### 4.3 Security-Aware Optimization

Optimizations must consider security implications:

```
optimize_with_security(anrf) {
  optimized = clone(anrf)
  
  // Identify optimization opportunities
  opportunities = identify_optimization_opportunities(anrf)
  
  // Filter out optimizations that would compromise security
  safe_opportunities = opportunities.filter(o => !o.compromises_security())
  
  // Apply safe optimizations
  for each opportunity in safe_opportunities {
    optimized = apply_optimization(optimized, opportunity)
    
    // Verify security preservation
    assert(verify_transformation_security(anrf, optimized))
  }
  
  return optimized
}
```

## 5. Formal Verification of Security Properties

### 5.1 Memory Safety Verification

```
verify_memory_safety(anrf) {
  // Static analysis for buffer overflows, out-of-bounds access, etc.
  static_analysis_result = static_analyze_memory_safety(anrf)
  
  // Formal verification of memory safety properties
  formal_verification_result = formally_verify_memory_safety(anrf)
  
  // Combined verification result
  return static_analysis_result && formal_verification_result
}
```

### 5.2 Resource Bound Verification

```
verify_resource_bounds(anrf) {
  // Static analysis for resource usage
  static_analysis_result = static_analyze_resource_usage(anrf)
  
  // Formal verification of resource bounds
  formal_verification_result = formally_verify_resource_bounds(anrf)
  
  // Combined verification result
  return static_analysis_result && formal_verification_result
}
```

### 5.3 Isolation Verification

```
verify_isolation(anrf) {
  // Static analysis for isolation violations
  static_analysis_result = static_analyze_isolation(anrf)
  
  // Formal verification of isolation properties
  formal_verification_result = formally_verify_isolation(anrf)
  
  // Combined verification result
  return static_analysis_result && formal_verification_result
}
```

### 5.4 Override Verification

```
verify_override(anrf) {
  // Verify override justification is present if override is enabled
  if (anrf.security.override_status) {
    assert(anrf.security.override_justification != null && 
           anrf.security.override_justification != "")
    
    // Verify override approval is present
    assert(anrf.security.override_approval.approver_id != null)
    assert(anrf.security.override_approval.approval_timestamp != null)
  }
  
  // Verify override consistency across layers
  assert(anrf.intent.security_intentions.override_intention.allowed == 
         anrf.security.override_status)
  
  for each entity in anrf.semantics.entities {
    assert(entity.security_properties.hasOverride() == 
           anrf.security.override_status)
  }
  
  assert(anrf.execution.security_enforcement.override_mechanisms.enabled == 
         anrf.security.override_status)
  
  return true
}
```

## 6. Handling Ambiguity and Partial Information

### 6.1 Default Security Behavior

When security information is ambiguous or partial, the system defaults to the most secure behavior:

```
resolve_security_ambiguity(anrf) {
  // Default to memory safety if not specified
  if (anrf.security.safety_level == null) {
    anrf.security.safety_level = "MemorySafe"
  }
  
  // Default to isolation if not specified
  if (anrf.security.isolation_requirements == null) {
    anrf.security.isolation_requirements = {
      process_isolation: true,
      memory_isolation: true,
      resource_limits: {
        cpu: 1.0,
        memory: 256,
        time: 1000,
        network: false,
        filesystem: "ReadOnly"
      }
    }
  }
  
  // Default to no override if not specified
  if (anrf.security.override_status == null) {
    anrf.security.override_status = false
  }
  
  return anrf
}
```

### 6.2 Security Property Inference

When security properties are not explicitly specified, they can be inferred from the code:

```
infer_security_properties(anrf) {
  // Analyze code to infer memory safety properties
  memory_safety_analysis = analyze_memory_safety(anrf)
  
  // Analyze code to infer resource usage
  resource_usage_analysis = analyze_resource_usage(anrf)
  
  // Update ANRF with inferred properties
  for each entity in anrf.semantics.entities {
    if (entity.security_properties == null) {
      entity.security_properties = {
        memory_safe: memory_safety_analysis.is_memory_safe(entity),
        resource_bounded: resource_usage_analysis.is_resource_bounded(entity)
      }
    }
  }
  
  return anrf
}
```

## 7. Example Semantic Mapping

### 7.1 Intent Layer Example

```json
{
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
    }
  }
}
```

### 7.2 Semantic Layer Example

```json
{
  "semantics": {
    "entities": [
      {
        "id": "ENT-001",
        "name": "processString",
        "type": "Function",
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
        },
        "intent_references": ["REQ-001"]
      }
    ],
    "invariants": [
      {
        "id": "INV-001",
        "description": "Output string length is always less than or equal to input string length",
        "formal_representation": "len(output) <= len(input)",
        "security_relevance": true
      }
    ]
  }
}
```

### 7.3 Execution Layer Example

```json
{
  "execution": {
    "security_enforcement": {
      "memory_safety_mechanisms": [
        {
          "mechanism": "BoundsChecking",
          "scope": "Function",
          "enforcement_point": "Runtime",
          "semantic_references": ["ENT-001"]
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

## 8. Migration Guidance

For existing ANRF instances created before version 1.1.0:

1. Analyze the code to infer security properties
2. Add security properties to all entities in the Semantic Layer
3. Add security enforcement mechanisms to the Execution Layer
4. Establish bidirectional references for security properties
5. Verify security property consistency across all three layers
6. If verification fails, either:
   a. Fix the security issues to comply with secure-by-default
   b. Add appropriate overrides with justification and approval

## 9. Conclusion

This semantic mapping ensures that security properties are preserved across all three layers of the ANRF and throughout transformations. By making security a first-class citizen in the semantic mapping, we ensure that the secure-by-default approach is consistently enforced throughout the representation lifecycle.

The bidirectional references and formal verification approaches provide strong guarantees about security property preservation, while the handling of ambiguity and partial information ensures that the system defaults to the most secure behavior when information is missing.