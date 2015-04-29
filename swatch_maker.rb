require 'ase'
require 'rexml/document'

class Color
  attr_accessor :name, :value
    def initialize(name, value)
      @name = name
      @value = value
    end

    def remove_alpha_hex
      val = nil
      val = @value
      if @value.size == 9
        val.slice!(1,2)
      end
      val
    end
end


def write_ase(name,colors,output)
  ase_doc = ASE.new
  palette = ASE::Palette.new(name)
  colors.each do | color |
    p color.value
    palette.add color.name, ASE::Color::RGB.from_hex(color.remove_alpha_hex)
  end
  ase_doc << palette
  ase_doc.to_file(output)
end


def parse_android_xml(rexml_doc)
  colors = []
  unless rexml_doc.elements["resources/item"].nil?
     colors = parse_android_resource_xml(rexml_doc)
  else
    p 'not resource'
  end
  colors
end

def parse_android_resource_xml(rexml_doc)
  colors = []
  rexml_doc.elements.each('resources/item') do |item|
    if item.attributes['type'] == 'color'
      colors.push Color.new(item.attributes['name'],item.text)
    end
  end
  colors
end

def read_android_color()
  files =  Dir.glob("**/*.xml")
  colors = []
  files.each do | file |
    p 'filename :' + file
    doc = REXML::Document.new(open(file))
    colors.concat parse_android_xml(doc)
  end
  colors
end

colors = read_android_color()
write_ase('My Colors',colors, 'file.ase' )
