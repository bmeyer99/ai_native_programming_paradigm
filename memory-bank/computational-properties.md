# Computational Properties of the AI-Native Programming Paradigm

## Based on Initial Formal Model (2025-04-06)

### Expressiveness
- **Intent Space (`I`):** Must support a wide range, from high-level goals to specific algorithms. Formalizing this range is a challenge.
- **Representation Space (`R`):** Needs to encode highly optimized machine-level operations, potentially exceeding standard IRs. Must support necessary metadata for AI and human understanding.
- **Goal:** Ensure `R` is expressive enough to capture efficient implementations for all intents expressible in `I`.

### Complexity
- **Generation (`Gen: I -> P(R)`):** Expected to be computationally expensive (AI-driven). Complexity depends heavily on AI model and intent complexity.
- **Optimization (`Opt: R -> R`):** Also potentially expensive, involving complex analyses and transformations. Composition of multiple optimization steps.
- **Viewing (`View: R -> H`):** Should ideally be efficient to allow responsive on-demand generation of human-readable views. Complexity depends on the target view's abstraction level.
- **Verification:** Checking semantic equivalence (`≈`) and refinement (`⊑`) is computationally hard, likely undecidable in general. Practical verification complexity depends on the chosen methods (model checking, type checking, abstract interpretation, theorem proving) and the complexity of the representations being analyzed.

### Decidability
- **Semantic Equivalence (`≈`):** Undecidable in the general case for Turing-complete representations (Rice's Theorem).
- **Refinement (`⊑`):** Also generally undecidable.
- **Implications:** Full formal verification requires restricting the representation language `R`, using sound approximations, focusing on specific properties, or relying on interactive methods.

### Comparison to Established Models
- **Draws from:** Compiler theory (semantics, optimization), formal methods (verification, refinement), AI (generation, explanation).
- **Key Difference:** The canonical form is the optimized representation (`R`), not human-readable source code. Human views (`H`) are derived. This shifts the focus of formal analysis and tooling.

## Open Questions
- How to formally characterize the expressiveness of the Intent space `I`?
- What are the precise complexity bounds for core transformations (`Gen`, `Opt`, `View`) under different AI models and representation choices?
- What decidable fragments of semantic equivalence and refinement are most useful for this paradigm?