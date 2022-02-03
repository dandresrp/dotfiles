-----------------------------------------------------------------------
-- IMPORTS

import XMonad
import Data.Monoid
import Data.Maybe
import System.Exit
import System.IO

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
import XMonad.Util.WorkspaceCompare

-- ACTIONS
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll
import XMonad.Actions.CycleWS

-- HOOKS
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

-- EXTRAS
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Colors.DoomOne

-- My Applications
myTerminal = "alacritty -e fish"
myBrowser = "google-chrome-stable"
myAppLauncher = "rofi -show drun"
myWindowSwitcher = "rofi -show window"
myFileManager = "pcmanfm"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth = 1

myModMask = mod4Mask

myNormalBorderColor  = "#333"
myFocusedBorderColor = "#999"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Startup hook

myStartupHook :: X ()
myStartupHook = do
    spawn "$HOME/.xmonad/autostart.sh"
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
    , ("M-q", spawn "xmonad --recompile; killall xmobar; xmonad --restart") -- Restart XMonad
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

myLayout =  mouseResize $ windowArrange $ avoidStruts (tiled ||| smartBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   =   smartBorders 
               $ mySpacing 4 
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
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

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
    [ className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , className =? "Clearine" --> doFullFloat
    , className =? "Arcologout.py" --> doFullFloat
    , className =? "Evince" --> doFullFloat
    , className =? "Galculator" --> doCenterFloat
    , className =? "Gpick" --> doCenterFloat
    , className =? "Google-chrome" --> doShift  ( myWorkspaces !! 1 )
    , className =? "Code" --> doShift  ( myWorkspaces !! 2 )
    , className =? "Spotify" --> doShift  ( myWorkspaces !! 6 )
    , className =? "discord" --> doShift  ( myWorkspaces !! 3 )
    , className =? "Virt-manager" --> doShift  ( myWorkspaces !! 5 )
    , isDialog --> doCenterFloat
    ]
------------------------------------------------------------------------

main :: IO ()
main = do
    xmproc <- spawnPipe ("xmobar ~/.xmonad/xmobarrc")
    xmonad $ ewmh def 
      {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = handleEventHook def <+> fullscreenEventHook <+> docksEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP
                           {
                             ppOutput = hPutStrLn xmproc
                           , ppCurrent = xmobarColor color06 "" . wrap
                                         ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
                           , ppVisible = xmobarColor color06 "" . clickable
                           , ppHidden = xmobarColor color05 "" . wrap
                                       ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
                           , ppHiddenNoWindows = xmobarColor color05 ""  . clickable
                           , ppTitle = const ""
                           , ppLayout = const ""
                           , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                           , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                           --, ppExtras  = [windowCount]
                           , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]

                           },
        startupHook        = myStartupHook
      } `additionalKeysP` myKeys
