#!/usr/bin/env ruby

require 'fileutils'
#require 'pry'

DAY_IN_SECS = 24.0 * 60.0 * 60.0
TWO_HOURS_IN_SECS = 2.0 * 60.0 * 60.0
TEN_MINS_IN_SECS = 10.0 * 60.0

Dir.mkdir('./Backups') unless Dir.exists?('./Backups')

def backup
  files = Dir.glob("./**/*.{doc,docx,xls,xlsx,ods,odt,csv,txt,rtf,psd,rb}")
  files.each do |filepath|
    # skip backup files
    next if filepath.include?('Backup')
    next if filepath.include?('backup')

    # skip files not modified irecently
    next if Time.now - File.mtime(filepath) > TEN_MINS_IN_SECS

    # split filepath into name and path
    pp = filepath.size
    name = File.basename(filepath)
    nn = name.size
    dir = filepath[2..pp-nn-1]

    # make sure save directory exists
    unless Dir.exists?('./Backups/' + dir)
      savedir = './Backups/'
      ddirs = dir.split('/')
      ddirs.each do |ddir|
        savedir << (ddir + '/')
        Dir.mkdir(savedir)
        puts ' Created dir ' + savedir
      end
    end

    # copy file
    FileUtils.cp(filepath, './Backups/' + dir + name)
    puts '  Saved ' + filepath

  end
end

loop do
  backup
  puts 'Backup completed at ' + Time.now.strftime('%A, %d %b %Y %l:%M %p')
  sleep(300.0)
end
