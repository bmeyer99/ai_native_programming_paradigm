# Debugging Framework for AI-Native Programming Paradigm

## Version 1.1.0 (2025-04-11)

This document defines the debugging framework for the AI-Native Programming Paradigm, with a focus on the secure-by-default approach. It specifies how developers identify and fix issues in optimized code, including security-related debugging.

## 1. Overview

The debugging framework provides a comprehensive approach to identifying and fixing issues in AI-native optimized code. With the secure-by-default approach, security-aware debugging is now a core component of the framework, ensuring that developers can effectively debug security properties, overrides, and related issues.

### 1.1 Core Principles

- **Multi-Layer Visibility**: Debugging must provide visibility across all representation layers
- **Semantic Debugging**: Debugging should operate on semantic meaning, not just syntax
- **Security Awareness**: Debugging tools must understand and visualize security properties
- **Intent Preservation**: Debugging should maintain connection to original intent
- **Developer Familiarity**: Debugging interfaces should leverage familiar mental models

### 1.2 Debugging Layers

The debugging framework consists of four interconnected layers:

- **Intent Layer Debugging**: Debugging at the level of developer intent and requirements
- **Semantic Layer Debugging**: Debugging at the level of semantic meaning and relationships
- **Execution Layer Debugging**: Debugging at the level of execution details and runtime behavior
- **Cross-Layer Debugging**: Debugging that spans multiple layers to trace issues

## 2. Security-Aware Debugging

### 2.1 Memory Safety Debugging

The debugging framework provides specialized tools for debugging memory safety issues:

1. **Memory Access Visualization**:
   - Visual representation of memory access patterns
   - Highlighting of bounds-checked vs. unchecked access
   - Visualization of memory allocation and deallocation
   - Tracking of pointer operations and lifetimes

2. **Memory Safety Violation Detection**:
   - Detection of potential buffer overflows
   - Identification of use-after-free vulnerabilities
   - Detection of memory leaks
   - Identification of uninitialized memory access

3. **Memory Safety Override Inspection**:
   - Visualization of memory safety overrides
   - Inspection of override justification and approval
   - Analysis of override impact on memory safety
   - Verification of override scope and constraints

4. **Memory Safety Remediation**:
   - Suggestions for fixing memory safety issues
   - Automatic generation of memory-safe alternatives
   - Guided refactoring for memory safety
   - Pattern-based memory safety improvements

### 2.2 Resource Constraint Debugging

Tools for debugging resource constraint issues:

1. **Resource Usage Visualization**:
   - Visual representation of resource consumption
   - Tracking of resource allocation and release
   - Visualization of resource usage patterns
   - Comparison with defined resource constraints

2. **Resource Constraint Violation Detection**:
   - Detection of resource exhaustion
   - Identification of unbounded resource usage
   - Detection of resource leaks
   - Identification of inefficient resource usage

3. **Resource Constraint Override Inspection**:
   - Visualization of resource constraint overrides
   - Inspection of override justification and approval
   - Analysis of override impact on resource usage
   - Verification of override scope and constraints

4. **Resource Constraint Remediation**:
   - Suggestions for fixing resource constraint issues
   - Automatic generation of resource-efficient alternatives
   - Guided refactoring for resource efficiency
   - Pattern-based resource optimization

### 2.3 Sandboxing Debugging

Tools for debugging sandboxing and isolation issues:

1. **Isolation Boundary Visualization**:
   - Visual representation of isolation boundaries
   - Tracking of cross-boundary interactions
   - Visualization of permission requirements
   - Mapping of resource access patterns

2. **Isolation Violation Detection**:
   - Detection of sandbox escape attempts
   - Identification of unauthorized resource access
   - Detection of privilege escalation
   - Identification of isolation boundary weaknesses

3. **Sandboxing Override Inspection**:
   - Visualization of sandboxing overrides
   - Inspection of override justification and approval
   - Analysis of override impact on isolation
   - Verification of override scope and constraints

4. **Sandboxing Remediation**:
   - Suggestions for fixing isolation issues
   - Automatic generation of properly sandboxed alternatives
   - Guided refactoring for improved isolation
   - Pattern-based isolation improvements

### 2.4 Security Verification Debugging

Tools for debugging security verification issues:

1. **Verification Result Visualization**:
   - Visual representation of verification results
   - Highlighting of verification failures
   - Visualization of verification coverage
   - Tracking of verification history

