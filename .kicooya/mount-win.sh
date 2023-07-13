CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

echo "== Waiting for Playdate to mounted ..."
UTIL_SUCCESS="Playdate data disk mounted as "
UTIL_RET=$("$PDUTIL_PATH" datadisk | grep "$UTIL_SUCCESS")

if [ "$UTIL_RET" = "" ]; then
    echo "== Playdate is not connected or in use."
    exit 1
else
    PLAYDATE_DRIVE=${UTIL_RET#$UTIL_SUCCESS}
    PLAYDATE_DRIVE=${PLAYDATE_DRIVE/\\/\/}
fi

if [ "$PLAYDATE_DRIVE" = "" ]; then
    echo "== Playdate is not connected or in use."
    exit 1
fi

KICOOYA_PDC_NAME="Games/Kicooya.pdx"

for i in {1..30}; do
    if [ -e "$PLAYDATE_DRIVE" ]; then
        echo "== Playdate is mounted."

        KICOOYA_PDC_FULL_PATH="$PLAYDATE_DRIVE"Games/Kicooya.pdx
        if [ -e "$KICOOYA_PDC_FULL_PATH" ]; then
            echo "== Kicooya is found."
            return 0
        fi

        KICOOYA_PDC_FULL_PATH=$(find "$PLAYDATE_DRIVE"Games/User/user.*.kicooya.pdx -maxdepth 0 2>/dev/null)
        FIND_RET=$?
        if [ $FIND_RET == 0 ] && [ "$KICOOYA_PDC_FULL_PATH" != "" ]; then
            echo "== Kicooya is found."
            KICOOYA_PDC_NAME=$(echo ${KICOOYA_PDC_FULL_PATH#$PLAYDATE_DRIVE})
            return 0
        fi

        echo "== Kicooya is not found."
        exit 1
    else
        echo -n "."
        sleep 1
    fi
done

echo "== Time out. Playdate is not mounted."
exit 1
