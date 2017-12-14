'''
from bs4 import BeautifulSoup

fname = 'Library.xml'

print(BeautifulSoup(fname, "xml").prettify())
'''

import xml.dom.minidom

fname = 'Library.xml'

xml = xml.dom.minidom.parse(fname)
pretty_xml_as_string = xml.toprettyxml()

print(pretty_xml_as_string)