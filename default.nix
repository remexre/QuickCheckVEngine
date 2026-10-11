{
  lib,
  mkDerivation,

  base,
  basement,
  binary,
  bitwise,
  bytestring,
  cereal,
  containers,
  data-default,
  directory,
  filemanip,
  network,
  parsec,
  pretty-diff,
  QuickCheck,
  regex-posix,
  regex-tdfa,
  split,
  splitmix,
  table-layout,
  temporary,
  text,
  time,
}:

mkDerivation {
  pname = "QCVEngine";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base
    basement
    binary
    bitwise
    bytestring
    cereal
    containers
    data-default
    directory
    filemanip
    network
    parsec
    pretty-diff
    QuickCheck
    regex-posix
    regex-tdfa
    split
    splitmix
    table-layout
    temporary
    text
    time
  ];
  jailbreak = true;
  mainProgram = "QCVEngine";
  license = lib.licenses.bsd2;
}
