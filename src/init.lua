--[[
	A module to work with detecting devices.
	Programmed by break-core.
]]

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local qDevice = {}
local qDeviceExp = {}

local KEY_BUTTON_A = Enum.KeyCode.ButtonA
local SCREEN_SIZE = workspace.CurrentCamera.ViewportSize
local QDEV_EXPERIMENTAL = false

--- Get portrait mode by checking if the screen size's X value is bigger than Y
function qDevice.IsOrientationLandscape(): boolean
	return (SCREEN_SIZE.X > SCREEN_SIZE.Y and UserInputService.TouchEnabled)
end

--- Get portrait mode by checking if the screen size's X value is less than Y
function qDevice.IsOrientationPortrait(): boolean
	return (SCREEN_SIZE.X < SCREEN_SIZE.Y and UserInputService.TouchEnabled)
end

--- Get the user's device orientation
function qDevice.GetDeviceOrientation()
	if qDevice.IsOrientationLandscape() then
		return Enum.ScreenOrientation.LandscapeLeft 
			or Enum.ScreenOrientation.LandscapeRight 
			or Enum.ScreenOrientation.LandscapeSensor
	elseif qDevice.IsOrientationPortrait() then
		return Enum.ScreenOrientation.Portrait
	else
		return
	end
end

--- Get if the user is on a console by just returning TenFootInterface
function qDevice.IsConsole(): boolean
	return GuiService:IsTenFootInterface()
end

--- Get if the player is on Xbox by utilizing TenFootInterface and KeyCode strings
function qDevice.IsXbox(): boolean
	return (UserInputService:GetStringForKeyCode(KEY_BUTTON_A) == "ButtonA" and qDevice.IsConsole())
end

--- Exact implementation to IsXbox, but we look for "ButtonCross" to be returned instead
function qDevice.IsPlayStation(): boolean
	return (UserInputService:GetStringForKeyCode(KEY_BUTTON_A) == "ButtonCross" and qDevice.IsConsole())
end

--- Hack to get mobile device by comparing hard-coded values against screen size.
export type MobileDevice = "Phone" | "Tablet" | "None"

function qDevice.GetMobileDevice(): MobileDevice
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
	return (device == "Phone")
end

--- Get if the user is using a tablet
function qDevice.IsTablet(): boolean
	local device = qDevice.GetMobileDevice()
	return (device == "Tablet")
end

--- Get if the user is using a VR headset
function qDevice.IsVR(): boolean
	return UserInputService.VREnabled
end

--- This checks against every platform to ensure we're using PC
function qDevice.IsPC(): boolean
	return (not (qDevice.IsVR() or qDevice.IsPhone() or qDevice.IsTablet() or qDevice.IsConsole() or qDevice.IsXbox() or qDevice.IsPlayStation()))
end

--- Get if the user is using a controller on PC
function qDeviceExp.IsControllerOnPC(): boolean
	return (qDevice.IsPC() and UserInputService.GamepadEnabled)
end

--- ENABLE THIS TO TURN ON EXPERIMENTAL FEATURES
if QDEV_EXPERIMENTAL then
	qDevice.IsControllerOnPC = qDeviceExp.IsControllerOnPC
end

return qDevice
