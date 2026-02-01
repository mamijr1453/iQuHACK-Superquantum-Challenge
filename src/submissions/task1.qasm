OPENQASM 2.0;
include "qelib1.inc";

// ----------------------------------------------------------------
// TASK 1: Controlled-Y Gate
// STRATEGY: Use Identity Y = S * X * S_dagger
// COST: 0 T-count (S and Sdg are now Clifford/Free)
// ----------------------------------------------------------------

qreg q[2]; // q[0]: Control, q[1]: Target

// Step 1: Basis Change (Y-basis to X-basis)
// Operation: S_dagger
sdg q[1];

// Step 2: Bit Flip (Controlled-X)
// Operation: CNOT
cx q[0], q[1];

// Step 3: Basis Restore (X-basis to Y-basis)
// Operation: S
s q[1];