2. **Verification Failure Analysis**:
   - Root cause analysis for verification failures
   - Identification of verification gaps
   - Detection of inconsistent security properties
   - Analysis of verification tool limitations

3. **Verification Override Inspection**:
   - Visualization of verification overrides
   - Inspection of override justification and approval
   - Analysis of override impact on verification
   - Verification of override scope and constraints

4. **Verification Remediation**:
   - Suggestions for fixing verification issues
   - Automatic generation of verifiable alternatives
   - Guided refactoring for verification
   - Pattern-based verification improvements

## 3. Layer-Specific Debugging

### 3.1 Intent Layer Debugging

Debugging at the level of developer intent:

1. **Intent Inspection**:
   - Visualization of security intentions
   - Inspection of security requirements
   - Analysis of security constraints
   - Verification of intent consistency

2. **Intent-Implementation Gap Analysis**:
   - Detection of mismatches between intent and implementation
   - Identification of unimplemented security requirements
   - Detection of security requirement conflicts
   - Analysis of security requirement feasibility

3. **Intent Refinement**:
   - Suggestions for clarifying security intentions
   - Automatic generation of more precise security requirements
   - Guided refinement of security constraints
   - Pattern-based security requirement improvements

4. **Intent Verification**:
   - Verification of security intent consistency
   - Validation of security requirement completeness
   - Checking of security constraint compatibility
   - Analysis of security requirement coverage

### 3.2 Semantic Layer Debugging

Debugging at the level of semantic meaning:

1. **Semantic Property Inspection**:
   - Visualization of security properties
   - Inspection of security guarantees
   - Analysis of security contracts
   - Verification of property consistency

2. **Semantic Relationship Debugging**:
   - Visualization of security-related relationships
   - Inspection of security dependencies
   - Analysis of security property interactions
   - Verification of relationship consistency

3. **Semantic Transformation Debugging**:
   - Tracking of security property transformations
   - Inspection of optimization impact on security
   - Analysis of security property preservation
   - Verification of transformation correctness

4. **Semantic Verification Debugging**:
   - Debugging of formal verification processes
   - Inspection of verification assumptions
   - Analysis of verification limitations
   - Verification of property specifications

### 3.3 Execution Layer Debugging

Debugging at the level of execution details:

1. **Runtime Behavior Inspection**:
   - Visualization of security enforcement at runtime
   - Inspection of security checks and guards
   - Analysis of security exception handling
   - Verification of runtime security behavior

2. **Performance Impact Analysis**:
   - Measurement of security feature performance impact
   - Profiling of security enforcement overhead
   - Analysis of security optimization effectiveness
   - Identification of security performance bottlenecks

3. **Resource Usage Debugging**:
   - Tracking of security feature resource consumption
   - Inspection of security-related memory usage
   - Analysis of security impact on other resources
   - Verification of resource constraint compliance

4. **Exception Handling Debugging**:
   - Debugging of security exception handling
   - Inspection of security error recovery
   - Analysis of security failure modes
   - Verification of security robustness

### 3.4 Cross-Layer Debugging

Debugging that spans multiple layers:

1. **Traceability Debugging**:
   - Tracing security properties across layers
   - Mapping between intent and implementation
   - Linking security guarantees to enforcement
   - Connecting security failures to root causes

2. **Consistency Checking**:
   - Verification of security consistency across layers
   - Detection of layer misalignment
   - Identification of inconsistent security properties
   - Analysis of cross-layer security gaps

3. **Impact Analysis**:
   - Analysis of changes across layers
   - Prediction of change impact on security
   - Verification of change propagation
   - Assessment of security regression risk

4. **Root Cause Analysis**:
   - Cross-layer debugging for security issues
   - Identification of security failure origins
   - Analysis of security issue propagation
   - Determination of appropriate fix level

## 4. Debugging Interfaces

### 4.1 Visual Debugging Interfaces

Visual interfaces for security debugging:

1. **Security Property Visualization**:
   - Visual representation of security properties
   - Color coding for security status
   - Icons for specific security features
   - Visual differentiation for overrides

2. **Security Flow Visualization**:
   - Visual representation of security-related data flow
   - Tracking of security property propagation
   - Visualization of security check execution
   - Mapping of security exception handling

