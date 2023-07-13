for i in {1..3}; do
    powershell -command "\$driveEject = New-Object -comObject Shell.Application ; \$driveEject.Namespace(17).ParseName(\"${PLAYDATE_DRIVE/%?/}\").InvokeVerb(\"Eject\")"
    for j in {1..10}; do
        if [ -e "$PLAYDATE_DRIVE" ]; then
            sleep 1
        else
            echo "== Playdate is unmounted."
            sleep 3
            return 0
        fi
    done
done

echo "== Time out. Playdate is not mounted."
exit 1
