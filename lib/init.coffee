module.exports =
  config:
    mondLintExecutablePath:
      type: 'string'
      default: ''
      description: 'Path to mondx-lint, excluding executable name'
    mondBuiltinSpecPath:
      type: 'string'
      default: ''
      description: 'Path to builtin.mnd, including file name'

  activate: () ->
