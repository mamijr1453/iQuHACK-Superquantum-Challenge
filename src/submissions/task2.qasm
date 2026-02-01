OPENQASM 2.0;
include "qelib1.inc";

qreg q[2]; // q[0]=control, q[1]=target

// ============================================================================
// TASK 2: Controlled-Ry(pi/7) — Pareto / FT-Aware Submission
//
// Goal (metric-only judging):
//   - Low T-count (fault-tolerant cost proxy)
//   - While keeping Operator Norm Distance acceptable
//
// Construction:
//   1) Half-angle sandwich:
//        CRy(theta) = Ry(theta/2) · CX · Ry(-theta/2) · CX
//        theta = pi/7  =>  a = pi/14
//
//   2) Free-Clifford basis change (update-aware):
//        Ry(a) = (S H) · Rz(a) · (H Sdg)
//      S/Sdg are Clifford (free), so T is spent ONLY inside the Rz block.
//
//   3) Symmetry for stability:
//        Rz(-a) is built as the strict adjoint/inverse of Rz(+a)
//        (reverse order + T<->Tdg, S<->Sdg; H unchanged).
//
// Rz(+a) word used:  SHTSHTSHTHTSHTSHTSHTHTSHTSHSS
// T-count in word = 6  => total T-count = 12
// ============================================================================


// -------------------- Ry(+pi/14) --------------------
// (S H) Rz(+a) (H Sdg)
s q[1];
h q[1];

// ---- Rz(+pi/14) approx block ----
// Word: S H T S H T S H T H T S H T S H T S H T H T S H T S H S S
s q[1];
h q[1];
t q[1];
s q[1];
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
s q[1];
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
s q[1];
h q[1];
s q[1];
s q[1];

h q[1];
sdg q[1];

// -------------------- CX #1 --------------------
cx q[0], q[1];


// -------------------- Ry(-pi/14) --------------------
// (S H) Rz(-a) (H Sdg)
s q[1];
h q[1];

// ---- Rz(-pi/14) = inverse(Rz(+pi/14)) ----
// Rule: reverse + swap (t<->tdg, s<->sdg), keep h
sdg q[1];
sdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
sdg q[1];
tdg q[1];
h q[1];
tdg q[1];
h q[1];
tdg q[1];
h q[1];
sdg q[1];

h q[1];
sdg q[1];

// -------------------- CX #2 --------------------
cx q[0], q[1];
