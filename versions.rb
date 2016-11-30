#!/usr/bin/env ruby

require 'fileutils'
#require 'pry'

DAY_IN_SECS = 24.0 * 60.0 * 60.0
TWO_HOURS_IN_SECS = 2.0 * 60.0 * 60.0
TEN_MINS_IN_SECS = 10.0 #* 60.0

Dir.mkdir('./Versions') unless Dir.exists?('./Versions')

def versions
  files = Dir.glob("./**/*.{doc,docx,xls,xlsx,ods,odt,csv,txt,rtf,psd,rb}")
  files.each do |filepath|
    # skip backup files
    next if filepath.include?('Versions')

    # skip file if not modified recently
    next if Time.now - File.mtime(filepath) > TEN_MINS_IN_SECS

    # split filepath into name and path
    name = File.basename(filepath)
    path = filepath[2..filepath.size-name.size-2]

    # skip this file
    next if name == 'versions' || name == 'versions.rb'
    
    #binding.pry
    puts "  filepath=#{filepath.inspect}"
    puts "  path=#{path}"
    puts "  name=#{name}"

    # make sure /Versions directory exists
    versions_dir = "./#{path}/Versions"
    Dir.mkdir(versions_dir) unless Dir.exists?(versions_dir)

    # copy file
    FileUtils.cp(filepath, "#{versions_dir}/#{name}")
    puts "  Version saved: #{filepath}"
  end
end

# main loop
loop do
  versions
  puts 'Versions completed at ' + Time.now.strftime('%A, %d %b %Y %l:%M %p')
  puts '================================'
  sleep(TEN_MINS_IN_SECS)
end
