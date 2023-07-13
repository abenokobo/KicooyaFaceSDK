CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

PD_DEVICE_PATH=$(ls -1 /dev/cu.usbmodemPDU* | head -n 1)
if [ "$PD_DEVICE_PATH" = "" ]; then
    echo "== Playdate is not connected or in use."
    exit 1
fi

UTIL_RET=$("$PDUTIL_PATH" $PD_DEVICE_PATH datadisk)
if [ -n "$UTIL_RET" ]; then
    echo "== Error : ${UTIL_RET}"
    echo "== Playdate is not connected or in use."
    exit 1
fi

PLAYDATE_DRIVE="/Volumes/PLAYDATE/"
KICOOYA_PDC_NAME="Games/Kicooya.pdx"

/bin/echo -n "== Waiting for Playdate to mounted "
for i in {1..180}; do
    if [ -e "$PLAYDATE_DRIVE" ]; then
        echo ""
        /bin/echo -n "== Searching for Kicooya "
        for j in {1..30}; do
            KICOOYA_PDC_FULL_PATH="/Volumes/PLAYDATE/Games/Kicooya.pdx"
            if [ -e "$KICOOYA_PDC_FULL_PATH" ]; then
                echo ""
                echo "== Kicooya is found."
                return 0
            fi

            KICOOYA_PDC_FULL_PATH=$(find /Volumes/PLAYDATE/Games/User/user.*.kicooya.pdx -maxdepth 0 2>/dev/null)
            FIND_RET=$?
            if [ $FIND_RET == 0 ] && [ "$KICOOYA_PDC_FULL_PATH" != "" ]; then
                echo ""
                echo "== Kicooya is found."
                KICOOYA_PDC_NAME=$(echo ${KICOOYA_PDC_FULL_PATH#$PLAYDATE_DRIVE})
                return 0
            fi

            /bin/echo -n "."
            sleep 1
        done

        echo "== Time out. Kicooya is not found."
        exit 1
    else
        /bin/echo -n "."
        sleep 1
    fi
done

echo "== Time out. Playdate is not mounted."
exit 1



