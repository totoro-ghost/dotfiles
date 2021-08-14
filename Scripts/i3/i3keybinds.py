#!/usr/bin/env python
import argparse
from terminaltables import SingleTable
from pathlib import Path
import re
import sys

binds = []
args = ''


def cat(list):
    '''Join lists together with spaces.
    '''
    return ' '.join(list)


def get_arg():
    '''Get command line arguments keybind and command
    '''
    global args
    parser = argparse.ArgumentParser(
            description='Find all used keybinds in i3.')
    parser.add_argument(
            '-k', '--keybind', help='Search for a specific keybind')
    parser.add_argument('-c', '--command', help='Search for a command')
    parser.add_argument('-v', '--verbose',
                        help='Get extra output', action="store_true")
    args = parser.parse_args()


def fix_table(table):
    '''Detect if the table will break and be ugly.
    If so recursively find the longest command
    until the table is ok
    '''
    if args.verbose:
        print('Fixing table...')
    cmd_width = table.column_max_width(2)
    commands = []
    # Get all commands
    for b in binds:
        commands.append(b[2])
    # Recursively find largest command
    while not table.ok:
        longest_command = max(commands, key=len)
        # if command is longer than the tables column for it
        if len(longest_command) > cmd_width:
            # find out how many times it needs to be split
            multiple = int(len(longest_command) % cmd_width)
            tmpstr = longest_command
            newstr = ''
            # split string into that many pieces, adding \n to
            # each piece
            for x in range(0, multiple+1):
                if len(tmpstr) < cmd_width:
                    # if end of command, don't add \n
                    newstr = newstr + tmpstr[:cmd_width]
                    break
                else:
                    # cut up string, and add \n
                    newstr = newstr + tmpstr[:cmd_width] + '\n'
                    tmpstr = tmpstr[cmd_width:]
            for b in binds:
                # find the longest command and replace it with newlined
                # version
                if b[2] == longest_command:
                    b[2] = newstr
                    commands.remove(longest_command)


def find_config():
    '''Find the i3 config file in either
    ${HOME}/.i3/config or ${HOME}/.config/i3
    Exit if not found.
    '''
    if args.verbose:
        print('Searching for i3 config file....')
        print('Looking in .i3 ...')
    homedir = str(Path.home())
    doti3 = homedir + '/.i3/config'
    dotconfig = homedir + '/.config/i3/config'
    config = Path(doti3)
    if (config.is_file()):
        if args.verbose:
            print('Found .i3/config!')
        return config
    else:
        if args.verbose:
            print('File not found. Trying another directory.')
        config = Path(dotconfig)
        if (config.is_file()):
            if args.verbose:
                print('Found .config/i3/config!')
            return config
        else:
            print('No config files found.')
            print('Please make sure the file is in ~/.i3 or ~/.config')
            sys.exit(1)


def parse(config):
    '''Open config file and see if mod variable exists.
    Find value of mod variable, then go through config
    finding top level keybinds. Get their keybinds, modifier key and
    command they execute.
    '''
    mod = ''
    with open(str(config)) as f:
        for line in f:
            # If line is not comment,
            if (line[:1] is not '#'):
                # See if there is a mod variable
                if ('Mod4' in line or 'Mod1' in line) and 'set' in line:
                    mod_var_check = re.search('\B\$\w+', line, re.IGNORECASE)
                    if mod_var_check:
                        mod = mod_var_check.group(0)
                        if args.verbose:
                            print('Modifier variable found: {0}'.format(mod))
                        if 'Mod1' in line:
                            if args.verbose:
                                print('{0} is equal to Mod1'.format(mod))
                            meta = True
                        else:
                            if args.verbose:
                                print('{0} is equal to Mod4'.format(mod))
                            meta = False
                    else:
                        if args.verbose:
                            print('No modifier variable found.')
                # Only look at top level bindings
                if 'bindsym' in line:
                    if re.match(r'\s', line):
                        pass
                    else:
                        words = line.split()
                        if mod:
                            if '--' in words[1]:
                                if meta:
                                    key = words[2].replace(mod+'+', "")
                                    cmd = cat(words[3:])
                                    l = [key, "Mod1", cmd]
                                    binds.append(l)
                                else:
                                    key = words[2].replace(mod+'+', "")
                                    cmd = cat(words[3:])
                                    l = [key, "Mod4", cmd]
                                    binds.append(l)
                            else:
                                if meta:
                                    key = words[1].replace(mod+'+', "")
                                    cmd = cat(words[2:])
                                    l = [key, "Mod1", cmd]
                                    binds.append(l)
                                else:
                                    key = words[1].replace(mod+'+', "")
                                    cmd = cat(words[2:])
                                    l = [key, "Mod4", cmd]
                                    binds.append(l)

                        else:
                            if 'Mod1' in words:
                                key = words[1].replace('Mod1', "")
                                cmd = cat(words[2:])
                                l = [key, "Mod1", cmd]
                                binds.append(l)
                            elif 'Mod4' in words:
                                key = words[1].replace('Mod4', "")
                                cmd = cat(words[2:])
                                l = [key, "Mod4", cmd]
                                binds.append(l)


def output(keybind="", command=""):
    '''Output the keybinds in a nice table.
    Call fix_table if needed.
    '''
    headers = ['Keybind', 'Modifier', 'Command']
    t_data = []
    if binds:
        binds.sort()
        for l in binds:
            if keybind:
                if keybind in l[0].lower():
                    t_data.append(l)
            elif command:
                if command in l[2].lower():
                    t_data.append(l)
            else:
                t_data.append(l)
        if t_data:
            t_data.insert(0, headers)
            table = SingleTable(t_data)
            if table.ok:
                if args.verbose:
                    print('Table ok.')
                print(table.table)
            else:
                fix_table(table)
                print(table.table)
        else:
            print('No keybinds found.')


def main():
    '''Run everythig
    '''
    get_arg()
    config = find_config()
    parse(config)
    keybind = args.keybind
    command = args.command
    output(keybind, command)


if __name__ == '__main__':
    main()
