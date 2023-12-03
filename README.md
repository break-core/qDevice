![qDevice logo](/assets/qDevice.png)
# qDevice
qDevice is a Roblox Luau package designed to detect platforms of most kinds on Roblox with ease and with a simple interface.

# Reminder
qDevice uses a lot of UserInputService logic in it that makes it impossible to use on the server. You can only use qDevice on the client. That is the only warning.

# Documentation:

## Methods

### `qDevice.IsOrientationLandscape(): boolean`
This returns true if the orientation of a mobile device is in landscape mode. This is done by comparing screen size values and checking if the user has touch enabled.

### `qDevice.IsOrientationPortrait(): boolean`
This returns true if the orientation of a mobile device is in portrait mode. This is done by comparing screen size values and checking if the user has touch enabled.

### `qDevice.GetDeviceOrientation(): string`
This is a general function that will return a string based on the mode that it was detected to be in.

### `qDevice.IsXbox(): boolean`
This returns true if the user is found to be on Xbox. This is done by checking the string for a keycode returning "ButtonA", as well as checking for Ten Foot Interface.

### `qDevice.IsPlayStation(): boolean`
This is a similar implementation to `IsXbox()` but by checking if a keycode will return "ButtonCross" as a string, also checking for Ten Foot Interface.

### `qDevice.IsConsole(): boolean`
This returns true or false if the platform is any console, by checking for Ten Foot Interface.

### `qDevice.GetConsoleDevice(): string`
This will return a string that says "Xbox" or "Playstation" depending on the console device being used. "None" is returned if there is no console device in use.

### `qDevice.GetMobileDevice(): string`
This will return a string that says "Phone" or "Tablet" depending on what it finds and for the orientation. This function returns "None" if a mobile device is not being used.

> [!WARNING]
> This function is hacky. Like, sorta hacky. It checks if the X or Y values of the screen size are below 600 depending on orientation.
> Please note that `.IsPhone()` and `.IsTablet()` use `.GetMobileDevice()`, so they have the same limitation of depending on device screen size.

### `qDevice.IsPhone(): boolean`
This function will return true if it finds a phone.

### `qDevice.IsTablet(): boolean`
This function will return true if it finds a tablet.

### `qDevice.IsVR(): boolean`
This returns true if it finds a VR headset active.

### `qDevice.IsPC(): boolean`
This will find if a PC is active by checking against all other devices.

> [!NOTE]
> This function is experimental (meaning that implementing this in production might be a big no-no.) Set QDEV_EXPERIMENTAL to `true` to enable this.
### `qDevice.IsControllerOnPC(): boolean`
This special function will look for if a controller is connected on PC.
