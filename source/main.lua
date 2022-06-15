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
local moonTable = gfx.imagetable.new('assets/images/moon/moon')
local moonImage = moonTable:getImage(1)
local moonScale = 1
local crankPos
local isScaling = false
local scaleFactor = 0
local increaseScaleBy = 0.01
local decreaseScaleBy = -0.01

-- -- -- -- UPDATE -- -- -- -- 
function playdate.update()
	gfx.sprite.update()
	
	crankPos = _roundNumber(playdate.getCrankPosition() * 2, 0)
	
	
	if isScaling then
		moonScale += scaleFactor
		
		if moonScale < 0.05 then
			moonScale = 0.05
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

function scaleMoon()
end

	-- -- -- -- DEBUG -- -- -- --
function playdate.keyPressed(key)
	if key == "1" then
	end
end