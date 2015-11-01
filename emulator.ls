childProccess = require 'child_process'

exports = module.exports = {}

exports.execute = (command) ->
    result = childProccess.spawnSync command.program, command.args
    pid: result.pid
    status: parseInt result.status
    output: result.stdout.toString 'utf-8'
    stdout: result.stdout.toString 'utf-8'
    stderr: result.stderr.toString 'utf-8'
    error: result.error
    signal: result.signal
