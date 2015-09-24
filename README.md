# backup

Ruby utility to save files with recent modifications in case of crashes

# Why I created this

My wife is a virtual assistant and uses a Mac to create many files for clients. Sad to say, many apps are prone to crashes, especially Libre Office, which is otherwise a decent replacement for Microsoft Word.

She does all her work in directories under ~/Clients. So this utility is put into the ~/Clients directory and started with 'ruby backup.rb' (or rename it 'backup', 'chmod +x backup' and './backup').

Every five minutes it checks for files with extensions doc, docx, xls, xlsx, ods, odt, csv, txt,rtf, psd, and rb under ~/Clients that have been changed in the last ten minutes, and for those it finds it copies them to ~/Clients/Backups with the same directory structure.

So, if she starts the backup program, saves her work frequently, and her app crashes, there should be a recent copy of her working file under /Backups.
