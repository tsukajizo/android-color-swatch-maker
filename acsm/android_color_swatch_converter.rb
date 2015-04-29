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
    log color.value
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
    log 'not resource'
  end
  colors
end

def parse_android_resource_xml(rexml_doc)
  colors = []
  rexml_doc.elements.each('resources/item') do |item|
    if item.attributes['type'] == 'color' && item.text.start_with?('#')
      colors.push Color.new(item.attributes['name'],item.text)
    end
  end
  colors
end

def read_android_color(project_path)
  path = project_path + "/**/*.xml"
  files =  Dir.glob(path)
  colors = []
  files.each do | file |
    log 'filename :' + file
    doc = REXML::Document.new(open(file))
    colors.concat parse_android_xml(doc)
  end
  colors
end

def log(arg)
  if $output_log
    p arg
  end
end
