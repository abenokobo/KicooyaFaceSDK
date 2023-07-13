CURRENT=$(cd $(dirname $0);pwd)
. $CURRENT/common.sh

echo "== Build faces ..."
$PDC_PATH -q Source faces
PDC_ERR=$? 
if [ $PDC_ERR -gt 0 ]; then
    exit $PDC_ERR
fi

echo "== Remove old faces ..."
FACES_PATH=$(find faces.pdx -mindepth 1 -maxdepth 1 -type d -exec echo {} \;)
for line in $FACES_PATH
do
    rm -f -R ${TARGET_FACES_PATH}${line#faces.pdx}
done

echo "== Copy faces ..."
mkdir -p $TARGET_FACES_PATH
for line in $FACES_PATH
do
    cp -r $line $TARGET_FACES_PATH
done

echo "== Remove build files ..."
rm -f -R faces.pdx

echo "== Finish build faces."

return 0

