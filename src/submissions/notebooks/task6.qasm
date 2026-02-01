OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 6
// Target: U = exp( i * (pi/7) * (XX + ZI + IZ) )
//
// Minimal-cost strategy:
//   1-step Lie–Trotter:
//     U ≈ exp(iθ ZI) · exp(iθ IZ) · exp(iθ XX),  θ = pi/7
//
// Notes:
// - Terms do NOT commute, so exact factorization is impossible.
// - All non-Clifford cost is isolated into Rz(±2*pi/7) approximations.
// - No custom gates. Uses only {h, t, tdg, cx}.
// ============================================================================

qreg q[2];

// ---------------------------------------------------------------------------
// Helper: inline approx for Rz(-2*pi/7) on a qubit a
// This is the inverse of your extracted block.
// ---------------------------------------------------------------------------

// ======================= (1) exp(i*(pi/7)*ZI) ==============================
// exp(iθ Z) corresponds to Rz(-2θ) under the OpenQASM convention.
h q[0];
t q[0];
h q[0];
tdg q[0];
h q[0];
t q[0];
h q[0];
tdg q[0];
h q[0];
tdg q[0];
h q[0];
t q[0];

// ======================= (2) exp(i*(pi/7)*IZ) ==============================
// same on q[1]
h q[1];
t q[1];
h q[1];
tdg q[1];
h q[1];
t q[1];
h q[1];
tdg q[1];
h q[1];
tdg q[1];
h q[1];
t q[1];

// ======================= (3) exp(i*(pi/7)*XX) ==============================
// X->Z via H on both, then ZZ core, then undo H
h q[0];
h q[1];

cx q[0], q[1];

// Rz(-2*pi/7) on q[1] (same inverse block)
h q[1];
t q[1];
h q[1];
tdg q[1];
h q[1];
t q[1];
h q[1];
tdg q[1];
h q[1];
tdg q[1];
h q[1];
t q[1];

cx q[0], q[1];

h q[0];
h q[1];
