#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/raw_ostream.h"

namespace cl = llvm::cl;

static cl::OptionCategory bridgeOptions("QIR bridge options");
static cl::SubCommand importCommand("import", "Import QIR (not implemented)");
static cl::SubCommand inspectCommand("inspect",
                                     "Report resources (not implemented)");
static cl::SubCommand exportCommand("export", "Export QIR (not implemented)");
static cl::SubCommand checkCommand("check",
                                   "Check a QIR subset (not implemented)");

static cl::opt<std::string> input(
    cl::Positional, cl::desc("<input>"), cl::Required, cl::cat(bridgeOptions),
    cl::sub(importCommand), cl::sub(inspectCommand), cl::sub(exportCommand),
    cl::sub(checkCommand));
static cl::opt<std::string> output(
    "o", cl::desc("Output path; default stdout"), cl::init("-"),
    cl::cat(bridgeOptions), cl::sub(importCommand), cl::sub(inspectCommand),
    cl::sub(exportCommand));

enum class Mode { Strict, Mixed };
static cl::opt<Mode> mode(
    "mode", cl::desc("Import mode"), cl::init(Mode::Strict),
    cl::sub(importCommand), cl::cat(bridgeOptions),
    cl::values(clEnumValN(Mode::Strict, "strict", "Require complete coverage"),
               clEnumValN(Mode::Mixed, "mixed", "Reserved for later")));

enum class Format { JSON };
static cl::opt<Format> format(
    "format", cl::desc("Report format"), cl::init(Format::JSON),
    cl::cat(bridgeOptions), cl::sub(inspectCommand),
    cl::values(clEnumValN(Format::JSON, "json", "JSON")));

enum class Contract { Base, Adaptive };
static cl::opt<Contract> contract(
    "contract", cl::desc("Project contract, not a QIR profile spelling"),
    cl::init(Contract::Base), cl::cat(bridgeOptions), cl::sub(checkCommand),
    cl::values(clEnumValN(Contract::Base, "base-subset", "Base subset"),
               clEnumValN(Contract::Adaptive, "adaptive-subset", "Adaptive")));

int main(int argc, char **argv) {
  llvm::InitLLVM init(argc, argv);
  for (auto *command : {&cl::SubCommand::getTopLevel(), &importCommand,
                        &inspectCommand, &exportCommand, &checkCommand})
    cl::HideUnrelatedOptions(bridgeOptions, *command);
  cl::SetVersionPrinter([](llvm::raw_ostream &os) {
    os << "qir-mlir 0.0.0 (scaffold; no QIR import/export support)\n";
  });
  cl::ParseCommandLineOptions(argc, argv, "QIR to MLIR bridge scaffold\n");
  if (!importCommand && !inspectCommand && !exportCommand && !checkCommand) {
    llvm::errs() << "QIRB-E002 invalid-command: expected import, inspect, "
                    "export, or check; use --help\n";
    return 2;
  }

  // Do not open the destination before the eventual pipeline has verified its
  // result. The scaffold must never emit success-looking partial output.
  llvm::errs() << "QIRB-E001 not-implemented: this command is scaffolded only\n"
               << "input: " << input << "\n"
               << "action: complete the M0/M1 preservation pipeline in "
                  "docs/roadmap.md\n";
  return 1;
}
