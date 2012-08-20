# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'nokogiri'

class Gpx2kml

  def initialize
    @coords = Array.new
  end

  attr :coords

  def add_file(path)
    p 'add_file'
    p "path : #{path}"
    f = File.new(path)
    doc = Nokogiri::XML(f)
    doc.remove_namespaces!
    a = Array.new
    error_count = 0

    trackpoints = doc.xpath('//gpx/trk/trkseg/trkpt')
    trackpoints.each do |wpt|
      w = {
        :lat => wpt.xpath('@lat').to_s.to_f,
        :lon => wpt.xpath('@lon').to_s.to_f,
        :time => proc_time(wpt.xpath('time').children.first.to_s),
        :alt => wpt.xpath('ele').children.first.to_s.to_f
      }

      if self.class.coord_valid?(w[:lat], w[:lon], w[:alt], w[:time])
        a << w
      else
        error_count += 1
      end
    end
    f.close

    @coords += a
    @coords = @coords.sort { |b, c| b[:time] <=> c[:time] }
    p @coords
  end

  def save(filename)
    p 'save_file'
    p filename
    #f = File.open(filename, 'w')
    #f.puts xml
    #f.close
  end



  # Only import valid coords
  def self.coord_valid?(lat, lon, elevation, time)
    return true if lat and lon
    return false
  end

  def self.proc_time(ts)
    if ts =~ /(\d{4})-(\d{2})-(\d{2})T(\d{1,2}):(\d{2}):(\d{2})Z/
      return Time.gm($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i).localtime
    end
  end

  def proc_time(ts)
    self.class.proc_time(ts)
  end

end
