import urllib.request
import urllib.parse
import urllib.error
import xml.etree.ElementTree as ET

# serviceurl = 'http://maps.googleapis.com/maps/api/geocode/xml?'
# http://py4e-data.dr-chuck.net/comments_42.xml

url = input('Enter location: ')

# url = urllib.parse.urlencode({'address': address})
print('Retrieving', url)
uh = urllib.request.urlopen(url)
data = uh.read()
print('Retrieved', len(data), 'characters')
# print(data.decode())
tree = ET.fromstring(data)
counts = tree.findall('.//count')

print('Count: ', len(counts))

sum_total = 0
for count in counts:
    sum_total = sum_total + int(count.text)

print('Sum: ', sum_total)
'''
    results = tree.findall('result')
    lat = results[0].find('geometry').find('location').find('lat').text
    lng = results[0].find('geometry').find('location').find('lng').text
    location = results[0].find('formatted_address').text

    print('lat', lat, 'lng', lng)
    print(location)
'''