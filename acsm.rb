require 'optparse'
require './acsm/android_color_swatch_converter.rb'

$output_log = false
path = './'
filename = './bin/android.ase'
palette_name = 'Android'

opt = OptionParser.new

opt.on('-l','output log') do |v|
  $output_log = v
end

opt.on('--output val','set output filename  [default : android.ase]') do |v|
  filename = v
end


opt.on('--path val','set android project\'s path [default : ./]') do |v|
  path = v
end

opt.on('--name val','set palette name [default : Android]') do |v|
  palette_name = v
end


opt.on()

if __FILE__ == $0
  opt.parse!(ARGV)
  colors = read_android_color(path)
  write_ase(palette_name,colors, filename)
end
