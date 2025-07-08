The script searches for files in a given folder to find possible duplicates.
It uses the find command with the -print0 option. This helps handle file names with spaces or special characters.

For each file found, the script:
  gets the file size in bytes
  gets the file name
  removes the file extension

Then the script loops again to:
  look for other files in the folder with the same size
  get their names without the path and extension
  check that it’s not the same file
  compare the base names without extensions

If it finds another file with the same base name and size, it prints a message about possible duplicates.
There is also a commented-out rm command in the script that would delete the duplicate file.
