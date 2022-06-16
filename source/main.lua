-- -- -- -- CORELIBS -- -- -- -- 
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/easing"
import "CoreLibs/animator"
import "CoreLibs/graphics"
import "CoreLibs/frameTimer"
import "CoreLibs/math"
import "CoreLibs/object"
import "CoreLibs/animation"
import "CoreLibs/ui"
import "CoreLibs/crank"
import "CoreLibs/utilities/sampler"


-- -- -- -- CONSTANTS -- -- -- -- 
import "lib/_utilities"
local gfx <const> = playdate.graphics

-- -- -- -- GLOBALS -- -- -- -- 


-- -- -- -- CLASSES -- -- -- -- 


-- -- -- -- BACKGROUND -- -- -- -- 
gfx.sprite.setBackgroundDrawingCallback(
	function(x, y, width, height)
		-- background
		gfx.setColor(kBlack)
		gfx.fillRect(0, 0, kDisplayWidth, kDisplayHeight)
	end
)

-- -- -- -- SETUP -- -- -- -- 
-- playdate.display.setRefreshRate(45)
local moonImage
local moonScale = 1
local crankPos
local isScaling = false
local scaleFactor = 0
local increaseScaleBy = 0.01
local decreaseScaleBy = -0.01
local crankGross = 1
local crankChange, crankAccChange
local moonTable


-- createImageTable()
gfx.setLineWidth(5)

local moonTable = gfx.imagetable.new(720)
local imagesLoaded = false

-- playdate.display.setMosaic(1, 1)

--TODO:
-- why the coroutine so slow
-- add some simple stars?
-- ambient music?

-- -- -- -- UPDATE -- -- -- -- 
function playdate.update()
	if not imagesLoaded then
		gfx.sprite.update()
		
		-- Load Images
		for i=1, 720 do
			local progress = i/720
			local path = gfx.image.new('assets/images/moon-test/moon' .. i)
			moonTable:setImage(i, path)
			
			gfx.setColor(kWhite)
			gfx.drawArc(kDisplayWidth/2, kDisplayHeight/2, 105, 0, playdate.math.lerp(0, 360, progress))
			gfx.setColor(kWhite)
			gfx.setDitherPattern(playdate.math.lerp(1, 0.5, progress))
			gfx.fillCircleAtPoint(kDisplayWidth/2, kDisplayHeight/2, 100)
			
			coroutine.yield()
		end
		
		imagesLoaded = true
		
	else
	
		gfx.sprite.update()
		
		crankChange, crankAccChange = playdate.getCrankChange()
		crankGross = crankGross + (crankAccChange * 4)
		
		crankPos = _roundNumber(crankGross, 0)%720
		
		
		if isScaling then
			moonScale += scaleFactor
			
			-- move this into input handler
			if moonScale < 0.25 then
				moonScale = 0.25
			elseif moonScale > 2 then
				moonScale = 2
			end
		end
		
		if crankPos == 0.0 then
			moonImage = moonTable:getImage(1)
			moonImage = moonImage:scaledImage(moonScale)
			moonImage:drawCentered(kDisplayWidth/2, kDisplayHeight/2)
		else
			moonImage = moonTable:getImage(crankPos)
			moonImage = moonImage:scaledImage(moonScale)
			moonImage:drawCentered(kDisplayWidth/2, kDisplayHeight/2)
		end
		
	end
end

-- -- -- -- INPUTS -- -- -- -- 
function playdate.upButtonDown()
	isScaling = true
	scaleFactor = increaseScaleBy
end

function playdate.upButtonUp()
	isScaling = false
end

function playdate.downButtonDown()
	isScaling = true
	scaleFactor = decreaseScaleBy
end

function playdate.downButtonUp()
	isScaling = false
end

function playdate.BButtonDown()
	moonScale = 1
end

	-- -- -- -- DEBUG -- -- -- --
function playdate.keyPressed(key)
	if key == "1" then
	end
end