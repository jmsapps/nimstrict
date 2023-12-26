import sequtils
import strutils

import getWarningMessage


proc lintFile*(filePath: string, identifiers: seq[string]) =
  if ".nim" notin filePath or ".nimble" in filePath or "strictcase.nim" in filePath:
    return

  var fileContent: string

  try:
    fileContent = readFile(filePath)
  except IOError as e:
    echo "Error reading file:", e.msg

  let splitLines = fileContent.splitLines()

  for fileIndex, line in splitLines:
    let replacedLine = line
      .replace(".", " ")
      .replace("(", " ")
      .replace(")", " ")
      .replace(",", " ")
      .replace(":", " ")

    let splitLine = replacedLine.split(" ").filterIt(it.len > 0)

    for redeclaration in splitLine:
      for identifier in identifiers.mapIt(it):
        let comparisonIdentifier = identifier.replace("_", "").toLower
        let comparisonRedeclaration = redeclaration.replace("_", "").toLower

        if
          comparisonIdentifier == comparisonRedeclaration and
          identifier[0] == redeclaration[0] and
          identifier != redeclaration
        :
          echo getWarningMessage(filePath, fileIndex, identifier, redeclaration)