3. **Security Impact Visualization**:
   - Visual representation of security impact
   - Highlighting of security-critical code
   - Visualization of security performance impact
   - Representation of security risk levels

4. **Security Timeline Visualization**:
   - Visual representation of security events over time
   - Tracking of security property changes
   - Visualization of security verification history
   - Representation of security issue evolution

### 4.2 Interactive Debugging Interfaces

Interactive interfaces for security debugging:

1. **Security Breakpoints**:
   - Conditional breakpoints based on security properties
   - Breakpoints for security override activation
   - Breakpoints for security verification failures
   - Breakpoints for security exception handling

2. **Security Watch Expressions**:
   - Watching security property values
   - Monitoring security metadata
   - Tracking security verification status
   - Observing security override state

3. **Security Step Execution**:
   - Stepping through security-critical code
   - Observing security check execution
   - Stepping through security property transformations
   - Navigating security exception handling

4. **Security State Inspection**:
   - Inspection of security property state
   - Examination of security metadata
   - Analysis of security verification state
   - Inspection of security override status

### 4.3 Automated Debugging Interfaces

Automated interfaces for security debugging:

1. **Security Issue Detection**:
   - Automatic detection of security vulnerabilities
   - Identification of security property violations
   - Detection of security verification failures
   - Identification of security override issues

2. **Root Cause Analysis**:
   - Automated analysis of security issue causes
   - Identification of security failure chains
   - Analysis of security property dependencies
   - Determination of security issue origins

3. **Security Fix Suggestions**:
   - Automated suggestions for security fixes
   - Generation of security-compliant alternatives
   - Refactoring suggestions for security improvement
   - Pattern-based security enhancement proposals

4. **Security Regression Testing**:
   - Automated testing for security regressions
   - Verification of security property preservation
   - Testing of security override constraints
   - Validation of security fix effectiveness

### 4.4 Collaborative Debugging Interfaces

Collaborative interfaces for security debugging:

1. **Security Issue Sharing**:
   - Sharing of security debugging sessions
   - Collaborative analysis of security issues
   - Shared visibility of security properties
   - Team-based security debugging

2. **Security Knowledge Sharing**:
   - Sharing of security debugging knowledge
   - Collaborative development of security fixes
   - Team learning from security issues
   - Building of security debugging expertise

3. **Security Review Integration**:
   - Integration with security code review
   - Shared visibility of security concerns
   - Collaborative verification of security fixes
   - Team-based security approval

4. **Security Documentation Integration**:
   - Automatic documentation of security issues
   - Recording of security debugging sessions
   - Documentation of security fixes
   - Building of security knowledge base

## 5. Integration with Development Environment

### 5.1 IDE Integration

Integration with integrated development environments:

1. **Editor Integration**:
   - Inline security debugging information
   - Security property visualization in editor
   - Security issue highlighting
   - Security fix suggestions

2. **Debugger Integration**:
   - Security-aware debugging controls
   - Security property inspection in debugger
   - Security breakpoint management
   - Security state visualization

3. **Problem View Integration**:
   - Security issues in problem view
   - Security verification failures
   - Security override warnings
   - Security fix suggestions

4. **Navigation Integration**:
   - Navigation to security-related code
   - Jumping to security property definitions
   - Finding security override locations
   - Navigating security verification results

### 5.2 Build and Test Integration

Integration with build and test systems:

1. **Build-Time Security Checking**:
   - Security property verification during build
   - Security override validation
   - Security metadata consistency checking
   - Security regression detection

2. **Test Integration**:
   - Security-focused test generation
   - Security property verification in tests
   - Security override testing
   - Security regression testing

3. **Continuous Integration**:
   - Security debugging in CI pipeline
   - Automated security issue detection
   - Security regression prevention
   - Security fix verification

4. **Deployment Integration**:
   - Pre-deployment security verification
   - Security override validation for deployment
   - Security property checking in staging
   - Security monitoring in production

### 5.3 Version Control Integration

Integration with version control systems:

1. **Security Change Tracking**:
   - Tracking of security property changes
   - Version history for security overrides
   - Security verification history
   - Security fix tracking

2. **Security Diff Visualization**:
   - Visualization of security property changes
   - Highlighting of security impact in diffs
   - Security override changes in diffs
   - Security verification changes

