import sequtils
import strutils

import lintFile
import parseIdentifiers
import types


proc parseFile*(filePath: string) =
  if ".nim" notin filePath or ".nimble" in filePath:
    return

  var fileContent: string
  var identifiers: seq[string]

  try:
    fileContent = readFile(filePath)
  except IOError as e:
    echo "Error reading file:", e.msg

  let splitFileContent = fileContent.splitLines()

  for fileIndex, fileLine in splitFileContent:
    let splitFileLine = fileLine.split(" ").filterIt(it.len > 0)

    for token in splitFileLine.mapIt(it):
      let props: ParsedFile = (
        splitFileContent,
        splitFileLine,
        fileIndex,
        fileLine
      )

      case token:
        of TokenType(tkVar).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkLet).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkConst).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkFunc).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkProc).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkImport).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkMacro).repr:
          identifiers.add(parseIdentifiers(props))

        of TokenType(tkTemplate).repr:
          identifiers.add(parseIdentifiers(props))

  lintFile(filePath, deduplicate(identifiers))
