-----------------------------------------------------------------------
-- IMPORTS

import XMonad
import Data.Monoid
import System.Exit

-- LAYOUT
import XMonad.Layout.WindowArranger
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Layout.Fullscreen

-- UTILS
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WindowProperties
import XMonad.Util.EZConfig (additionalKeysP)

-- ACTIONS
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll
import XMonad.Actions.CycleWS

-- HOOKS
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers

-- EXTRAS
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Preferred applications
myTerminal = "alacritty"
myBrowser = "google-chrome-stable"
myLauncher = "rofi -show drun"
myFileManager = "Thunar"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 1

myModMask       = mod4Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor  = "#333"
myFocusedBorderColor = "#999"

------------------------------------------------------------------------
-- Startup hook

myStartupHook :: X ()
myStartupHook = do
    spawn "$HOME/.xmonad/autostart.sh"
    setWMName "LG3D"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys = [

    -- Run Applications
      ("M-S-<Return>", spawn (myTerminal)) 
    , ("M-p", spawn (myLauncher))           
    , ("M-f", spawn (myFileManager))       
    , ("M-b", spawn (myBrowser))
    , ("M-S-s", spawn "flameshot gui") -- Screenshot Tool
    , ("M-S-x", spawn "arcolinux-logout") -- Arcolinux Betterlockscreen

    -- Volume Keys
    , ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 10%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 10%-")
    , ("<XF86AudioMute>", spawn "amixer -D pulse sset Master toggle")

    -- Windows Actions
    , ("M-S-c", kill) -- Close focused window
    , ("M-S-a", killAll) -- Close all windows in current workspace

    -- Rotate through the available layout algorithms
    , ("M-<Space>", sendMessage NextLayout)

    -- Resize viewed windows to the correct size
    , ("M-n", refresh)

    -- Move focus to the next window
    , ("M-<Tab>", windows W.focusDown)

    -- Move focus to the next window
    , ("M-j", windows W.focusDown)

    -- Move focus to the previous window
    , ("M-k", windows W.focusUp  )

    -- Move focus to the master window
    , ("M-m", windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ("M-<Return>", windows W.swapMaster)

    -- Swap the focused window with the next window
    , ("M-S-j", windows W.swapDown)

    -- Swap the focused window with the previous window
    , ("M-S-k", windows W.swapUp)

    -- Shrink the master area
    , ("M-h", sendMessage Shrink)

    -- Expand the master area
    , ("M-l", sendMessage Expand)

    -- Push window back into tiling
    , ("M-t", withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ("M-comma", sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ("M-period", sendMessage (IncMasterN (-1)))

    -- Send focused client to next workspace
    , ("M-S-<Up>", shiftToNext >> nextWS)

    -- Send focused client to previous workspace
    , ("M-S-<Down>", shiftToPrev >> prevWS)

    -- Go to next workspace
    , ("M-<Up>", nextWS)

    -- Go to previous workspace
    , ("M-<Down>", prevWS)

    -- Quit xmonad
    , ("M-S-q", io (exitWith ExitSuccess))

    -- Restart xmonad
    , ("M-q", spawn "xmonad --recompile; killall xmobar; xmonad --restart")

    ]
------------------------------------------------------------------------
-- Layouts:

myLayout =  mouseResize $ windowArrange (tiled ||| smartBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = avoidStruts $ smartBorders $ smartSpacing 4 $ Tall nmaster delta ratio 

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }
------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Alacritty" --> doCenterFloat
    , isDialog --> doCenterFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad $ fullscreenSupport $ docks defaults

defaults = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = showWName' myShowWNameTheme $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys
