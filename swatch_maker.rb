require 'rexml/document'

files =  Dir.glob("**/*.xml")
files.each do | file |
  p 'filename :' + file
  doc = REXML::Document.new(open(file))
  puts doc.elements['items']
end
