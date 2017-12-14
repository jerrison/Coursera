import re

string = '<p>Please click <a href="http://www.dr-chuck.com">here</a></p>'

x = re.findall('href="(.+)"', string)

print(x)