#WordPress Site Sync
Downloads the latest posts, uploads, and plugins from a WordPress site to a local WordPress installation.

## Description
This script exports a WordPress database to a specified location on the server, renames it (to add a timestamp), downloads it, unzips it, adjusts a few WordPress options, imports the database to your local MySQL installation, deletes the uncompressed database, and mirrors the uploads and plugins folders.

If all goes well, your WordPress posts, uploads, and plugins should be identical on your development and production servers. Also, you will have database backups stored on your server and local machine.

## Usage
Open `config-sample.sh` it in your favorite text editor and edit the variables. Rename file to `config.sh` when complete.

Run the script in a terminal using `bash wpSiteSync.sh` or `sh wpSieSync.sh`.

The script assumes that you can SSH to your production server and run MySQL commands in the command line.

**Note:** The MySQL user only needs 'select' and 'lock tables' privileges to complete the database export.


## Issues
This script is not perfect by any means. *Please* backup before running this! Here are some possible issues:

- The script continues to run when errors occur.
- Currently only works with MAMP since it assumes that your MySQL CLI is accessible at `/applications/MAMP/library/bin/mysql`. This should be easy  to fix for other systems.
- Requires local database to have same name as server database (this could easily be changed).
- Does not support database passwords that contain certain special characters.

If you encounter other issues, please email [developer@bupipedream](mailto:developer@bupipedream.com).

## Credit
Developed by students at [Pipe Dream](http://www.bupipedream.com/), the student-run newspaper at Binghamton University.

**Authors:** Daniel O'Connor / Lead Web Developer