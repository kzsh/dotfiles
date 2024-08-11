import i3ipc
from re import sub

def print_window_class(text):
    return f'{color.BOLD}[{color.END}{color.GREEN}{text}{color.END}{color.BOLD}]{color.END}'

class color:
   PURPLE = '\033[95m'
   CYAN = '\033[96m'
   DARKCYAN = '\033[36m'
   BLUE = '\033[94m'
   GREEN = '\033[92m'
   YELLOW = '\033[93m'
   RED = '\033[91m'
   BOLD = '\033[1m'
   UNDERLINE = '\033[4m'
   END = '\033[0m'

i3 = i3ipc.Connection()

def print_obj(item):
    attr = vars(item)
    print(', '.join("%s: %s" % item for item in attr.items()))

# for con in i3.get_tree():
#     if con.window and con.parent.type != 'dockarea':
#         print_obj(con.workspace())

for con in i3.get_tree():
    if con.window and con.parent.type != 'dockarea':
        # formattedWorkspace = con.workspace().name
        # print(con.workspace().name)
        workspace = sub(
            r'([0-9]+):([a-zA-Z])<sub>(.+)</sub>',
            lambda m: f'{m[1]}:{color.DARKCYAN}{m[2]}{m[3]}{color.END}',
            con.workspace().name
        ) #.split(':', 1)[1]
        i3class = con.window_class
        name = con.name

        print(f'{workspace} {name} {print_window_class(i3class)}')
