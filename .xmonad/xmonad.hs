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
import XMonad.Layout.LayoutModifier

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
import XMonad.Hooks.EwmhDesktops

-- EXTRAS
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- My Applications
myTerminal = "alacritty"
myBrowser = "google-chrome-stable"
myAppLauncher = "rofi -show drun"
myWindowSwitcher = "rofi -show window"
myFileManager = "thunar"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth = 1

myModMask = mod4Mask

myNormalBorderColor  = "#333"
myFocusedBorderColor = "#999"

------------------------------------------------------------------------
-- Startup hook

myStartupHook :: X ()
myStartupHook = do
    spawn "$HOME/.xmonad/autostart"
    setWMName "LG3D"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

myKeys = [

    -- Run Applications
      ("M-S-<Return>", spawn (myTerminal)) 
    , ("M-p", spawn (myAppLauncher))           
    , ("M-w", spawn (myWindowSwitcher))           
    , ("M-e", spawn (myFileManager))       
    , ("M-b", spawn (myBrowser))
    , ("M-S-s", spawn "flameshot gui")
    , ("M-S-x", spawn "clearine")
    , ("M-S-<Esc>", spawn "mate-control-center")
    --, ("M-S-x", spawn "arcolinux-logout")
    , ("M-<F1>", spawn "feh --bg-scale --randomize ~/Pictures/Wallpapers/*") 

    -- Volume Keys
    , ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 10%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 10%-")
    , ("<XF86AudioMute>", spawn "amixer -D pulse sset Master toggle")

    -- Windows Actions
    , ("M-S-c", kill) -- Close focused window
    , ("M-S-a", killAll) -- Close all windows in current workspace
    , ("M-S-t", sinkAll) -- Unfloat all floating windows 

    , ("M-n", refresh) -- Resize viewed windows to the correct size
    , ("M-<Tab>", windows W.focusDown) -- Move focus to the next window
    , ("M-j", windows W.focusDown) -- Move focus to the next window
    , ("M-k", windows W.focusUp) -- Move focus to the previous window
    , ("M-m", windows W.focusMaster) -- Move focus to the master window
    , ("M-<Return>", windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-j", windows W.swapDown) -- Swap the focused window with the next window
    , ("M-S-k", windows W.swapUp) -- Swap the focused window with the previous window
    , ("M-t", withFocused $ windows . W.sink) -- Push window back into tiling

    -- Master Area

    , ("M-h", sendMessage Shrink) -- Shrink the master area    
    , ("M-l", sendMessage Expand) -- Expand the master area    
    , ("M-comma", sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area    
    , ("M-period", sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

    -- Workspaces
 
    , ("M-S-<Up>", shiftToNext >> nextWS) -- Send focused client to next workspace
    , ("M-S-<Down>", shiftToPrev >> prevWS) -- Send focused client to previous workspace
    , ("M-<Up>", nextWS) -- Go to next workspace
    , ("M-<Down>", prevWS) -- Go to previous workspace

    -- Layouts
    , ("M-<Space>", sendMessage NextLayout) -- Switch layouts

    -- XMonad
    , ("M-S-q", io (exitWith ExitSuccess)) -- Quit XMonad
    , ("M-q", spawn "xmonad --recompile; xmonad --restart") -- Restart XMonad
    ]

------------------------------------------------------------------------
-- Layouts:

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

myLayout =  mouseResize $ windowArrange (tiled ||| smartBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   =   smartBorders 
               $ mySpacing 6 
               $ Tall nmaster delta ratio 

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
------------------------------------------------------------------------
-- Workspaces

myWorkspaces = ["sys","web","code","chat","doc","virt","mus","vid","gfx"]

--myShowWNameTheme :: SWNConfig
--myShowWNameTheme = def
  --  { swn_font              = "xft:Ubuntu:bold:size=60"
  --  , swn_fade              = 1.0
  --  , swn_bgcolor           = "#1c1f24"
  --  , swn_color             = "#ffffff"
  --  }

------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll
    [ resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Clearine" --> doFullFloat
    , className =? "Arcologout.py" --> doFullFloat
    , className =? "Evince" --> doFullFloat
    , className =? "Galculator" --> doCenterFloat
    , isDialog --> doCenterFloat
    ]
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return()

------------------------------------------------------------------------
main = do
    --xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad $ ewmh defaults

defaults = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        --layoutHook         = showWName' myShowWNameTheme $ myLayout,
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = handleEventHook def <+> fullscreenEventHook <+> docksEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys
