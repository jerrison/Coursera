import json
import urllib.request
import urllib.parse
import urllib.error

# http://py4e-data.dr-chuck.net/comments_42.json
# http://py4e-data.dr-chuck.net/comments_45758.json
url = input('Enter location: ')
print('Retrieving', url)

uh = urllib.request.urlopen(url)
data = uh.read()
print('Retrieved', len(data), 'characters')

info = json.loads(data)
lst = info['comments']

summation = 0
for comment in lst:
    summation = summation + comment['count']

print('Count: ', len(lst))
print('Sum: ', summation)
# print(info)
# print(lst)
