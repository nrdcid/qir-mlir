# Instrumented runtime — M1

Implement a C/C++ shim with the exact pinned fixture ABI. Treat static qubit and
result pointers as IDs; never dereference them as host memory. Record initialization,
QIS calls, scripted measurements/result-slot writes and reads, and all output
events including labels and order.

Freeze the host target, data layout, and runtime revision in `toolchain.lock.json`
before enabling execution. Original/exported trace equality tests preservation;
an independent semantic interpreter must check transformations separately.
