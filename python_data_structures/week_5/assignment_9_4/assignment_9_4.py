'''
9.4 Write a program to read through the mbox-short.txt and figure out who has
the sent the greatest number of mail messages. The program looks for 'From '
lines and takes the second word of those lines as the person who sent the mail.
The program creates a Python dictionary that maps the sender's mail address to
acount of the number of times they appear in the file. After the dictionary is
produced, the program reads through the dictionary using a maximum loop to find
the most prolific committer.
'''

name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"

handle = open(name)
sender_count = dict()

for lines in handle:
    words = lines.split()
    if len(words) < 1:
        continue
    else:
        if words[0] == 'From':
            sender_count[words[1]] = sender_count.get(words[1], 0) + 1

big_count = None
big_key = None

for k, v in sender_count.items():
    if big_count is None or v > big_count:
        big_count = v
        big_key = k

print(big_key, big_count)
