if [ "$_COMMON_SH" = "defined" ]; then
    return 0
fi
_COMMON_SH="defined" 

# PLAYDATE_SDK_PATH
if [ "$(uname)" = "Darwin" ]; then
    # MAC
    if [ "$PLAYDATE_SDK_PATH" = "" ]; then
        PLAYDATE_SDK_PATH="$HOME/Developer/PlaydateSDK"
    fi
else
    # WIN
    :
fi

# for dev
if [ "$KICOOYA_PDC_PATH" = "" ]; then
    KICOOYA_PDC_PATH="./.kicooya"
fi

PDC_PATH="$PLAYDATE_SDK_PATH/bin/pdc"
PDUTIL_PATH="$PLAYDATE_SDK_PATH/bin/pdutil"

if [ "$(uname)" = "Darwin" ]; then
    # MAC
    PLAYDATE_SIMULATOR_PATH="$PLAYDATE_SDK_PATH/bin/Playdate Simulator.app/Contents/MacOS/Playdate Simulator"
else
    # WIN
    PLAYDATE_SIMULATOR_PATH="$PLAYDATE_SDK_PATH/bin/PlaydateSimulator.exe"
fi

