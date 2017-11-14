import re

fname = input('Input file name: ')
fhand = open(fname)

for line in fhand:
    if not line.startswith('From: '):
        continue
    print(re.findall('@(\S+)', line))

