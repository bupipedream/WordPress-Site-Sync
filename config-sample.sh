#===================#
#     VARIABLES     #
#===================#

##
# @SSH_USER:	User to login to server
# @SSH_DOMAIN:	Domain to SSH into
#
SSH_USER=""
SSH_DOMAIN=""


##
# @LOCAL_WPCONTENT_DIR:	  Path to wp-content locally
# @SERVER_WPCONTENT_DIR:  Path to wp-content on server	
# @SERVER_EXPORT_DIR:	  Location to store database dumps on server
# @OUTPUT_DIR:			Location to store database download locally
#
# NOTE: No trailing slashes, and no quotes around OUTPUT_DIR
#
LOCAL_WPCONTENT_DIR="/local/path/to/wp-content"
SERVER_WPCONTENT_DIR="/server/path/to/wp-content"
SERVER_EXPORT_DIR="/server/path/to/dump/db/export"
OUTPUT_DIR="/local/path/to/dump/db/export"


##
# @DB_NAME:	WordPress database name
# @DB_USER: 	MySQL user to export database
# @DB_PASS: 	MySQL user's password
# @DB_PREFIX:	WordPress table prefix (WP default is: wp)	
#
DB_NAME=""
DB_USER=""
DB_PASS=""
DB_PREFIX="wp"


##
# @FILE_NAME:	Name of the database dump (do not change!)
#
FILE_NAME=${DB_NAME}-$(date +"%Y-%m-%d-%H-%M-%S") 

##
# @LOCAL_URL: Local address of WordPress site
#
LOCAL_URL="http://localhost:8888/YOURWEBSITE/"