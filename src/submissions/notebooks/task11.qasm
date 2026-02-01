OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 11: 4-qubit diagonal unitary  U|x> = exp(i*phi(x)) |x>
//
// Goal: compile with as few T and CNOT as possible (exact; phases are pi/4 multiples).
//
// Key trick (workshop-style):
//   The phase table can be represented as a short "phase polynomial" over XOR parities.
//   Here it reduces to ONLY 4 parity terms, each with coefficient -pi/4 (i.e., Tdg).
//
// Implementation pattern (diagonal-safe):
//   - compute parity onto a pivot qubit (q0) using CNOTs
//   - apply Tdg on the pivot (phase kickback)
//   - uncompute the parity (reverse the CNOTs)
//   This keeps the circuit diagonal while injecting the desired phase.
//
// Cost:
//   - T-count = 4  (four Tdg)
//   - CNOT count = 18
// ============================================================================

qreg q[4];

// ---------------------------------------------------------------------------
// Term 1: coefficient = -pi/4 on parity (q0 ⊕ q1 ⊕ q2)    [mask 0111]
// ---------------------------------------------------------------------------
cx q[1], q[0];
cx q[2], q[0];
tdg q[0];
cx q[2], q[0];
cx q[1], q[0];

// ---------------------------------------------------------------------------
// Term 2: coefficient = -pi/4 on parity (q0 ⊕ q1 ⊕ q3)    [mask 1011]
// ---------------------------------------------------------------------------
cx q[1], q[0];
cx q[3], q[0];
tdg q[0];
cx q[3], q[0];
cx q[1], q[0];

// ---------------------------------------------------------------------------
// Term 3: coefficient = -pi/4 on parity (q0 ⊕ q2 ⊕ q3)    [mask 1101]
// ---------------------------------------------------------------------------
cx q[2], q[0];
cx q[3], q[0];
tdg q[0];
cx q[3], q[0];
cx q[2], q[0];

// ---------------------------------------------------------------------------
// Term 4: coefficient = -pi/4 on parity (q0 ⊕ q1 ⊕ q2 ⊕ q3) [mask 1111]
// ---------------------------------------------------------------------------
cx q[1], q[0];
cx q[2], q[0];
cx q[3], q[0];
tdg q[0];
cx q[3], q[0];
cx q[2], q[0];
cx q[1], q[0];