3. **Security Merge Support**:
   - Security-aware merge conflict resolution
   - Security property consistency checking
   - Security override conflict resolution
   - Security verification during merge

4. **Security Branch Management**:
   - Security status for branches
   - Security verification for branch merges
   - Security override tracking across branches
   - Security fix propagation

### 5.4 Collaboration Integration

Integration with collaboration tools:

1. **Issue Tracking Integration**:
   - Security issue tracking
   - Security override tracking
   - Security verification failure tracking
   - Security fix tracking

2. **Code Review Integration**:
   - Security-focused code review
   - Security property verification in reviews
   - Security override approval in reviews
   - Security fix verification

3. **Documentation Integration**:
   - Security debugging documentation
   - Security issue knowledge base
   - Security fix documentation
   - Security best practices

4. **Team Communication Integration**:
   - Security issue notifications
   - Security override approval requests
   - Security verification result sharing
   - Security fix announcements

## 6. Implementation Approaches

### 6.1 IDE Plugin Implementation

Implementation approaches for IDE plugins:

1. **Visual Studio Code Extension**:
   - Security debugging extension
   - Security property visualization
   - Security override workflow
   - Security explanation interface

2. **JetBrains IDE Plugin**:
   - Security debugging plugin
   - Security property inspection
   - Security override management
   - Security explanation tool window

3. **Eclipse Plugin**:
   - Security debugging perspective
   - Security property view
   - Security override wizard
   - Security explanation view

4. **Web IDE Integration**:
   - Security debugging for web IDEs
   - Security property visualization in browser
   - Security override workflow for web
   - Security explanation panel

### 6.2 Debugging Protocol Implementation

Implementation approaches for debugging protocols:

1. **Debug Adapter Protocol Extension**:
   - Security property inspection protocol
   - Security breakpoint protocol
   - Security state protocol
   - Security explanation protocol

2. **Language Server Protocol Extension**:
   - Security property analysis
   - Security issue reporting
   - Security fix suggestions
   - Security documentation

3. **Custom Debugging Protocol**:
   - Specialized security debugging protocol
   - High-performance security state tracking
   - Efficient security property transmission
   - Optimized security visualization data

4. **Remote Debugging Support**:
   - Remote security debugging
   - Distributed security property tracking
   - Cross-environment security debugging
   - Cloud-based security debugging

### 6.3 Runtime Implementation

Implementation approaches for runtime debugging:

1. **Instrumentation-Based Debugging**:
   - Security property instrumentation
   - Security check instrumentation
   - Security override tracking
   - Security exception tracking

2. **Snapshot-Based Debugging**:
   - Security state snapshots
   - Security property history
   - Security override history
   - Security verification history

3. **Trace-Based Debugging**:
   - Security execution tracing
   - Security property evolution tracing
   - Security check execution tracing
   - Security exception handling tracing

4. **Live Debugging**:
   - Real-time security property inspection
   - Live security verification
   - Dynamic security override management
   - Interactive security explanation

### 6.4 Analysis Implementation

Implementation approaches for security analysis:

1. **Static Analysis Integration**:
   - Security property static analysis
   - Security vulnerability detection
   - Security override validation
   - Security verification

2. **Dynamic Analysis Integration**:
   - Runtime security property analysis
   - Security behavior monitoring
   - Security performance analysis
   - Security exception analysis

3. **Symbolic Execution**:
   - Security property symbolic verification
   - Security vulnerability path exploration
   - Security override impact analysis
   - Security exception path analysis

4. **Machine Learning Integration**:
   - Security issue pattern recognition
   - Security fix suggestion generation
   - Security override analysis
   - Security performance optimization

## 7. Example Implementations

### 7.1 Memory Safety Debugging Example

