import XMonad
import XMonad.Util.EZConfig (mkKeymap, checkKeymap)
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders (smartBorders)
import System.Exit (exitSuccess)
import XMonad.StackSet (focusUp,sink,greedyView,shift)
import XMonad.Layout.IM
import Data.Ratio ((%))

myLayout =
  onWorkspace "games" steamLayout 
  baseLayout
  where
    baseLayout = threeCol ||| tiled ||| Mirror tiled ||| smartBorders Full
    steamLayout = withIM (2%3) (ClassName "steam") Grid
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myKeymap c = 
  -- spawn apps
  [ ("M-w" , spawn "firefox")
  , ("M-<Return>" , spawn $ terminal c)
  -- window management
  , ("M-r" , refresh)
  , ("M-t" , sendMessage NextLayout)
  , ("M-s" , withFocused $ windows . sink)
  , ("M-q" , kill)
  -- window movement
  , ("M-u" , windows focusUp)
  , ("M-h" , windowGo L True)
  , ("M-j" , windowGo D True)
  , ("M-k" , windowGo U True)
  , ("M-l" , windowGo R True)
  , ("M-S-h" , windowSwap L True)
  , ("M-S-j" , windowSwap D True)
  , ("M-S-k" , windowSwap U True)
  , ("M-S-l" , windowSwap R True)
  , ("M-C-S-h" , windowToScreen L False)
  , ("M-C-S-j" , windowToScreen D False)
  , ("M-C-S-k" , windowToScreen U False)
  , ("M-C-S-l" , windowToScreen R False)
  , ("M-`" , windows $ greedyView "1")
  , ("M-1" , windows $ greedyView "2")
  , ("M-2" , windows $ greedyView "games")
  , ("M-S-`" , windows (shift "1") >> windows (greedyView "1"))
  , ("M-S-1" , windows (shift "2") >> windows (greedyView "2"))
  , ("M-S-2" , windows (shift "games") >> windows (greedyView "games"))
  , ("M-C-S-`" , windows $ shift "1")
  , ("M-C-S-1" , windows $ shift "2")
  , ("M-C-S-2" , windows $ shift "games")
  , ("M-i" , prevWS)
  , ("M-o" , nextWS)
  , ("M-S-i" , shiftToPrev >> prevWS)
  , ("M-S-o" , shiftToNext >> nextWS)
  -- quit / restart
  , ("M-S-r" , spawn "xmonad --restart")
  , ("M-S-q" , io exitSuccess)
  ]

mkMyKeymap c = mkKeymap c $ myKeymap c

myManageHook = composeAll
  [ className =? "steam" --> doFloat ]

myWorkspaces = [ "1", "2", "games" ]

myConfig = def
  { modMask = mod4Mask
  , layoutHook = myLayout
  , terminal = "alacritty"
  , workspaces = myWorkspaces
  , keys = mkMyKeymap
  , manageHook = myManageHook
  -- , startupHook = return () >> checkKeymap myConfig $ (myKeymap myConfig)
  , startupHook = do
    spawn "autorandr -c main"
    spawn "feh --bg-scale ~/pictures/wallpapers/copper-cosmos.jpg"
  }


main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ myConfig
