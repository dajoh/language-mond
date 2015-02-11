linterPkg = atom.packages.getLoadedPackage("linter")
if !linterPkg
  return
Linter = require "#{linterPkg.path}/lib/linter"

class LinterMond extends Linter
  @syntax: 'source.mond'
  linterName: 'mondx-lint'

  regexLineCol:  '((?<line>\\d+):(?<col>\\d+): )?'
  regexRange:    '((?<lineStart>\\d+):(?<colStart>\\d+)-(?<lineEnd>\\d+):(?<colEnd>\\d+): )?'
  regexSeverity: '(?<severity>[^:]+): '
  regexMessage:  '(?<message>[^\n]*)\n'

  constructor: (editor)->
    super editor

    builtin = atom.config.get 'language-mond.mondBuiltinSpecPath'
    if builtin != ''
      @cmd = ['mondx-lint', '-f', 'tool', '-b', builtin]
    else
      @cmd = ['mondx-lint', '-f', 'tool']

    @regex = @regexLineCol + @regexRange + @regexSeverity + @regexMessage
    @executablePath = atom.config.get 'language-mond.mondLintExecutablePath'

  createMessage: (match) ->
    # If we don't get a range, make it a 1 character range.
    if !match.lineStart
      match.lineStart = match.line
      match.colStart = match.col
      match.lineEnd = match.line
      match.colEnd = (parseInt match.col) + 1

    # Linter throws a fit if line/col aren't present even if we have a range.
    # wat?
    match.line = match.lineStart
    match.col = match.colStart

    return {
      line: match.line,
      col: match.col,
      level: match.severity,
      message: match.message,
      linter: @linterName,
      range: @computeRange match
    }

module.exports = LinterMond
