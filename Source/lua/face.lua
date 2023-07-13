local pd <const> = playdate
local kcy <const> = kicooya
local gfx <const> = pd.graphics
local cd <const> = kcy.ctrl.commonDrawing



--
class('luaSample',{
    _fqTable =
    {
        25, 31, 40, 50, 63,
        80, 100, 125, 160, 200,
        250, 315, 400, 500, 630,
        800, 1000, 1250, 1600, 2000,
        2500, 3150, 4000, 5000, 6300,
        8000, 10000, 12500, 16000, 20000
    },
}, kcy.face).extends(kcy.face.userFace)


--
function kcy.face.luaSample._drawShadowText(txt, font, rect)
    gfx.setPattern(kcy.pattern.black)
    
    local textW = font:getTextWidth(txt)
    local textT = rect[2]

    gfx.setClipRect(rect[1], rect[2], rect[3], rect[4])
    rect[1] = rect[1] + 2
    rect[2] = rect[2] + 2
    rect[3] = rect[3] - 4
    rect[4] = rect[4] - 4

    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    font:drawText(txt, rect[1] - 2, textT)
    font:drawText(txt, rect[1] - 1, textT)
    font:drawText(txt, rect[1] + 1, textT)
    font:drawText(txt, rect[1] + 2, textT)

    font:drawText(txt, rect[1], textT - 2)
    font:drawText(txt, rect[1], textT - 1)
    font:drawText(txt, rect[1], textT + 1)
    font:drawText(txt, rect[1], textT + 2)

    font:drawText(txt, rect[1] - 1, textT - 1)
    font:drawText(txt, rect[1] + 1, textT - 1)
    font:drawText(txt, rect[1] - 1, textT + 1)
    font:drawText(txt, rect[1] + 1, textT + 1)

    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    font:drawText(txt, rect[1], textT)
    gfx.clearClipRect()
end


--
function kcy.face.luaSample._drawBackgroundImage(l, t, w, h)
    gfx.setPattern(kcy.pattern.pinwheel)
    gfx.fillRect(0, 0, pd.display.getWidth(), pd.display.getHeight())

    gfx.setPattern(kcy.pattern.denseslash)
    gfx.fillRect(l, t, w, h)
end


--
function kcy.face.luaSample._drawText(song, l, t, w)
    if not song then
        return
    end

    local ttlFont = kcy.font:getTitleFont()
    if not ttlFont then
        return
    end

    local dscFont = kcy.font:getDescriptionFont()
    if not dscFont then
        return
    end

    local textMargin = 10
    local textL = l + textMargin
    local textT = t + textMargin
    local textW = w - (textMargin * 2)

    local ttl = song:getTitle()
    if ttl then
        kcy.face.luaSample._drawShadowText(ttl, ttlFont,
        { textL, textT, textW, ttlFont:getHeight() + 4})
        textT += ttlFont:getHeight() + textMargin
    end

    local album = song:getAlbum()
    if album then
        kcy.face.luaSample._drawShadowText(album, dscFont,
        { textL, textT, textW, dscFont:getHeight() + 4})
        textT += dscFont:getHeight() + textMargin
    end

    local ast = song:getArtist()
    if ast then
        kcy.face.luaSample._drawShadowText(ast, dscFont,
        { textL, textT, textW, dscFont:getHeight() + 4})
    end
end


--
function kcy.face.luaSample._drawArtImage(song)
    local img = song:getLargeArtImage()
    if not img then
        return
    end

    local imgW, imgH = img:getSize()
    local rc = {
        (pd.display.getWidth() / 2) - (imgW / 2),
        (pd.display.getHeight() / 2) - (imgH / 2),
        imgW, imgH
    }

    gfx.setPattern(kcy.pattern.white)
    gfx.fillRect(rc[1] - 3, rc[2] - 3, rc[3] + 6, rc[4] + 6)

    gfx.setPattern(kcy.pattern.densechecker)
    gfx.drawRect(rc[1] - 2, rc[2] - 2, rc[3] + 4, rc[4] + 4)

    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    img:draw(rc[1], rc[2])
