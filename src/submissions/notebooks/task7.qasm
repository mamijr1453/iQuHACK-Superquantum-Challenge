OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 7 — State preparation under a strict gate limit
//
// Goal:
//   Prepare the given 2-qubit target state starting from |00>.
//   The scorer compares the produced state to the target (distance) and also
//   penalizes costly circuits (gate count / T-count).
//
// Approach (low-cost ansatz):
//   - Avoid full exact synthesis (it explodes in Clifford+T and hits gate limits).
//   - Use a small "mix + entangle + local adjust + entangle" structure.
//   - This keeps the circuit short and aims for a good cost/accuracy trade-off.
//
// Gate set:
//   Uses only {h, t, tdg, cx}.
// ============================================================================

qreg q[2];

// --- Mix on q0 (creates a controllable amplitude split) ---
h q[0];
t q[0];
h q[0];

// --- First entangling step (inject Schmidt-rank structure) ---
cx q[0], q[1];

// --- Local adjust on q1 (small phase + mixing correction) ---
h   q[1];
tdg q[1];
h   q[1];
t   q[1];

// --- Second entangling step (refines amplitude correlations) ---
cx q[0], q[1];

// --- Final light phase tweaks (cheap, sometimes helps) ---
t   q[0];
tdg q[1];
