CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

# playdate.file.load がユーザーフォルダから読み込めないのでKicooya.pdxにファイルをコピーしている
TARGET_FACES_PATH="$KICOOYA_PDC_PATH/Kicooya.pdx/faces-user"

# ユーザーフォルダから読み込めるようになったらこちらに変更
#TARGET_FACES_PATH="$PLAYDATE_SDK_PATH/Disk/Data/com.abenokobo.kicooya/faces"

. $CURRENT/build-impl.sh
exit $?
