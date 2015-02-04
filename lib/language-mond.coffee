linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

class LinterMond extends Linter
  @syntax: 'source.mond'
  cmd: ['mondx-lint', '-ftool']
  executablePath: null
  linterName: 'mondx-lint'
  regex: '((?<line>\\d+):(?<col>\\d+))?(!(?<lineStart>\\d+):(?<colStart>\\d+)-(?<lineEnd>\\d+):(?<colEnd>\\d+))?: (?<error>error: )?(?<warning>warning: )?(?<info>info: )?(?<message>[^\n]*)\n'

  constructor: (editor)->
    super editor
    @executablePath = atom.config.get 'language-mond.mondLintExecutablePath'

module.exports = LinterMond
