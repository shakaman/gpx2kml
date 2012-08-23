# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name         = "gpx2kml"
  s.version      = "0.0.1"
  s.authors      = ["Maxim Bénadon"]
  s.email        = ["mbenadon@shakaman.com"]
  s.homepage     = "https://github.com/shakaman/gpx2kml"
  s.summary      = "Convert gpx file to kml"
  s.description  = "Convert gpx file to kml"

  s.executables  = ["gpx2kml"]
  s.files        = `git ls-files README.md LICENSE lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = ['lib']

  s.add_dependency "nokogiri"
  s.add_dependency "mini_exiftool"
end