```typescript
// Memory Safety Debugger Component
export class MemorySafetyDebugger {
  // Analyze memory safety for a given code section
  analyzeMemorySafety(code: CodeSection): MemorySafetyAnalysis {
    const analysis = new MemorySafetyAnalysis();
    
    // Analyze memory allocations
    const allocations = this.findMemoryAllocations(code);
    for (const allocation of allocations) {
      analysis.addAllocation(allocation);
    }
    
    // Analyze memory accesses
    const accesses = this.findMemoryAccesses(code);
    for (const access of accesses) {
      // Check if access is bounds-checked
      const isBoundsChecked = this.isBoundsChecked(access, code);
      analysis.addAccess(access, isBoundsChecked);
      
      // Check for potential violations
      if (!isBoundsChecked) {
        const potentialViolation = this.analyzePotentialViolation(access, allocations);
        if (potentialViolation) {
          analysis.addViolation(potentialViolation);
        }
      }
    }
    
    // Analyze memory releases
    const releases = this.findMemoryReleases(code);
    for (const release of releases) {
      analysis.addRelease(release);
    }
    
    // Check for memory leaks
    const leaks = this.findMemoryLeaks(allocations, releases);
    for (const leak of leaks) {
      analysis.addLeak(leak);
    }
    
    // Check for use-after-free
    const useAfterFree = this.findUseAfterFree(accesses, releases);
    for (const violation of useAfterFree) {
      analysis.addViolation(violation);
    }
    
    // Check for overrides
    const overrides = this.findMemorySafetyOverrides(code);
    for (const override of overrides) {
      analysis.addOverride(override);
    }
    
    return analysis;
  }
  
  // Generate visualization for memory safety
  generateVisualization(analysis: MemorySafetyAnalysis): MemorySafetyVisualization {
    const visualization = new MemorySafetyVisualization();
    
    // Create memory layout visualization
    visualization.setMemoryLayout(this.createMemoryLayoutVisualization(analysis));
    
    // Create access pattern visualization
    visualization.setAccessPattern(this.createAccessPatternVisualization(analysis));
    
    // Create violation visualization
    visualization.setViolations(this.createViolationVisualization(analysis));
    
    // Create override visualization
    visualization.setOverrides(this.createOverrideVisualization(analysis));
    
    return visualization;
  }
  
  // Generate fix suggestions for memory safety issues
  generateFixSuggestions(analysis: MemorySafetyAnalysis): MemorySafetyFixSuggestions {
    const suggestions = new MemorySafetyFixSuggestions();
    
    // Generate suggestions for bounds checking
    for (const violation of analysis.getViolations()) {
      if (violation.type === 'bounds') {
        suggestions.addBoundsCheckSuggestion(violation);
      }
    }
    
    // Generate suggestions for memory leaks
    for (const leak of analysis.getLeaks()) {
      suggestions.addLeakFixSuggestion(leak);
    }
    
    // Generate suggestions for use-after-free
    for (const violation of analysis.getViolations()) {
      if (violation.type === 'use-after-free') {
        suggestions.addUseAfterFreeSuggestion(violation);
      }
    }
    
    // Generate suggestions for safer alternatives
    suggestions.setSaferAlternatives(this.generateSaferAlternatives(analysis));
    
    return suggestions;
  }
}
```

### 7.2 Security Override Debugging Example

```typescript
// Security Override Debugger Component
export class SecurityOverrideDebugger {
  // Analyze security overrides for a given code section
  analyzeSecurityOverrides(code: CodeSection): SecurityOverrideAnalysis {
    const analysis = new SecurityOverrideAnalysis();
    
    // Find all security overrides
    const overrides = this.findSecurityOverrides(code);
    for (const override of overrides) {
      analysis.addOverride(override);
      
      // Check override justification
      const justification = this.getOverrideJustification(override);
      analysis.setJustification(override.id, justification);
      
      // Check override approval
      const approval = this.getOverrideApproval(override);
      analysis.setApproval(override.id, approval);
      
      // Analyze override impact
      const impact = this.analyzeOverrideImpact(override, code);
      analysis.setImpact(override.id, impact);
      
      // Check override scope
      const scope = this.analyzeOverrideScope(override, code);
      analysis.setScope(override.id, scope);
      
      // Check for potential issues
      const issues = this.findPotentialIssues(override, impact, scope);
      for (const issue of issues) {
        analysis.addIssue(override.id, issue);
      }
    }
    
    return analysis;
  }
  
  // Generate visualization for security overrides
  generateVisualization(analysis: SecurityOverrideAnalysis): SecurityOverrideVisualization {
    const visualization = new SecurityOverrideVisualization();
    
    // Create override location visualization
    visualization.setLocations(this.createLocationVisualization(analysis));
    
    // Create override impact visualization
    visualization.setImpact(this.createImpactVisualization(analysis));
    
    // Create override status visualization
    visualization.setStatus(this.createStatusVisualization(analysis));
    
    // Create override issue visualization
    visualization.setIssues(this.createIssueVisualization(analysis));
    
    return visualization;
  }
  
  // Generate audit information for security overrides
  generateAuditInformation(analysis: SecurityOverrideAnalysis): SecurityOverrideAudit {
    const audit = new SecurityOverrideAudit();
    
    // Add override history
    for (const override of analysis.getOverrides()) {
      const history = this.getOverrideHistory(override);
      audit.addHistory(override.id, history);
    }
    
    // Add approval information
    for (const override of analysis.getOverrides()) {
      const approval = analysis.getApproval(override.id);
      if (approval) {
        audit.addApproval(override.id, approval);
      }
    }
    
    // Add justification information
    for (const override of analysis.getOverrides()) {
      const justification = analysis.getJustification(override.id);
      if (justification) {
        audit.addJustification(override.id, justification);
      }
    }
    
    // Add impact assessment
    for (const override of analysis.getOverrides()) {
      const impact = analysis.getImpact(override.id);
      if (impact) {
        audit.addImpact(override.id, impact);
      }
    }
    
    return audit;
  }
}
```

