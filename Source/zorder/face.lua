local pd <const> = playdate
local kcy <const> = kicooya
local gfx <const> = pd.graphics
local cd <const> = kcy.ctrl.commonDrawing



--
class('luaZOrder',{
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
function kcy.face.luaZOrder:_createFqIndexTable(analyzer)
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
function kcy.face.luaZOrder:_updateDecibelTable(analyzer)
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
function kcy.face.luaZOrder:init()
    self._fqIndexTable = nil
    self._dbTable = {}
    
    self._l = 20
    self._t = 30
    self._w = 360
    self._h = 192
end



--[[
    [Memo]
    This function is called only once when kicooya startup.
]]
function kcy.face.luaZOrder:initializeFace(arg)
    return true
end


--[[
    [Memo]
    This function is called when the active state of the playback screen is changed.
]]
function kcy.face.luaZOrder:onActivate(active)
end


--[[
    [Memo]
    This function is called when the playback status changes of a song.
]]
function kcy.face.luaZOrder:onPlayingChanged()
end


--[[
    [Memo]
    This function is called when the currently playing song changes.
]]
function kcy.face.luaZOrder:updateNowPlaying(song)
    self._song = song
end


--[[
    [Memo]
    This function is called when the currently playing song changes, so draw a background.
]]
function kcy.face.luaZOrder:updateBackground()
end


--[[
    [Memo]
    This function is called frame by frame when a drawing, so draw what needs to be moved.
]]
function kcy.face.luaZOrder:drawFace()
end


--[[
    [Memo]
    This function is called when drawing the AudioVisualizer.
    If this function is defined, the process of parsing audio data for rendering is performed.
    If you do not need to draw the AudioVisualizer, do not define this function.
]]


--
function kcy.face.luaZOrder:drawAudioVisualizer(analyzer)
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

    gfx.setPattern(kcy.pattern.double)
    gfx.fillPolygon(table.unpack(pt))

    gfx.setPattern(kcy.pattern.densechecker)
    gfx.drawPolygon(pd.geometry.polygon.new(table.unpack(pt)))
end


--
return kcy.face.luaZOrder()


