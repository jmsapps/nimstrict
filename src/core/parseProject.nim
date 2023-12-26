import os

import parseFile


proc parseProject*(directory: string) =
  for kind, filePath in walkDir(directory):
    if kind == pcDir:
      parseProject(filePath)

    if kind == pcFile:
      parseFile(filePath)
