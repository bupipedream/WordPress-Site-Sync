#============== WordPress SITE SYNC =================== 
#
# Author: Daniel O'Connor / daniel@danoc.me
#
# This script downloads the latest posts, uploads, 
# and plugins from a WordPress site. It was created 
# by Pipe Dream (www.bupd.me) to download the newest 
# content before development. 
#
# It exports the database to a specified location on 
# the server, renames it (to add a timestamp), 
# downloads it, unzips it, adjusts a few WordPress 
# options, imports the database, deletes the 
# uncompressed database, and mirrors the uploads and 
# plugins folders.
#
# If all goes well, your WordPress posts, uploads, 
# and plugins should be identical on your development
# and production servers. 
#
# WARNING: This script will mirror your production
# server's uploads and plugins folder. Any local
# changes will be deleted. Also, I am not a bash
# expert by any means. Please use this at your own
# risk and always backup!
#
#======================================================

source $(dirname $0)/config.sh

#===================#
#     COMMANDS      #
#===================#

echo "Exporting the databse..."
ssh ${SSH_USER}@${SSH_DOMAIN} "mysqldump --add-drop-table -h localhost -u ${DB_USER} --password=${DB_PASS} ${DB_NAME} | bzip2 -c > ${SERVER_EXPORT_DIR}/${DB_NAME}.sql.bz2"
echo "Export completed."

echo "Renmaing file..."
ssh ${SSH_USER}@${SSH_DOMAIN} "mv ${SERVER_EXPORT_DIR}/${DB_NAME}.sql.bz2 ${SERVER_EXPORT_DIR}/${FILE_NAME}.sql.bz2"
echo "File renamed."

echo "Downloading the databse..."
scp ${SSH_USER}@${SSH_DOMAIN}:${SERVER_EXPORT_DIR}/${FILE_NAME}.sql.bz2 ${OUTPUT_DIR}/
echo "Download completed."

echo "Unzip database..."
bzip2 -d -f -k "${OUTPUT_DIR}/${FILE_NAME}.sql.bz2"
echo "Unzip completed."

echo "Appending custom SQL to end of file..."
echo "UPDATE \`${DB_NAME}\`.\`${DB_PREFIX}_options\` SET \`option_value\` = '${LOCAL_URL}' WHERE \`${DB_PREFIX}_options\`.\`option_name\` ='siteurl';" >> ${OUTPUT_DIR}/${FILE_NAME}.sql
echo "UPDATE  \`${DB_NAME}\`.\`${DB_PREFIX}_options\` SET  \`option_value\` =  '${LOCAL_URL}' WHERE  \`${DB_PREFIX}_options\`.\`option_name\` ='home';" >> ${OUTPUT_DIR}/${FILE_NAME}.sql
echo "Appended."

echo "Importing database..." # THIS WILL ONLY WORK WITH MAMP
/applications/MAMP/library/bin/mysql -h localhost -u root -proot ${DB_NAME} < ${OUTPUT_DIR}/${FILE_NAME}.sql
echo "Import completed."

echo "Delete uncompressed database..."
rm ${OUTPUT_DIR}/${FILE_NAME}.sql
echo "Uncompressed database deleted"

echo "Mirroring uploads and plugins..."
rsync --delete -avz -e ssh ${SSH_USER}@${SSH_DOMAIN}:${SERVER_WPCONTENT_DIR}/uploads ${LOCAL_WPCONTENT_DIR}
rsync --delete -avz -e ssh ${SSH_USER}@${SSH_DOMAIN}:${SERVER_WPCONTENT_DIR}/plugins ${LOCAL_WPCONTENT_DIR}
echo "Uploads mirrored."

echo "DONE!"