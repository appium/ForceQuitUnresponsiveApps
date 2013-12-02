#### Force Quit Unresponsive Instruments

The code for this is from [rentzsch/ForceQuitUnresponsiveApps](https://github.com/rentzsch/ForceQuitUnresponsiveApps).

Fixes appium issue [#1306](https://github.com/appium/appium/issues/1306) by ending Instruments if it freezes.

- `ForceQuitUnresponsiveApps` contains the app that monitors for unresponsive events and ends the process.
- `freeze2` contains two test applications. `freeze2` will become unresponsive and will not be ended because it's not instruments. `instruments` is a renamed `freeze2` and this will be ended because of the file name.
