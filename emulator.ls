childProccess = require 'child_process'

exports = module.exports = {}

exports.execute = (command) ->
    if command.program.length > 0
        # 10^6 ~= 1MB
        result = childProccess.spawnSync \
            command.program,
            command.flags ++ command.args,
            maxBuffer: 1e6
        pid: result.pid
        status: parseInt result.status
        output: result.output.toString 'utf-8'
        stdout: result.stdout.toString 'utf-8'
        stderr: result.stderr.toString 'utf-8'
        error: result.error
        signal: result.signal
