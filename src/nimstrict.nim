import core/parseProject


proc nimstrict() =
  parseProject("./")


when isMainModule:
  nimstrict()
