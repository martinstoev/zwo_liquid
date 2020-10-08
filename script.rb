require 'liquid'

# usage in template:
#   {{Z1}}
variables = {
  "Z1" => "0.500",
  "Z2" => "0.649",
  "Z3" => "0.830",
  "Z4" => "0.982",
  "Z5" => "1.130",
  "SS" => "0.923",
  "MAX" => "3.000"
}

# usage in template:
#   {% duration 1:23:45 %} #=> 5025
#   {% duration 23:45 %} #=> 1425
#   {% duration 45 %} #=> 45
class Duration < Liquid::Tag
  def initialize(tag_name, duration, tokens)
     super
     elements = duration.split(":")
     hours = elements[-3].to_i
     minutes = elements[-2].to_i
     seconds = elements[-1].to_i
     @duration_in_sec = hours * 3600 + minutes * 60 + seconds
  end

  def render(context)
    @duration_in_sec.to_s
  end
end

Liquid::Template.register_tag('duration', Duration)

if ARGV.size < 1
  puts "ERROR: Plase specify the filename of the template (e.g. ruby ./script my_workout.zwo"
  exit 1
end

filename = ARGV[0]
text = File.open(filename).read

template = Liquid::Template.parse(text)
puts template.render(variables, { strict_variables: true })
