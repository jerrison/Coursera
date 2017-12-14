import re

fh = open('regex_sum_45753.txt')

lst = list()
for lines in fh:
    numbers = re.findall('[0-9]+', lines)
    if len(numbers) == 0:
        continue
    for number in numbers:
        int_number = int(number)
        lst.append(int_number)

print(sum(lst))