end


--
function kcy.face.luaSample:_createFqIndexTable(analyzer)
    local cnt = analyzer.getAudioFrequencyDataCount()
    if cnt == 0 then
        return
    end

    self._fqIndexTable = {}
    local dataIndex = 1
    for i = 1, cnt do
        local fq = analyzer.getAudioFrequencyData(i)
        if fq > self._fqTable[dataIndex] then
            self._fqIndexTable[dataIndex] = i
            dataIndex = dataIndex + 1
            if dataIndex > #self._fqTable then
                break
            end
        end
    end
end


--
function kcy.face.luaSample:_updateDecibelTable(analyzer)
    if self._fqIndexTable == nil then
        self:_createFqIndexTable(analyzer)
        if self._fqIndexTable == nil then
            return
        end
    end

    self._dbTable = {}
    for i = 1, #self._fqTable do
        self._dbTable[i] = 0
    end

	local fq, decibelLeft, decibelRight
	for i = 1, #self._fqIndexTable do
		fq, decibelLeft, decibelRight = analyzer.getAudioFrequencyData(self._fqIndexTable[i])
        if fq then
            local db = (decibelLeft + decibelRight) / 2
            if self._dbTable[i] < db then
                self._dbTable[i] = db
            end
        end
    end
end


--
function kcy.face.luaSample:init()
    self._fqIndexTable = nil
    self._dbTable = {}
    
    self._l = 10
    self._t = 10
    self._w = pd.display.getWidth() - 36
    self._h = pd.display.getHeight() - 20
end



--[[
    [Memo]
    This function is called only once when kicooya startup.
]]
function kcy.face.luaSample:initializeFace(arg)
    return true
end


--[[
    [Memo]
    This function is called when the active state of the playback screen is changed.
]]
function kcy.face.luaSample:onActivate(active)
end


--[[
    [Memo]
    This function is called when the playback status changes of a song.
]]
function kcy.face.luaSample:onPlayingChanged()
end


--[[
    [Memo]
    This function is called when the currently playing song changes.
]]
function kcy.face.luaSample:updateNowPlaying(song)
    self._song = song
end


--[[
    [Memo]
    This function is called when the currently playing song changes, so draw a background.
]]
function kcy.face.luaSample:updateBackground()
    self._drawBackgroundImage(self._l, self._t, self._w, self._h)
    self._drawArtImage(self._song)
    self._drawText(self._song, self._l, self._t, self._w)
end


--[[
    [Memo]
    This function is called frame by frame when a drawing, so draw what needs to be moved.
]]
function kcy.face.luaSample:drawFace()
end


--[[
    [Memo]
    This function is called when drawing the AudioVisualizer.
    If this function is defined, the process of parsing audio data for rendering is performed.
    If you do not need to draw the AudioVisualizer, do not define this function.
]]
--
function kcy.face.luaSample:drawAudioVisualizer(analyzer)
    self:_updateDecibelTable(analyzer)

    if not self._fqIndexTable then
        return
    end

    local hmag = 0
    local itemW = self._w / #self._dbTable

    local pt = {self._l, self._t + self._h}
    for i = 1, #self._dbTable do
        hmag = self._dbTable[i] / 60
        if hmag > 1.0 then
            hmag = 1.0
        end
        pt[#pt + 1] = self._l + (i * itemW)
        pt[#pt + 1] = self._t + self._h - (self._h * hmag)
    end

    pt[#pt + 1] = self._l + self._w
    pt[#pt + 1] = self._t + self._h

    gfx.setPattern(kcy.pattern.white)
    gfx.fillPolygon(table.unpack(pt))

    gfx.setPattern(kcy.pattern.densechecker)
    gfx.drawPolygon(pd.geometry.polygon.new(table.unpack(pt)))
end


--
return kcy.face.luaSample()


