# versions

Ruby utility to regularly save versions of files undergoing modification in apps such as Word, Photoshop, etc. Useful for going back to a previous version or the most recent version if a crash or other event damages the main file.

# Why I created this

My wife is a virtual assistant and uses a Mac to create many files for clients. Sometimes she would like to return to an earlier version of a file, even days earlier. Program crashes or other problems can also damage files and a separate set of versioned copies can save the day.

This utility is put into the top directory of her projects and started in a Terminal window with 'ruby versions.rb' (or rename it 'versions', 'chmod +x versions' and './versions').

Every ten minutes it searches in the entire directory tree for files with extensions doc, docx, xls, xlsx, ods, odt, csv, txt, rtf, psd, and rb that have been changed in the last ten minutes, and copies each one to a directory named /Versions in the directory containing the file.

Versioned copies have the same extension as the original file, and so are easily opened.
