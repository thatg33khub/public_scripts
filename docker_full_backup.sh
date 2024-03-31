#!/bin/bash

# DEFINE VARIABLES
SOURCEDIR=/opt/stacks
BACKUPDIR=/mnt/Backup/
HOSTNAME=$(uname -n)
TIME=date +"%D %T"
DAYS=5

# BACKUP COMPOSE AND APPDATA
echo "Create zip archive with timestamp"
zip -r $BACKUPDIR/$HOSTNAME-$(date +"%Y-%m-%d-%Hh%M").zip $SOURCEDIR/

echo "remove old backups"
find $BACKUPDIR . -maxdepth 1 -name '*.zip' -mtime +5 -exec rm {} \;


# START DB BACKUP
echo "Backup databases"


# mysql/mariadb containers backup
CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'mysql\|mariadb' | cut -d":" -f1)
echo $TIME
echo $CONTAINER

if [ ! -d $BACKUPDIR ]; then
    mkdir -p $BACKUPDIR
fi

for i in $CONTAINER; do
    MYSQL_DATABASE=$(docker exec $i env | grep MYSQL_DATABASE |cut -d"=" -f2)
    MYSQL_PWD=$(docker exec $i env | grep MYSQL_ROOT_PASSWORD |cut -d"=" -f2)

    docker exec -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_PWD=$MYSQL_PWD \
        $i /usr/bin/mysqldump -u root $MYSQL_DATABASE \
        | gzip > $BACKUPDIR/$i-$MYSQL_DATABASE-$(date +"%Y%m%d%H%M").sql.gz

    OLD_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


# bitwarden backup
BITWARDEN_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'bitwarden' | cut -d":" -f1)
echo $TIME
echo $BITWARDEN_CONTAINER

for i in $BITWARDEN_CONTAINER; do
    docker exec  $i /usr/bin/sqlite3 data/db.sqlite3 .dump \
        | gzip > $BACKUPDIR/$i-$(date +"%Y%m%d%H%M").sql.gz

    OLD_BITWARDEN_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_BITWARDEN_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


# uptimekuma backup
uptimekuma_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'uptimekuma' | cut -d":" -f1)
echo $TIME
echo $uptimekuma_CONTAINER

for i in $uptimekuma_CONTAINER; do
    docker exec  $i /usr/bin/sqlite3 data/db.sqlite3 .dump \
        | gzip > $BACKUPDIR/$i-$(date +"%Y%m%d%H%M").sql.gz

    OLD_uptimekuma_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_uptimekuma_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


# paperless backup
paperless_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'paperless' | cut -d":" -f1)
echo $TIME
echo $paperless_CONTAINER

for i in $paperless_CONTAINER; do
    docker exec  $i /usr/bin/sqlite3 data/db.sqlite3 .dump \
        | gzip > $BACKUPDIR/$i-$(date +"%Y%m%d%H%M").sql.gz

    OLD_paperless_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_paperless_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


# portainer backup
portainer_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'portainer' | cut -d":" -f1)
echo $TIME
echo $portainer_CONTAINER

for i in $portainer_CONTAINER; do
    docker exec  $i /usr/bin/sqlite3 data/db.sqlite3 .dump \
        | gzip > $BACKUPDIR/$i-$(date +"%Y%m%d%H%M").sql.gz

    OLD_portainer_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_portainer_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


# memos backup
memos_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'memos' | cut -d":" -f1)
echo $TIME
echo $memos_CONTAINER

for i in $memos_CONTAINER; do
    docker exec  $i /usr/bin/sqlite3 data/db.sqlite3 .dump \
        | gzip > $BACKUPDIR/$i-$(date +"%Y%m%d%H%M").sql.gz

    OLD_memos_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
    if [ $OLD_memos_BACKUPS -gt $DAYS ]; then
        find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
    fi
done


echo $TIME
echo "Databases backup completed"

