# To run this, you can install BeautifulSoup
# https://pypi.python.org/pypi/beautifulsoup4

# Or download the file
# http://www.py4e.com/code3/bs4.zip
# and unzip it in the same directory as this file

import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')

count = input('Enter count: ')
count = int(count) + 1

position = input('Enter position: ')
position = int(position) - 1

counter = 0
while counter < count:
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, 'html.parser')

# http://py4e-data.dr-chuck.net/known_by_Fikret.html
# http://py4e-data.dr-chuck.net/known_by_Ritchie.html

# Retrieve all of the anchor tags, print the current url and assign new url
# based on position
    tags = soup('a')
    print(url)
    url = tags[position].get('href', None)  # assigning result as new url
    counter = counter + 1
