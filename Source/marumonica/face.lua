local pd <const> = playdate
local kcy <const> = kicooya
local gfx <const> = pd.graphics



--
class('maruMonica',{
    _fqTable =
    {
        100, 150, 200, 250, 300, 400, 600, 800, 1000, 1250, 1600, 2000
    },
}, kcy.face).extends(kcy.face.userFace)


--
function kcy.face.maruMonica:_createFqIndexTable(analyzer)
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
function kcy.face.maruMonica:_updateDecibelTable(analyzer)
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
local ITEM_Y_COUNT = 6
local ITEM_MARGIN = 1

function kcy.face.maruMonica:_createBoxes()
    if not self._boxes
       and self._dbTable
       and #self._dbTable ~= 0 then
        local itemW = self._w // #self._dbTable
        local itemH = self._h // ITEM_Y_COUNT

        self._boxes = {}
        self._bg = gfx.image.new(self._w, self._h, gfx.kColorWhite)
        gfx.pushContext(self._bg)
        for x = 1, #self._dbTable do
            if not self._boxes[x] then
                self._boxes[x] = {}
            end
            for y = 1, ITEM_Y_COUNT do
                self._boxes[x][y] = pd.geometry.rect.new(
                    ITEM_MARGIN + ((x - ITEM_MARGIN) * itemW),
                    self._h - (y * itemH) + ITEM_MARGIN,
                    itemW - (ITEM_MARGIN * 2), itemH - (ITEM_MARGIN * 2))
                gfx.setPattern(kcy.pattern.black)
                gfx.drawRect(self._boxes[x][y])
            end
        end
        gfx.popContext()

        self._fg = gfx.image.new(itemW, self._h, gfx.kColorWhite)
        gfx.pushContext(self._fg)
        for y = 1, ITEM_Y_COUNT do
            gfx.setPattern(kcy.pattern.black)
            if y == 1 or y == 2 then
                gfx.setPattern(kcy.pattern.densechecker)
            else
                gfx.setPattern(kcy.pattern.dbandcheck)
            end
            local rc = pd.geometry.rect.new(
                ITEM_MARGIN,
                self._h - (y * itemH) + ITEM_MARGIN,
                itemW - (ITEM_MARGIN * 2), itemH - (ITEM_MARGIN * 2))
            gfx.fillRect(rc)
        end
        gfx.popContext()
    end
end


--
function kcy.face.maruMonica:init()
    self._fqIndexTable = nil
    self._dbTable = {}
    
    self._l = 200
    self._t = 131
    self._w = 156
    self._h = 64

    self._boxes = nil
    self._bg = nil
    self._fg = nil
end



--[[
    [Memo]
    This function is called only once when kicooya startup.
]]
function kcy.face.maruMonica:initializeFace(arg)
    return true
end


--[[
    [Memo]
    This function is called when the active state of the playback screen is changed.
]]
function kcy.face.maruMonica:onActivate(active)
end


--[[
    [Memo]
    This function is called when the playback status changes of a song.
]]
function kcy.face.maruMonica:onPlayingChanged()
end


--[[
    [Memo]
    This function is called when the currently playing song changes.
]]
function kcy.face.maruMonica:updateNowPlaying(song)
end


--[[
    [Memo]
    This function is called when the currently playing song changes, so draw a background.
]]
function kcy.face.maruMonica:updateBackground()
end


--[[
    [Memo]
    This function is called frame by frame when a drawing, so draw what needs to be moved.
]]
function kcy.face.maruMonica:drawFace()
end


--[[
    [Memo]
    This function is called when drawing the AudioVisualizer.
    If this function is defined, the process of parsing audio data for rendering is performed.
    If you do not need to draw the AudioVisualizer, do not define this function.
]]


function kcy.face.maruMonica:drawAudioVisualizer(analyzer)
    self:_updateDecibelTable(analyzer)
    self:_createBoxes()

    if not self._fqIndexTable then
        return
    end

    gfx.setImageDrawMode(gfx.kDrawModeCopy)

    self._bg:draw(self._l, self._t)

    local hmag = 0
    local topYindex = 1
    local type = 0
    for x = 1, #self._boxes do
        hmag = self._dbTable[x] / 40
        if hmag > 1.0 then
            hmag = 1.0
        end
        
        local rcHmag = self._boxes[x][math.floor(ITEM_Y_COUNT * hmag)]
        if rcHmag then
            local rcBottom = self._boxes[x][1]
            self._fg:draw(
                self._l + rcHmag.l, 
                self._t + rcHmag.t,
                gfx.kImageUnflipped,
                pd.geometry.rect.new(0, rcHmag.t, rcHmag.w, (rcBottom.t + rcBottom.h) - rcHmag.t))
        end
    end
end


--
return kcy.face.maruMonica()


