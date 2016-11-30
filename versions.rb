#!/usr/bin/env ruby

require 'fileutils'
#require 'pry'

DAY_IN_SECS = 24.0 * 60.0 * 60.0
TWO_HOURS_IN_SECS = 2.0 * 60.0 * 60.0
INTERVAL_IN_SECS = 60.0 #* 10.0 #* 60.0

Dir.mkdir('./Versions') unless Dir.exists?('./Versions')

def versions
  files = Dir.glob("./**/*.{doc,docx,xls,xlsx,ods,odt,csv,txt,rtf,psd,rb}")

  files.each do |filepath|
    # skip backup files
    next if filepath.include?('Versions')

    # skip file if not modified recently
    next if Time.now - File.mtime(filepath) > INTERVAL_IN_SECS

    # split filepath into name and path
    name = File.basename(filepath)
    path = filepath[2..filepath.size-name.size-2]

    # skip this file
    next if name == 'versions' || name == 'versions.rb'

    # make sure /Versions directory exists
    versions_dir = "./#{path}/Versions"
    Dir.mkdir(versions_dir) unless Dir.exists?(versions_dir)

    # create versioned filename
    prefix = Time.now.strftime('%Y.%m.%d %H.%M')
    version_path = "#{versions_dir[2..versions_dir.size-1]}/#{prefix}-#{name}"

    # copy file
    FileUtils.cp(filepath, version_path)

    # tell the world
    puts "#{prefix}-#{name}"
  end
end

# main loop
puts "Versions started..."
loop do
  versions
  sleep(INTERVAL_IN_SECS)
end
