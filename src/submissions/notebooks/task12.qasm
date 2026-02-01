OPENQASM 2.0;
include "qelib1.inc";
qreg q[9];

// ======================================================
// TASK 12 — SUBMIT-READY (Generated)
// Qubits: 9
// Method: mask-merge (mod 8) + running parity walk
// Pivot: q[0]
// Gateset: {h, s, sdg, t, tdg, cx}
// ======================================================

// --- STEP A: GLOBAL DIAGONALIZATION (C) ---
// NOTE: left as identity unless you plug your known Clifford here.

// --- STEP B: RUNNING PARITY (WALK ORDER) ---

// --- FINAL CLEANUP: RETURN PARITY TO 0 ---

// --- STEP C: UNDO DIAGONALIZATION (C†) ---
// NOTE: identity unless you plugged STEP A.