### 7.3 Security Verification Debugging Example

```typescript
// Security Verification Debugger Component
export class SecurityVerificationDebugger {
  // Analyze security verification for a given code section
  analyzeSecurityVerification(code: CodeSection): SecurityVerificationAnalysis {
    const analysis = new SecurityVerificationAnalysis();
    
    // Get verification results
    const results = this.getVerificationResults(code);
    analysis.setResults(results);
    
    // Analyze verification coverage
    const coverage = this.analyzeVerificationCoverage(code, results);
    analysis.setCoverage(coverage);
    
    // Find verification failures
    const failures = this.findVerificationFailures(results);
    for (const failure of failures) {
      analysis.addFailure(failure);
      
      // Analyze failure cause
      const cause = this.analyzeFailureCause(failure, code);
      analysis.setFailureCause(failure.id, cause);
      
      // Generate fix suggestions
      const suggestions = this.generateFixSuggestions(failure, cause);
      analysis.setFixSuggestions(failure.id, suggestions);
    }
    
    // Find verification gaps
    const gaps = this.findVerificationGaps(coverage);
    for (const gap of gaps) {
      analysis.addGap(gap);
    }
    
    return analysis;
  }
  
  // Generate visualization for security verification
  generateVisualization(analysis: SecurityVerificationAnalysis): SecurityVerificationVisualization {
    const visualization = new SecurityVerificationVisualization();
    
    // Create results visualization
    visualization.setResults(this.createResultsVisualization(analysis));
    
    // Create coverage visualization
    visualization.setCoverage(this.createCoverageVisualization(analysis));
    
    // Create failure visualization
    visualization.setFailures(this.createFailureVisualization(analysis));
    
    // Create gap visualization
    visualization.setGaps(this.createGapVisualization(analysis));
    
    return visualization;
  }
  
  // Generate verification report
  generateVerificationReport(analysis: SecurityVerificationAnalysis): SecurityVerificationReport {
    const report = new SecurityVerificationReport();
    
    // Add summary information
    report.setSummary({
      totalProperties: analysis.getResults().properties.length,
      verifiedProperties: analysis.getResults().verifiedProperties.length,
      failedProperties: analysis.getFailures().length,
      coveragePercentage: analysis.getCoverage().percentage
    });
    
    // Add detailed results
    report.setDetailedResults(analysis.getResults());
    
    // Add failure details
    for (const failure of analysis.getFailures()) {
      report.addFailureDetail({
        failure: failure,
        cause: analysis.getFailureCause(failure.id),
        suggestions: analysis.getFixSuggestions(failure.id)
      });
    }
    
    // Add gap details
    for (const gap of analysis.getGaps()) {
      report.addGapDetail(gap);
    }
    
    return report;
  }
}
```

## 8. Conclusion

This debugging framework establishes security-aware debugging as a core component of the AI-Native Programming Paradigm. By providing comprehensive tools for debugging memory safety, resource constraints, sandboxing, and security verification, we ensure that developers can effectively identify and fix security issues in their code.

The framework is designed to integrate seamlessly with the development environment and to support debugging across all layers of the AI-Native Representation Format. The multi-layer approach ensures that developers can trace security issues from high-level intent to low-level execution, while the security-specific tools provide targeted support for the secure-by-default approach.