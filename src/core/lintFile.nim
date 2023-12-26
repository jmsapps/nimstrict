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

    for token in splitLine:
      for identifier in identifiers.mapIt(it):
        let noUnderScoreToken = token.replace("_", "")
        let noUnderScoreIdentifier = identifier.replace("_", "")

        if
          noUnderScoreToken.toLower == noUnderScoreIdentifier.toLower and
          identifier[0] == token[0] and
          identifier != token
        :
          echo getWarningMessage(filePath, fileIndex, identifier, token)
