# Export implementation — M0/M1

Implement upstream LLVM export and narrow, symmetric preservation restoration.
Validate complete output before atomic replacement. Do not replay original module
text or reattach instruction metadata after transformations without proving it
still applies. Test both in-memory and standalone serialized workflows.
