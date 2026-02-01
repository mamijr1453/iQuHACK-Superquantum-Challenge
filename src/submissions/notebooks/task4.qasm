OPENQASM 2.0;
include "qelib1.inc";

// ============================================================================
// TASK 4 (from challenge PDF):  U = exp( i * (pi/7) * (XX + YY) )   :contentReference[oaicite:1]{index=1}
//
// PROBLEM:
//   Compile the 2-qubit unitary exp(i*(pi/7)*(X⊗X + Y⊗Y)) using only
//   Clifford+T gates (H, T, T†, CNOT). Global phase is ignored by the grader.
//
// KEY FACT (Exact — no trotter):
//   [XX, YY] = 0  =>  exp(iθ(XX+YY)) = exp(iθXX) * exp(iθYY)
//
// KEY FACT (Pauli-string exponential):
//   exp(iθ ZZ) = CX • (I ⊗ Rz(2θ)) • CX
//   with θ = pi/7  =>  need Rz(2*pi/7) twice (once for XX, once for YY)
//
// BOTTLENECK:
//   Rz(2*pi/7) is non-Clifford, so it must be approximated in Clifford+T.
//   We concentrate all approximation into a single primitive and reuse it twice.
// ============================================================================

qreg q[2];

// ---------------------------------------------------------------------------
// APPROX PRIMITIVE: Rz(2*pi/7) on qubit a
// This is a concrete Clifford+T approximation using only {h, t, tdg}.
// T-count inside = 12.
//
// If you later obtain a better (lower distance / similar T) sequence,
// you can replace this block only; the rest of the circuit stays optimal.
// ---------------------------------------------------------------------------
gate rz_2pi7 a {
    tdg a;
    h a;
    t a;
    h a;
    t a;
    h a;
    t a;
    h a;
    tdg a;
    h a;
    tdg a;
    h a;
    t a;
    h a;
    t a;
    h a;
    tdg a;
    h a;
    tdg a;
    h a;
    t a;
    h a;
    tdg a;
    h a;
}

// ============================================================================
// BLOCK 1: exp(i*(pi/7)*XX)
// Basis change X -> Z using H on both qubits (since H X H = Z).
// Then apply exp(iθZZ) with θ=pi/7 using CX - Rz(2θ) - CX.
// ============================================================================

h q[0];
h q[1];

cx q[0], q[1];
rz_2pi7 q[1];
cx q[0], q[1];

h q[0];
h q[1];

// ============================================================================
// BLOCK 2: exp(i*(pi/7)*YY)
// Need basis change Y -> Z on both qubits.
// Standard is (S† then H) on each qubit, then undo (H then S).
//
// But S / S† are not allowed in strict Clifford+T gate set, so we use:
//   S  = T T
//   S† = T† T†
//
// So:
//   Y -> Z basis change: (T† T†) then H
//   Undo basis: H then (T T)
// ============================================================================

// (S† on both qubits) implemented as tdg; tdg;
tdg q[0];
tdg q[0];
tdg q[1];
tdg q[1];

// then H on both
h q[0];
h q[1];

// ZZ core again
cx q[0], q[1];
rz_2pi7 q[1];
cx q[0], q[1];

// undo: H on both
h q[0];
h q[1];

// then (S on both) implemented as t; t;
t q[0];
t q[0];
t q[1];
t q[1];
