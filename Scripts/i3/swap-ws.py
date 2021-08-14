#!/usr/bin/env python3
# Swap workspaces on two monitors
import i3
import time

visible_workspaces = [ x for x in i3.get_workspaces() if x['visible']]
if len(visible_workspaces) == 2:
    focused = [x for x in visible_workspaces if x['focused']][0]
    notfocused = [x for x in visible_workspaces if not x['focused']][0]
    # print(notfocused)
    # print(focused)
    command1 = "[workspace=" + notfocused['name'] + "] " + "move workspace to output " + focused['output']
    command2 = "[workspace=" + focused['name'] + "] " + "move workspace to output " + notfocused['output']

    # print(command1)
    # print(command2)

    i3.command(command1)
    i3.command(command2)
    i3.workspace(notfocused['name'])
    i3.workspace(focused['name'])

    # print(command1)
    # print(command2)
    # i3.command('move workspace to output', notfocused['output'])
    # i3.command('move workspace to output', focused['output'])
