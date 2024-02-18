#!/bin/bash 

# PLC Details
PLC_IP=$1
USER_NAME=$2
PASSWORD = $3
PLC_RACK=0
PLC_SLOT=1
PG_ID=1


if test "$#" -ne 1; then
    echo       "   ----------------------------------------------------------------"
    echo "    [!] please give the target PLC to backup  : s7-backup 172.16.21.199 user password "
    echo       "   ---------------------------------------------------------------"
    exit
fi



# Backup Directory (Create if it doesn't exist)
BACKUP_DIR="s7backup"
mkdir -p "$BACKUP_DIR"

# Choose Authentication Method (Uncomment the relevant line)
# AUTH_METHOD="USER_NAME;PASSWORD" # Basic Password
# AUTH_METHOD="USER_LEVEL;1"       # S7-SCL User Level
# AUTH_METHOD="CPU_ACCESS_PASSWORD" # CPU Access Password (S7-1200/1500)

# Authenticate based on chosen method
case "$AUTH_METHOD" in
  USER_NAME;PASSWORD)
    snap7 connect "$PLC_IP;$PLC_RACK;$PLC_SLOT;$PG_ID;USER_NAME=PLACEHOLDER_USERNAME;PASSWORD=PLACEHOLDER_PASSWORD"
    ;;
  USER_LEVEL;*)
    snap7 connect "$PLC_IP;$PLC_RACK;$PLC_SLOT;$PG_ID;USER_LEVEL=$USER_LEVEL"
    ;;
  CPU_ACCESS_PASSWORD)
    snap7 connect "$PLC_IP;$PLC_RACK;$PLC_SLOT;$PG_ID;PASSWORD=$CPU_ACCESS_PASSWORD"
    ;;
  *)
    echo "Error: Invalid authentication method. Please choose an appropriate option."
    exit 1
    ;;
esac

# Get All Code Blocks
BLOCKS=$(snap7 listblocks -r)

# Backup Each Block
for BLOCK in $BLOCKS; do
  FILENAME="$BACKUP_DIR/$BLOCK.s7p"
  snap7 getblock -b "$BLOCK" -f "$FILENAME" -r
  echo "Block $BLOCK backed up to $FILENAME"
done

# Disconnect from PLC
snap7 disconnect

echo "S7 PLC backup completed!"
