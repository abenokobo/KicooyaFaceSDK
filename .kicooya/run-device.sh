CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

if [ "$(uname)" = "Darwin" ]; then
    # MAC
    PD_DEVICE_PATH=$(ls -1 /dev/cu.usbmodemPDU* | head -n 1)
    if [ "$PD_DEVICE_PATH" = "" ]; then
        echo "Playdate is not connected or in use."
        exit 1
    fi
    $PDUTIL_PATH $PD_DEVICE_PATH run $KICOOYA_PDC_NAME
else
    # WIN
    $PDUTIL_PATH run $KICOOYA_PDC_NAME >/dev/null
fi
