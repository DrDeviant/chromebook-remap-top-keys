# chromebook-remap-top-keys
Remaps the top row media keys on a Chromebook running Linux, to be consistent with Chrome OS.
# Usage
Ensure curl is installed, and run this command to download and run the script:
```
curl -s https://raw.githubusercontent.com/TheSonicMaster/chromebook-remap-top-keys/main/remap.sh | sudo bash
```
Make sure to reboot after running the script for the changes to take effect!
**Note:** Updates might reset the keymaps, if this happens, just run the script again.
# List of remappings, from left to right
- Back
- Forward
- Refresh
- Print Screen
- Super
- Brightness Down
- Brightness Up
- Volume Mute
- Volume Down
- Volume Up
# Restoring original keymaps.
When the script was run, a backup of the stock keymaps were taken. It can be restored with the following command:
```
sudo mv /usr/share/X11/xkb/symbols/pc.bak /usr/share/X11/xkb/symbols/pc
```
Remember to reboot after restoring.
