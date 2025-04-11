# Directive to Language Designer: ANRF Updates for Secure-by-Default

## Context

The Security Specialist has proposed a fundamental shift in our approach to memory safety and sandboxing, moving from an opt-in model to a secure-by-default approach. This has been approved as a core architectural decision, and the Systems Architect is currently updating the execution model to enforce this approach.

Your ANRF specification (completed on 2025-04-07) needs to be updated to support this secure-by-default approach. The current specification allows for security metadata but doesn't require it or treat it as a mandatory component.

## Task

Update the ANRF specification to encode safety and sandboxing metadata as required fields rather than optional ones. Specifically:

1. Revise the metadata schema to include mandatory security fields
2. Update validation rules to enforce security requirements
3. Ensure bidirectional references maintain safety context across all three layers
4. Design explicit override metadata fields that require justification
5. Update example ANRF instances to demonstrate secure-by-default behavior

## Considerations

- **Backward Compatibility**: Consider how these changes affect existing ANRF instances and provide migration guidance
- **Validation Rules**: Define clear validation rules that treat absence of security metadata as an error
- **Override Metadata**: Design metadata fields for explicit overrides that capture justification and audit information
- **Intent Expression**: Ensure the Intent Layer (IML) can express security requirements and override intentions
- **Semantic Constraints**: Define how security properties are formally represented in the Semantic Layer (SML)
- **Execution Metadata**: Specify how security requirements are encoded in the Execution Layer (EL)

## Expected Outcome

- Updated ANRF specification with secure-by-default as a core requirement
- Revised metadata schema with mandatory security fields
- Enhanced validation rules that enforce security requirements
- Example ANRF instances demonstrating secure-by-default behavior
- Migration guidance for existing ANRF instances

## Handoff Guidance

Upon completion, provide the following handoffs:

1. **To AI Integration Specialist**: Updated ANRF specification for training AI models to generate secure-by-default code
2. **To Tool Ecosystem Engineer**: Validation rules for verifying security requirements in ANRF instances
3. **To Developer Experience Designer**: Metadata schema for displaying security status in the UI
4. **To Systems Architect**: Execution metadata specifications for enforcing security at runtime
5. **To Paradigm Orchestrator**: Comprehensive ANRF update report

## Timeline

Please coordinate with the Systems Architect who is currently updating the execution model. Your updates should be completed within two weeks to align with the overall secure-by-default implementation timeline.

## References

- Security Specialist contribution (2025-04-11)
- Systems Architect directive for secure-by-default (memory-bank/directives/systems-architect-secure-by-default.md)
- Current ANRF specification (completed 2025-04-07)
- Integration Map (memory-bank/integration-map.md)
- Decision Log entry on secure-by-default (memory-bank/decision-log.md)

---

Issued by: Paradigm Orchestrator
Date: 2025-04-11