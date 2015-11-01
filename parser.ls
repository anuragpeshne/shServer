{map, filter, lines} = require 'prelude-ls'

exports = module.exports = {}

exports.parse = do ->
    builtIns = [ '[', 'bash', 'cat', 'chmod', 'cp', 'csh', 'date', 'dd', 'df',
                  'domainname', 'echo', 'ed', 'expr', 'hostname', 'kill', 'ksh',
                  'launchctl', 'link', 'ln', 'ls', 'mkdir', 'mv', 'pax', 'ps',
                  'pwd', 'rcp', 'rm', 'rmdir', 'sh', 'sleep', 'stty', 'sync',
                  'tcsh', 'test', 'unlink', 'wait4path', 'zsh']

    (str, context) ->
        commandList = str.split /\ |\|\>\</g
        program: commandList[0]
        flags: commandList.slice 1 |>
                filter ((element) -> (element.match /^-\w+$/) != null)
        args: commandList.slice 1 |>
                filter ((element) -> (element.match /^[\w\/'"]+$/) != null)
