# Kicooya UserFace API Document

[日本語](api-jp.md)

UseFace Lua Script(`face.lua.path` in face.json) is loaded when Kicooya starts.

UseFace Lua Script must return an instance that extends `kicooya.face.userFace`.

Classes and functions related to Kicooya that are not published as specifications in this document are not assumed to be used from `kicooya.face.userFace` at this time.

- [`class kicooya.face.userFace`](#class-kicooyafaceuserface)
- [`class kicooya.audioAnalyzer`](#class-kicooyaaudioanalyzer)
- [`class kicooya.musicDB.song`](#class-kicooyamusicdbsong)
- [`class kicooya.font`](#class-kicooyafont)
- [`class kicooya.filePlayer`](#class-kicooyafileplayer)

## `class kicooya.face.userFace`

Class for creating your own Kicooya media playback screen (UserFace).

### `function kicooya.face.userFace:init()`

Constructor.

### `function kicooya.face.userFace:initializeFace(arg)`

This function is called only once when kicooya startup.

- arguments

  - `arg` \[`string`\] Arguments specified by `face.lua.arg` in face.json

### `function kcy.face.userFace:onActivate(active)`

This function is called when the active state of the playback screen is changed.

- arguments

  - `active` \[`boolean`\] Whether the playback screen is active or not.

### `function kcy.face.userFace:onPlayingChanged()`

This function is called when the playback status changes of a song.

### `function kicooya.face.userFace:updateNowPlaying(song)`

This function is called when the currently playing song changed.

- arguments

  - `song` \[`kicooya.musicDB.song`\] Song information of currently playing

### `function kicooya.face.userFace:updateBackground()`

This function is called when the currently playing song changed, so draw a background.

### `function kicooya.face.userFace:drawFace()`

This function is called frame by frame when a drawing, so draw what needs to be moved.

### `function kicooya.face.userFace:drawAudioVisualizer(analyzer)`

This function is called when drawing the AudioVisualizer. If this function is defined, the process of parsing audio data for rendering is performed. If you do not need to draw the AudioVisualizer, do not define this function.

- arguments

  - `analyzer` \[`kicooya.audioAnalyzer`\] Audio data analysis information currently playing

## `class kicooya.audioAnalyzer`

This class is used to get audio data analysis information currently playing.

### `function kicooya.audioAnalyzer.getAudioFrequencyDataCount()`

Returns the number of frequency/sound pressure (dB SPL) data for the audio data currently playing.

- return values

  - \[`integer`\] Number of frequency/sound pressure data

### `function kicooya.audioAnalyzer.getAudioFrequencyData(index)`

Returns the frequency/sound pressure (dB SPL) of the audio currently playing.

- arguments

  - `index` \[`integer`\] The index of the data

- return values

  - \[`integer`\] Frequency
  - \[`integer`\] Left Sound Pressure (dB SPL)
  - \[`integer`\] Right Sound Pressure (dB SPL)

### `kicooya.audioAnalyzer.getAudioBufferCount()`

Returns the number of data for the audio buffer currently playing.

- return values

  - \[`integer`\] Number of data

### `kicooya.audioAnalyzer.getAudioBuffer(index)`

Returns the the audio buffer currently playing.

- arguments

  - `index` \[`integer`\] The index of the data

- return values

  - \[Float\] Left audio data
  - \[Float\] Right audio data

## `class kicooya.musicDB.song`

This class is used to get song information.

<!--
### kicooya.musicDB.song:init(path, songRaw)
-->

### `kicooya.musicDB.song:getFilePath()`

Returns the file path.

- return values

  - \[`string`\] File path

### `kicooya.musicDB.song:getLargeArtImage()`

Returns the large art image.

- return values

  - \[`playdate.graphics.image`\] Large art image

### `kicooya.musicDB.song:getSmallArtImage()`

Returns the small art image.

- return values

  - \[`playdate.graphics.image`\] Small art image

<!--
### `kicooya.musicDB.song:hasCachedArtImage`
-->

### `kicooya.musicDB.song:getFileSize()`

Returns the size of a file.

- return values

  - \[`integer`\] size of a file

### `kicooya.musicDB.song:getFileSizeReadable()`

Returns string human readable file size.

- return values

  - \[`string`\] Human readable file size

### `kicooya.musicDB.song:getLastModified()`

Returns the modification date/time of the file.

- return values

  - \[`table`\] Same table as `playdate.file.modtime`, \* See `playdate.file.modtime` documentation.

### `kicooya.musicDB.song:getLastModifiedString()`

Returns string human readable last modified of file.

- return values

  - \[`string`\]  human readable last modified of file

### `kicooya.musicDB.song:getTitle()`

Returns the title.

- return values

  - \[`string`\] Title

### `kicooya.musicDB.song:getArtist()`

Returns the artist.

- return values

  - \[`string`\] Artist

### `kicooya.musicDB.song:getAlbum()`

Returns the album.

- return values

  - \[`string`\] Album

### `kicooya.musicDB.song:getAlbumArtist()`

Returns the album artist.

- return values

  - \[`string`\] Album artist

### `kicooya.musicDB.song:getGenre()`

Returns the genre.

- return values

  - \[`string`\] Genre

### `kicooya.musicDB.song:getComposer()`

Returns the composer.

- return values

  - \[`string`\] Composer

### `kicooya.musicDB.song:getEncodedBy()`

Return the name of the person or group that encoded.

- return values

  - \[`string`\] The name of the person or group that encoded

### `kicooya.musicDB.song:getTrack()`

Returns track information as TRCK/TRK(ID3Tag) string.

- return values

  - \[`string`\] track information

### `kicooya.musicDB.song:getTrackNumber()`

Returns the track number.

- return values

  - \[`integer`\] Track number

### `kicooya.musicDB.song:getNumberOfTracks()`

Returns the number of tracks.

- return values

  - \[`integer`\] Number of tracks

### `kicooya.musicDB.song:getDisc()`

Returns disc information as TPOS/TPA(ID3Tag) string.

- return values

  - \[`string`\] disc information

### `kicooya.musicDB.song:getDiscNumber()`

Returns the disc number.

- return values

  - \[`integer`\] Disc number

### `kicooya.musicDB.song:getNumberOfDiscs()`

Returns the number of discs.

- return values

  - \[`integer`\] Number of discs

### `kicooya.musicDB.song:getYear()`

Returns the year.

- return values

  - \[`integer`\] Year

### `kicooya.musicDB.song:getBitrate()`

Returns the bitrate.

- return values

  - \[`integer`\] Bitrate

### `kicooya.musicDB.song:getSamplingRate()`

Returns the sampling rate.

- return values

  - \[`integer`\] Sampling rate

### `kicooya.musicDB.song:getChannelCount()`

Returns the channel count.

- return values

  - \[`integer`\] Channel count

### `kicooya.musicDB.song:getFileFormat()`

Returns the file format.

Returns either "MP3(mono)" or "MP3(stereo)" because MP3 is the only format that can be played at this time.

- return values

  - \[`string`\] File format.

## `class kicooya.font`

This class is used to get `playdate.graphics.font` held by Kicooya.

### `function kicooya.font:getFont(id)`

Returns the font specified by the font UID.

- arguments

  - `id` \[`string`\] Font UID

- return values

  - \[`playdate.graphics.font`\] Font

|Font UID|Font file path|
|-|-|
|AshevilleSans24Light|assets/fonts/Asheville/Asheville Sans 24 Light/Asheville-Sans-24-Light|
|AshevilleSans14Light|assets/fonts/Asheville/Asheville Sans 14 Light/Asheville-Sans-14-Light|
|AshevilleSans14Bold|assets/fonts/Asheville/Asheville Sans 14 Bold/Asheville-Sans-14-Bold|
|FullCircle|assets/fonts/Full Circle/font-full-circle|
|CuberickBold|assets/fonts/Cuberick/font-Cuberick-Bold|
|NontendoLight|assets/fonts/Nontendo/Nontendo-Light|
|NontendoBold|assets/fonts/Nontendo/Nontendo-Bold|
|OklahomaBold|assets/fonts/Oklahoma/Oklahoma-Bold|
|Shinonome14B|assets/fonts/Shinonome/Shinonome14B|
|Shinonome16B|assets/fonts/Shinonome/Shinonome16B|
|Roobert10Bold|assets/fonts/Roobert/Roobert-10-Bold|
|Roobert11Medium|assets/fonts/Roobert/Roobert-11-Medium|
|Roobert20Medium|assets/fonts/Roobert/Roobert-20-Medium|

<!--
### function kicooya.font:getSimpleCellFont()
### function kicooya.font:getSimpleCellValueFont()
### function kicooya.font:getMenuFont()
-->

### `function kicooya.font:getTitleFont()`

Returns the font for drawing titles according to the `OPTION -> FONTS` setting.

- return values

  - \[`playdate.graphics.font`\] Font

### `function kicooya.font:getDescriptionFont()`

Returns the font for drawing the description according to the `OPTION -> FONTS` setting.

- return values

  - \[`playdate.graphics.font`\] Font

<!--
### `function kicooya.font:getPlayerFontType()`
### `function kicooya.font:setPlayerFontType()`
-->

## `class kicooya.filePlayer`

This class is used to operate the file player.

<!--
function kicooya.filePlayer:initializePlayer()
function kicooya.filePlayer:didUnderrun()
kicooya.filePlayer:setFile(path)
-->

### `function kicooya.filePlayer:play()`

Starts playing the file.

### `function kicooya.filePlayer:stop()`

Stops the currently playing.

### `function kicooya.filePlayer:pause()`

Pauses the currently playing.

### `function kicooya.filePlayer:isPlaying()`

Returns whether the filePlayer is playing.

- return values

  - \[`boolean`\] Whether the filePlayer is playing

### `function kicooya.filePlayer:getLength()`

Returns the length of the song file.

- return values

  - \[`float`\] Length(seconds) of the song file

### `function kicooya.filePlayer:getOffset()`

Returns the current offset of the fileplayer.

- return values

  - \[`float`\] Current offset(Second)

### `function kicooya.filePlayer:setOffset(second)`

Sets the current offset of the fileplayer.

- arguments

  - `second` \[`float`\] Current offset(Second)

### `kicooya.filePlayer.repeatMode`

Repeat mode constants.

- `kicooya.filePlayer.repeatMode.repeatOff` Repeat off
- `kicooya.filePlayer.repeatMode.repeatOn` Repeat on
- `kicooya.filePlayer.repeatMode.repeat1` Repeat one file

### `function kicooya.filePlayer:setRepeatMode(mode)`

Sets repeat mode.

- arguments

  - `mode` \[[`kicooya.filePlayer.repeatMode`](#kicooyafileplayerrepeatmode)\] Repeat mode

### `function kicooya.filePlayer:getRepeatMode()`

Gets repeat mode.

- return values

  - \[[`kicooya.filePlayer.repeatMode`](#kicooyafileplayerrepeatmode)\] Repeat mode

### `function kicooya.filePlayer:getNowPlayingSong()`

Returns the currently playing song.

- return values

  - \[[`kicooya.musicDB.song`](#class-kicooyamusicdbsong)\] Currently playing song

<!--
function kicooya.filePlayer:getNowPlayingVideoFrameImage()
function kicooya.filePlayer:getNowPlayingVideoItem()
function kicooya.filePlayer:pushNowPlayingChangedCallback(callback)
function kicooya.filePlayer:popNowPlayingChangedCallback()
function kicooya.filePlayer:pushOnSetOffsetCallback(callback)
function kicooya.filePlayer:popOnSetOffsetCallback()
-->

## `class kicooya.pattern`

This class is used to get pattern held by Kicooya.

|Property name|Pattern image|
|-|-|
|kicooya.pattern.backslash|![backslash](./images/patterns/backslash.png)|
|kicooya.pattern.bigchecker|![bigchecker](./images/patterns/bigchecker.png)|
|kicooya.pattern.birds|![birds](./images/patterns/birds.png)|
|kicooya.pattern.black|![black](./images/patterns/black.png)|
|kicooya.pattern.boxchecker|![boxchecker](./images/patterns/boxchecker.png)|
|kicooya.pattern.cross|![cross](./images/patterns/cross.png)|
|kicooya.pattern.crosshatch|![crosshatch](./images/patterns/crosshatch.png)|
|kicooya.pattern.dbandcheck|![dbandcheck](./images/patterns/dbandcheck.png)|
|kicooya.pattern.densechecker|![densechecker](./images/patterns/densechecker.png)|
|kicooya.pattern.denseslash|![denseslash](./images/patterns/denseslash.png)|
|kicooya.pattern.double|![double](./images/patterns/double.png)|
|kicooya.pattern.forwardslash|![forwardslash](./images/patterns/forwardslash.png)|
|kicooya.pattern.invertboxchecker|![invertboxchecker](./images/patterns/invertboxchecker.png)|
|kicooya.pattern.longcheckerhor|![longcheckerhor](./images/patterns/longcheckerhor.png)|
|kicooya.pattern.longcheckervert|![longcheckervert](./images/patterns/longcheckervert.png)|
|kicooya.pattern.pinwheel|![pinwheel](./images/patterns/pinwheel.png)|
|kicooya.pattern.sparsechecker|![sparsechecker](./images/patterns/sparsechecker.png)|
|kicooya.pattern.spot|![spot](./images/patterns/spot.png)|
|kicooya.pattern.swave|![swave](./images/patterns/swave.png)|
|kicooya.pattern.swirl|![swirl](./images/patterns/swirl.png)|
|kicooya.pattern.target|![target](./images/patterns/target.png)|
|kicooya.pattern.wave|![wave](./images/patterns/wave.png)|
|kicooya.pattern.weave_a|![weave_a](./images/patterns/weave_a.png)|
|kicooya.pattern.weave_b|![weave_b](./images/patterns/weave_b.png)|
|kicooya.pattern.weave_c|![weave_c](./images/patterns/weave_c.png)|
|kicooya.pattern.weave_d|![weave_d](./images/patterns/weave_d.png)|
|kicooya.pattern.weave_e|![weave_e](./images/patterns/weave_e.png)|
|kicooya.pattern.white|![white](./images/patterns/white.png)|
|kicooya.pattern.wisp|![wisp](./images/patterns/wisp.png)|
|kicooya.pattern.zag|![zag](./images/patterns/zag.png)|
|kicooya.pattern.zig|![zig](./images/patterns/zig.png)|
