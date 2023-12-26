import strformat


proc getWarningMessage*(
  filePath: string,
  fileIndex: int,
  identifier: string,
  token: string,
): string =
  result = fmt("\x1B[1;97m\x1B[1m{filePath}({fileIndex + 1})\x1B[0m \x1B[33mWarning:\x1B[0m ") &
    fmt("mismatch between declaration '{identifier}' and token '{token}' ") &
    fmt("\x1B[36m[IncorrectCase]\x1B[0m")
