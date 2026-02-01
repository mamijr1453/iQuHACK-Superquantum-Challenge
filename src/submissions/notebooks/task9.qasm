OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 9: Structured Unitary 2  (EXACT)
//
// Why this is "structured":
// - The target matrix entries live in the Clifford+T ring (0, ±1, ±i, (±1±i)/2).
// - So we should NOT "approximate" it. We should factor it into a short exact
//   Clifford+T circuit.
//
// Result (exact, very small):
//   3 CNOT + 2 H + 2 S + 2 T + 1 Tdg
// ============================================================================

qreg q[2];

// --- exact sequence ---
h  q[1];
s  q[0];
t  q[0];
t  q[1];
cx q[0], q[1];

tdg q[1];
cx  q[1], q[0];
cx  q[0], q[1];

h  q[0];
s  q[0];
