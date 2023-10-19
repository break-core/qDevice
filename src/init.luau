--[[
	A module to work with detecting devices in Roblox.
	Programmed by break-core.
]]

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local qDevice = {}

local KEY_BUTTON_A = Enum.KeyCode.ButtonA
local SCREEN_SIZE = workspace.CurrentCamera.ViewportSize

--- Get portrait mode by checking if the screen size's X value is bigger than Y
function qDevice.IsOrientationLandscape(): boolean
	if UserInputService.TouchEnabled then
		if SCREEN_SIZE.X > SCREEN_SIZE.Y and UserInputService.TouchEnabled then
			return true
		end
	end
end

--- Get portrait mode by checking if the screen size's X value is less than Y
function qDevice.IsOrientationPortrait(): boolean
	if UserInputService.TouchEnabled then
		if SCREEN_SIZE.X < SCREEN_SIZE.Y and UserInputService.TouchEnabled then
			return true
		end
	end
	return false
end

--- Get the user's device orientation
function qDevice.GetDeviceOrientation(): string
	if qDevice.isOrientationLandscape() then
		return "Landscape"
	elseif qDevice.IsOrientationPortrait() then
		return "Portrait"
	else
		return "None"
	end
end

--- Get if the player is on Xbox by utilizing TenFootInterface and KeyCode strings
function qDevice.IsXbox(): boolean
	if UserInputService:GetStringForKeyCode(KEY_BUTTON_A) == "ButtonA" and GuiService:IsTenFootInterface() then
		return true
	else
		return false
	end
end

--- Exact implementation to IsXbox, but we look for "ButtonCross" to be returned instead
function qDevice.IsPlayStation(): boolean
	if UserInputService:GetStringForKeyCode(KEY_BUTTON_A) == "ButtonCross" and GuiService:IsTenFootInterface() then
		return true
	else
		return false
	end
end

--- Get if the user is on a console by just returning TenFootInterface
function qDevice.IsConsole(): boolean
	if GuiService:IsTenFootInterface() then
		return true
	else
		return false
	end
end

--- Hack to get mobile device by comparing hard-coded values against screen size.
function qDevice.GetMobileDevice(): string
	if qDevice.IsOrientationPortrait() then
		if SCREEN_SIZE.X < 600 then
			return "Phone"
		end
		return "Tablet"
	elseif qDevice.IsOrientationLandscape() then
		if SCREEN_SIZE.Y < 600 then
			return "Phone"
		end
		return "Tablet"
	else
		return "None"
	end
end

--- Get if the person is using a phone
function qDevice.IsPhone(): boolean
	local device = qDevice.GetMobileDevice()
	if device == "Phone" then
		return true
	else
		return false
	end
end

--- Get if the user is using a tablet
function qDevice.IsTablet(): boolean
	local device = qDevice.GetMobileDevice()
	if device == "Tablet" then
		return true
	else
		return false
	end
end

--- Get if the user is using a VR headset
function qDevice.IsVR(): boolean
	if UserInputService.VREnabled then
		return true
	else
		return false
	end
end

--- This checks against every platform to ensure we're using PC
function qDevice.IsPC(): boolean
	if not qDevice.IsVR() or qDevice.IsPhone() or qDevice.IsTablet() 
	or qDevice.IsConsole() or qDevice.IsXbox() or qDevice.IsPlayStation() then
		return true
	else
		return false
	end
end

--- Get if the user is using a controller on PC
function qDevice.IsControllerOnPC()
	if qDevice.IsPC() and UserInputService.GamepadEnabled then
		return true
	else
		return false
	end
end

return qDevice
