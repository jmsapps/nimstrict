import strutils

import types

proc parseIdentifier(identifier: string): string =
  var parsedIdentifier = identifier
    .replace(":", "")
    .replace("(", "")
    .replace(")", "")
    .replace("*", "")
    .replace(",", "")

  if "/" in parsedIdentifier:
    parsedIdentifier = parsedIdentifier.split("/")[
      len(parsedIdentifier.split("/")) - 1
    ]

  result = parsedIdentifier


proc parseIdentifiers*(props: ParsedFile): seq[string] =
  var identifiers: seq[string]

  if len(props.splitFileLine) > 1:
    identifiers.add(parseIdentifier(props.splitFileLine[1]))

  if len(props.splitFileLine) == 1:
    let splitOuterLine = props.splitFileContent[props.fileIndex + 1].split(" ")
    var outerIndentCount = 0

    for element in splitOuterLine:
      if element == "":
        outerIndentCount += 1
      else:
        break

    for embeddedIndex, embeddedLine in props.splitFileContent[
      props.fileIndex + 1..len(props.splitFileContent) - 1
    ]:
      let splitInnerLine = embeddedLine.split(" ")

      var innerIndentCount = 0
      for element in splitInnerLine:
        if element == "":
          innerIndentCount += 1
        else:
          break

      if outerIndentCount != innerIndentCount:
        break
      else:
        identifiers.add(parseIdentifier(splitInnerLine[innerIndentCount]))

  result = identifiers
