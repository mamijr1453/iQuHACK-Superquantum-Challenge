OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 8: Structured Unitary 1  (this is exactly QFT_4 on 2 qubits)
//
// Circuit (standard 2-qubit QFT):
//   H on q0
//   Controlled-S with control q1 -> target q0   (phase i on |11>)
//   H on q1
//   SWAP(q0,q1)
//
// Controlled-S (CP(pi/2)) decomposition (exact):
//   T(control) ; T(target) ; CX ; Tdg(target) ; CX
// ============================================================================

qreg q[2];

// H on q0
h q[0];

// Controlled-S: control q[1] -> target q[0]
t   q[1];
t   q[0];
cx  q[1], q[0];
tdg q[0];
cx  q[1], q[0];

// H on q1
h q[1];

// SWAP(q0,q1) = 3 CNOT
cx q[0], q[1];
cx q[1], q[0];
cx q[0], q[1];
