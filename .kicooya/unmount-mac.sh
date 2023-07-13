diskutil eject /Volumes/PLAYDATE >/dev/null
for j in {1..30}; do
    if [ -e "$PLAYDATE_DRIVE" ]; then
        sleep 1
    else
        echo "== Playdate is unmounted."
        sleep 3
        return 0
    fi
done
