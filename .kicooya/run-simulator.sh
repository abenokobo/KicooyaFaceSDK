CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

"$PLAYDATE_SIMULATOR_PATH" "$KICOOYA_PDC_PATH/Kicooya.pdx"
