CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

if [ "$(uname)" = "Darwin" ]; then
    # MAC
    . $CURRENT/mount-mac.sh
else
    # WIN
    . $CURRENT/mount-win.sh
fi

# playdate.file.load がユーザーフォルダから読み込めないのでKicooya.pdxにファイルをコピーしている
TARGET_FACES_PATH="${KICOOYA_PDC_FULL_PATH}/faces-user"

# ユーザーフォルダから読み込めるようになったらこちらに変更
#TARGET_FACES_PATH="${PLAYDATE_DRIVE}Data/com.abenokobo.kicooya/faces"

. $CURRENT/build-impl.sh

if [ "$(uname)" = "Darwin" ]; then
    # MAC
    . $CURRENT/unmount-mac.sh
else
    # WIN
    . $CURRENT/unmount-win.sh
fi

. $CURRENT/run-device.sh

exit 0