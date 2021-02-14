#!/bin/bash
#
# Remaps top row media keys on a Chromebook to match Chrome OS.
# Copyright (C) The Sonic Master 2021.
#
# Exit on error.
set -e
# Ensure we are root.
if [ $EUID -ne 0 ]; then
  echo "Error: Must be run as root. Exiting..." >&2
  exit 1
fi
# Print bold/green text.
printbg() {
  echo -e "\n\e[1m\e[32m$1\e[0m\n"
}
# Ensure we are running on a Chromebook.
if [ "$(dmidecode -s system-manufacturer)" != "GOOGLE" ]; then
  echo "Error: Not running on a Chromebook. Cannot continue." >&2
  exit 1
fi
# Perform operations.
printbg "==> Remapping top row media keys..."
# Backup old keymaps.
cp -n /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.bak
# Write new keymaps.
cat > /usr/share/X11/xkb/symbols/pc << END
default  partial alphanumeric_keys modifier_keys
xkb_symbols "pc105" {

    key <ESC>  {	[ Escape		]	};

    // The extra key on many European keyboards:
    key <LSGT> {	[ less, greater, bar, brokenbar ] };

    // The following keys are common to all layouts.
    key <BKSL> {	[ backslash,	bar	]	};
    key <SPCE> {	[ 	 space		]	};

    include "srvr_ctrl(fkey2vt)"
    include "pc(editing)"
    include "keypad(x11)"

    key <BKSP> {	[ BackSpace, Delete	]	};

    key  <TAB> {	[ Tab,	ISO_Left_Tab	]	};
    key <RTRN> {	[ Return		]	};

    key <CAPS> {	[ Caps_Lock		]	};
    key <NMLK> {	[ Num_Lock 		]	};

    key <LFSH> {	[ Shift_L		]	};
    key <LCTL> {	[ Control_L		]	};
    key <LWIN> {	[ Super_L		]	};

    key <RTSH> {	[ Shift_R		]	};
    key <RCTL> {	[ Control_R		]	};
    key <RWIN> {	[ Super_R		]	};
    key <MENU> {	[ Menu			]	};

    // Beginning of modifier mappings.
    modifier_map Shift  { Shift_L, Shift_R };
    modifier_map Lock   { Caps_Lock };
    modifier_map Control{ Control_L, Control_R };
    modifier_map Mod2   { Num_Lock };
    modifier_map Mod4   { Super_L, Super_R };

    // Fake keys for virtual<->real modifiers mapping:
    key <LVL3> {	[ ISO_Level3_Shift	]	};
    key <MDSW> {	[ Mode_switch 		]	};
    modifier_map Mod5   { <LVL3>, <MDSW> };

    key <ALT>  {	[ NoSymbol, Alt_L	]	};
    include "altwin(meta_alt)"

    key <META> {	[ NoSymbol, Meta_L	]	};
    modifier_map Mod1   { <META> };

    key <SUPR> {	[ NoSymbol, Super_L	]	};
    modifier_map Mod4   { <SUPR> };

    key <HYPR> {	[ NoSymbol, Hyper_L	]	};
    modifier_map Mod4   { <HYPR> };
    // End of modifier mappings.

    key <OUTP> { [ XF86Display ] };
    key <KITG> { [ XF86KbdLightOnOff ] };
    key <KIDN> { [ XF86KbdBrightnessDown ] };
    key <KIUP> { [ XF86KbdBrightnessUp ] };

};

hidden partial alphanumeric_keys
xkb_symbols "editing" {
    key <PRSC> {
	type= "PC_ALT_LEVEL2",
	symbols[Group1]= [ Print, Sys_Req ]
    };
    key <SCLK> {	[  Scroll_Lock		]	};
    key <PAUS> {
	type= "PC_CONTROL_LEVEL2",
	symbols[Group1]= [ Pause, Break ]
    };
    key  <INS> {	[  Insert		]	};
    key <HOME> {	[  Home			]	};
    key <PGUP> {	[  Prior		]	};
    key <DELE> {	[  Delete		]	};
    key  <END> {	[  End			]	};
    key <PGDN> {	[  Next			]	};

    key <FK01> { 	[XF86Back, NoSymbol, NoSymbol, NoSymbol, F1] 			};
    key <FK02> { 	[XF86Forward, NoSymbol, NoSymbol, NoSymbol, F2] 		};
    key <FK03> { 	[XF86Refresh, NoSymbol, NoSymbol, NoSymbol, F3] 		};
    key <FK04> { 	[Print, NoSymbol, NoSymbol, NoSymbol, F4] 			};
    key <FK05> { 	[Super_L, NoSymbol, NoSymbol, NoSymbol, F5] 			};
    key <FK06> { 	[XF86MonBrightnessDown, NoSymbol, NoSymbol, NoSymbol, F6] 	};
    key <FK07> { 	[XF86MonBrightnessUp, NoSymbol, NoSymbol, NoSymbol, F7] 	};
    key <FK08> { 	[XF86AudioMute, NoSymbol, NoSymbol, NoSymbol, F8] 		};
    key <FK09> { 	[XF86AudioLowerVolume, NoSymbol, NoSymbol, NoSymbol, F9] 	};
    key <FK10> { 	[XF86AudioRaiseVolume, NoSymbol, NoSymbol, NoSymbol, F10] 	};
    key <LWIN> { 	[Caps_Lock] };

    key <UP>   {	[  Up, Page_Up			]	};
    key <LEFT> {	[  Left, Home			]	};
    key <DOWN> {	[  Down, Page_Down		]	};
    key <RGHT> {	[  Right, End		        ]	};

};
END
# Clean up cache.
rm -rf /var/lib/xkb/*
printbg "==> All done! Now reboot your system."
