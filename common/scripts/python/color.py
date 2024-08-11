#!/usr/bin/env python
import sys

fg = '\033[38;5;'
bg = '\033[48;5;'
for i in sys.argv[1:]:
    n = str(int(i))
    fgstr = fg + n + 'm' + n
    bgstr = bg + n + 'm' 'XXXXX'
    print(fgstr, bgstr, '\033[0m')
