OPENQASM 2.0;
include "qelib1.inc";

qreg q[2]; // q[0], q[1]

// ============================================================================
// TASK 3: U = exp(i * (pi/7) * Z ⊗ Z)
//
// Problem:
//   Implement the 2-qubit ZZ interaction exp(i*(pi/7) * Z⊗Z).
//
// Why it's hard:
//   pi/7 is non-Clifford -> requires non-Clifford resource (T/TDG).
//
// Core idea (min-cost / max-efficiency):
//   Use the minimal exact ZZ skeleton (2 CNOT), and spend T only in ONE Rz:
//     exp(i*theta * Z⊗Z) = CX · (I ⊗ Rz(2*theta)) · CX   (up to global phase)
//   Here theta = pi/7 -> target is Rz(2*pi/7) on q[1].
//
// Trade-off point:
//   This variant uses a very short synthesis word (T-count = 7) for a low-cost
//   approximation. If the resulting distance is too high, use Variant B (T=9).
// ============================================================================

// --- Minimal entangling skeleton (exact) ---
cx q[0], q[1];

// --- Rz(2*pi/7) approx word (T-count = 7) ---
// word: SHTHTHTSHTHTSHTHTHSSS
s q[1];
h q[1];
t q[1];
h q[1];
t q[1];
h q[1];
t q[1];
s q[1];
h q[1];
t q[1];
h q[1];
t q[1];
s q[1];
h q[1];
t q[1];
h q[1];
t q[1];
h q[1];
s q[1];
s q[1];
s q[1];

// --- Disentangle (exact) ---
cx q[0], q[1];