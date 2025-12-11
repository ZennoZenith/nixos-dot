{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
      pkgs.hyprcursor
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
    ];

    settings = {
      "$terminal" = "ghostty";
      "$fileManager" = "dolphin";
      "$colorpicker" = "hyprpicker | wl-copy";
      "$browser" = "zen";
      "$notes" = "obsidian";
      "$menu" = "tofi-drun -c ~/.config/tofi/configA --drun-launch=true";
      "$clipboard_copy" = "cliphist list | tofi -c ~/.config/tofi/configV | cliphist decode | wl-copy --trim-newline && hyprctl dispatch sendshortcut \"CTRL SHIFT, V,\"";

      #################
      ### ROSE PINE ###
      #################
      # name: Rosé Pine
      # author: jishnurajendran
      # upstream: https://github.com/jishnurajendran/hyprland-rosepine/blob/main/rose-pine.conf
      # All natural pine, faux fur and a bit of soho vibes for the classy minimalist
      "$base" = "0xff191724";
      "$surface" = "0xff1f1d2e";
      "$overlay" = "0xff26233a";
      "$muted" = "0xff6e6a86";
      "$subtle" = "0xff908caa";
      "$text" = "0xffe0def4";
      "$love" = "0xffeb6f92";
      "$gold" = "0xfff6c177";
      "$rose" = "0xffebbcba";
      "$pine" = "0xff31748f";
      "$foam" = "0xff9ccfd8";
      "$iris" = "0xffc4a7e7";
      "$highlightLow" = "0xff21202e";
      "$highlightMed" = "0xff403d52";
      "$highlightHigh" = "0xff524f67";

      ################
      ### MONITORS ###
      ################

      ## See https://wiki.hyprland.org/Configuring/Monitors/
      "monitor" = [
        # ",preferred,auto,auto"
        # "HDMI-A-1, 1920x1080@74.97, auto, auto"
        # "HDMI-A-2, 1920x1080@59.94, auto, auto"
        "HDMI-A-1, 2560x1440@59.95Hz, auto, auto"
        "HDMI-A-2, 1920x1080@74.97, auto, auto"
      ];

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      ## See https://wiki.hyprland.org/Configuring/Environment-variables/
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_MENU_PREFIX,arch-"
        "WLR_NO_HARDWARE_CURSORS,1"

        "GTK_THEME,Dracula"
        "GTK_ICON_THEME,Adwaita"

        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,rose-pine-hyprcursor"
        # "XCURSOR_THEME,Banana"
        # "XCURSOR_THEME,Bibata-Modern-Ice"

        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        # "HYPRCURSOR_THEME,Bibata-Modern-Ice"

        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "LIBVA_DRIVER_NAME,nvidia"

        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"

        # VA-API hardware video acceleration
        # install libva-nvidia-driver, then below
        "NVD_BACKEND,direct"

        # Flickering in Electron / CEF apps
        "ELECTRON_OZONE_PLATFORM_HINT,auto"

        "YOUR_DARK_GTK3_THEME,Adwaita:dark"
        "QT_STYLE_OVERRIDE,Adwaita-Dark"
        "QT_QPA_PLATFORMTHEME,qt6ct" # for Qt apps
      ];

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "systemctl --user start hyprpolkitagent "

        # "wl-paste --type text --watch clipvault store # Stores only text data"
        # "wl-paste --type image --watch clipvault store # Stores only image data"
        # "wl-paste --watch clipvault store --min-entry-length 2 --max-entries 200 --max-entry-age 2d # Store any data, but with additional parameters"
        ## Forward all data, ignoring text that starts with "<meta http-equiv="
        "wl-paste --watch clipvault store --ignore-pattern '^<meta http-equiv='"
        ## Forward specifically raw image data
        "wl-paste --type image --watch clipvault store"

        "~/.config/scripts/waybar/waybar-force-restart.sh"
        "hyprsunset "
        # "hypridle "
        # "hyprpanel"
        # "hyprpaper"
        "swaync ## (or dunst) # notification daemon"
        "swww-daemon # wallpaper"
        "nu ~/.config/nushell/scripts/swww.nu init"
        "wl-paste --type text --watch cliphist store # clipboard"
        "wl-paste --type image --watch cliphist store"
        "kdeconnectd"
        "kdeconnect-indicator"
        "$terminal"
        "walker --gapplication-service"
        "kbuildsycoca6 ## package name kservice"
      ];

      ##############
      ### CURSOR ###
      ##############
      cursor = {
        inactive_timeout = 3;
        no_hardware_cursors = true;
      };

      #####################
      ### LOOK AND FEEL ###
      #####################

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 2;
        gaps_out = 2;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        # "col.active_border" = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
        # "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
        "col.inactive_border" = "$muted";
        "col.active_border" = "$rose $pine $love $iris 90deg";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        # layout = "dwindle";
        layout = "scrolling";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 5;
        # dim_inactive = true;
        # dim_strength = 1.0;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 4;
          passes = 3;
          new_optimizations = true;
          vibrancy = 0.1696;
          ignore_opacity = true;
          noise = 0.0;
        };
      };

      # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all three if you wish to use that.
      # workspace = w[t1], gapsout:0, gapsin:0, border: 0, rounding:0
      # workspace = w[tg1], gapsout:0, gapsin:0, border: 0, rounding:0
      # workspace = f[1], gapsout:0, gapsin:0, border: 0, rounding:0

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      ## See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        # new_status = master;
      };

      ## https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        vrr = 0;
      };

      ##################
      ### ANIMATIONS ###
      ##################

      ## https://wiki.hyprland.org/Configuring/Variables/#animations
      ## Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      animations = {
        enabled = true;

        ## bezier = NAME, X0, Y0, X1, Y1

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        ## animation = NAME, ONOFF, SPEED, CURVE [,STYLE]
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 1, wind"
        ];
      };

      #############
      ### INPUT ###
      #############

      ## https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        # kb_variant =
        # kb_model =
        # kb_rules =

        ## https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
        # Remap Caps-Lock to Ctrl
        # kb_options = ctrl:nocaps
        # Swap Caps-Lock and Escape
        # kb_options = caps:swapescape
        # Make Caps Lock an additional ESC
        kb_options = "caps:escape";

        follow_mouse = 1;
        numlock_by_default = true;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
        };
      };

      ## Example per-device config
      ## See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      ###################
      ### KEYBINDINGS ###
      ###################

      ## See https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

      ## Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind =
        [
          "$mainMod, T, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, exec, $clipboard_copy"
          # "$mainMod, space, exec, $menu"
          "$mainMod, R, exec, $menu"
          "$mainMod SHIFT CTRL, M, exit"
          # "$mainMod SHIFT CTRL, M, exec, uwsm stop"

          # "$mainMod, P, pseudo, # dwindle"
          # "$mainMod, S, togglesplit, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
          "$mainMod SHIFT, left, swapwindow, l"
          "$mainMod SHIFT, right, swapwindow, r"
          "$mainMod SHIFT, up, swapwindow, u"
          "$mainMod SHIFT, down, swapwindow, d"
        ]
        # ++ (
        #   # workspaces
        #   # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        #   builtins.concatLists (builtins.genList (
        #       i: let
        #         ws = i + 1;
        #       in [
        #         "$mod, code:1${toString i}, workspace, ${toString ws}"
        #         "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        #       ]
        #     )
        #     9)
        # )
        ++ [
          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          ## Example special workspace (scratchpad)
          # "$mainMod, S, togglespecialworkspace, magic"
          # "$mainMod SHIFT, S, movetoworkspace, special:magic"

          ## Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          ## CUSTOM KEYBINDINGS
          "$mainMod, F1, exec, ~/.config/scripts/utils/gamemode_hypr.sh"
          "ALT SHIFT, Return, exec, hyprctl dispatch fullscreen 0"
          "$mainMod SHIFT, B, exec, ~/.config/scripts/waybar/waybar-force-restart.sh"
          "$mainMod, Escape, exec, ~/.config/scripts/waybar/waybar-force-restart.sh"
          "$mainMod, B, exec, $browser"
          "$mainMod SHIFT, O, exec, $notes"
          "$mainMod SHIFT, C, exec, $colorpicker"
          "$mainMod SHIFT, L, exec, hyprlock"
          "$mainMod, W, togglefloating,"
          "$mainMod, F2, exec, jome -d | wl-copy #Emojipicker + clipboard copy"
          "$mainMod, Q, exec, wlogout -s"
          "$mainMod CTRL, V, exec, nu ~/.config/nushell/scripts/utils/change_sound_output.nu"
          "$mainMod, U, exec, nu ~/dotfiles/.config/nushell/scripts/utils/swww.nu"
          "$mainMod, O, exec, nu ~/dotfiles/.config/nushell/scripts/utils/swww.nu next"
          "$mainMod, I, exec, nu ~/dotfiles/.config/nushell/scripts/utils/swww.nu prev"
          "$mainMod SHIFT, M, exec, nu ~/dotfiles/.config/nushell/scripts/utils/toggle-touchpad-hyprland.nu"
          "$mainMod SHIFT, K, exec, nu ~/dotfiles/.config/nushell/scripts/utils/toggle-mouse-hyprland.nu"

          # Screenshot using hyprshot
          # ", PRINT, exec, hyprshot -m window"
          # "SHIFT, PRINT, exec, hyprshot -m region"

          ## Screenshot using grimblast
          ## add --cursor flag to include cursor also, --freeze flag to freeze before selection
          ", Print, exec, grimblast --notify copysave active" ## current Active window only + clipboard copy
          "$mainMod, Print, exec, grimblast --notify copysave screen" ## Entire screen + clipboard copy
          "$mainMod SHIFT, Print, exec, grimblast --notify copysave area" ## Select area to take screenshot

          ## to switch between windows in a floating workspace
          "$mainMod, Tab, cyclenext," # change focus to another window
          "$mainMod, Tab, bringactivetotop," # bring it to the top
          "$mainMod, g, hyprexpo:expo, toggle"

          "ALT, Tab, cyclenext," # change focus to another window
          "ALT, Tab, bringactivetotop," # bring it to the top
        ];

      bindm = [
        ## Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ## Volume lower with custom value
        ## ",XF86AudioLowerVolume, exec, swayosd-client"
        ## --output-volume -15 ## Volume lower with custom value
        ## --max-value 120  ## Volume with max value
        ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"

        ## custom value `swayosd-client --brightness -10`
        ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

        ## rmpc control
        # ",XF86AudioPause, exec, rmpc togglepause"
        # ",XF86AudioPlay, exec, rmpc togglepause"
        # ",XF86AudioPrev, exec, rmpc prev"
        # ",XF86AudioNext, exec, rmpc next"
        # ",XF86AudioStop, exec, rmpc stop"
        # ",XF86AudioMute, exec, rmpc volume 0 # unmute not working so keep commented"
      ];

      bindl = [
        ", XF86AudioPlay, exec, swayosd-client --playerctl play-pause"
        ", XF86AudioPause, exec, swayosd-client --playerctl play-pause"
        ", XF86AudioNext, exec, swayosd-client --playerctl next"
        ", XF86AudioPrev, exec, swayosd-client --playerctl prev"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      ## See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      ## See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      ## Ignore maximize requests from apps. You'll probably like this.
      windowrule = [
        "suppress_event maximize, match:class .*"

        ## Fix some dragging issues with XWayland
        ## windowrule = match:focus yes match:class ^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

        ########## CUSTOM ##########
        "opacity 0.90 0.90, match:class ^(Thorium-browser)$"
        "opacity 0.80 0.80, match:class ^(Code)$"
        "opacity 0.80 0.80, match:class ^(Arduino IDE)$"
        "opacity 0.80 0.80, match:class ^(dev.warp.Warp)$"
        "opacity 0.80 0.80, match:class ^(obsidian)$"
        "opacity 0.80 0.80, match:class ^(code-url-handler)$"
        "opacity 0.80 0.80, match:class ^(code-insiders-url-handler)$"
        "opacity 0.80 0.80, match:class ^(kitty)$"
        "opacity 0.80 0.80, match:class ^(org.gnome.Nautilus)$"
        "opacity 0.80 0.80, match:class ^(org.kde.ark)$"
        "opacity 0.80 0.80, match:class ^(nwg-look)$"
        "opacity 0.80 0.80, match:class ^(qt5ct)$"
        "opacity 0.80 0.80, match:class ^(qt6ct)$"
        "opacity 0.80 0.80, match:class ^(kvantummanager)$"
        "opacity 0.80 0.70, match:class ^(pavucontrol)$"
        "opacity 0.80 0.70, match:class ^(blueman-manager)$"
        "opacity 0.80 0.70, match:class ^(nm-applet)$"
        "opacity 0.70 0.70, match:class ^(Spotify)$"
        "opacity 0.70 0.70, match:initial_title ^(Spotify Free)$"
        "opacity 0.80 0.70, match:class ^(nm-connection-editor)$"
        "opacity 0.80 0.70, match:class ^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 0.80 0.70, match:class ^(polkit-gnome-authentication-agent-1)$"
        "opacity 0.80 0.70, match:class ^(org.freedesktop.impl.portal.desktop.gtk)$"
        "opacity 0.80 0.70, match:class ^(org.freedesktop.impl.portal.desktop.hyprland)$"

        "match:float yes match:class ^(kvantummanager)$"
        "match:float yes match:class ^(qt5ct)$"
        "match:float yes match:class ^(qt6ct)$"
        "match:float yes match:class ^(nwg-look)$"
        "match:float yes match:class ^(org.kde.ark)$"
        "match:float yes match:class ^(pavucontrol)$"
        "match:float yes match:class ^(blueman-manager)$"
        "match:float yes match:class ^(nm-applet)$"
        "match:float yes match:class ^(nm-connection-editor)$"
        "match:float yes match:class ^(org.kde.polkit-kde-authentication-agent-1)$"
        "match:float yes match:class ^(jome)$"
      ];

      plugin = {
        dynamic-cursors = {
          # enables the plugin
          enabled = true;

          # sets the cursor behaviour, supports these values:
          # tilt    - tilt the cursor based on x-velocity
          # rotate  - rotate the cursor based on movement direction
          # stretch - stretch the cursor shape based on direction and velocity
          # none    - do not change the cursors behaviour
          mode = "tilt";

          # minimum angle difference in degrees after which the shape is changed
          # smaller values are smoother, but more expensive for hw cursors
          threshold = 4;

          # for mode = rotate
          rotate = {
            # length in px of the simulated stick used to rotate the cursor
            # most realistic if this is your actual cursor size
            length = 20;

            # clockwise offset applied to the angle in degrees
            # this will apply to ALL shapes
            offset = 0.0;
          };

          # for mode = tilt
          tilt = {
            # controls how powerful the tilt is, the lower, the more power
            # this value controls at which speed (px/s) the full tilt is reached
            # the full tilt being 60° in both directions
            limit = 3000;

            # relationship between speed and tilt, supports these values:
            # linear             - a linear function is used
            # quadratic          - a quadratic function is used (most realistic to actual air drag)
            # negative_quadratic - negative version of the quadratic one, feels more aggressive
            # see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
            function = "negative_quadratic";

            # time window (ms) over which the speed is calculated
            # higher values will make slow motions smoother but more delayed
            window = 100;
          };
        };

        # use hyprcursor to get a higher resolution texture when the cursor is magnified
        # see the `hyprcursor` section below
        hyprcursor = {
          # use nearest-neighbour (pixelated) scaling when magnifing beyond texture size
          # this will also have effect without hyprcursor support being enabled
          # 0 / false - never use pixelated scaling
          # 1 / true  - use pixelated when no highres image
          # 2         - always use pixleated scaling
          nearest = true;

          # enable dedicated hyprcursor support
          enabled = true;

          # resolution in pixels to load the magnified shapes at
          # be warned that loading a very high-resolution image will take a long time and might impact memory consumption
          # -1 means we use [normal cursor size] * [shake:base option]
          resolution = -1;

          # shape to use when clientside cursors are being magnified
          # see the shape-name property of shape rules for possible names
          # specifying clientside will use the actual shape, but will be pixelated
          fallback = "clientside";
        };

        hyprexpo = {
          columns = 3;
          gap_size = 5;
          skip_empty = true;
          bg_col = "rgb(111111)";
          workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

          gesture_distance = 300; # how far is the "max" for the gesture
        };

        hyprscrolling = {
          column_width = 0.7;
          fullscreen_on_one_column = true;
          focus_fit_method = 1;
        };
      };
    };

    extraConfig = ''
      ### SUBMAPS
      ## will switch to a submap called resize
      bind = $mainMod SHIFT, N, submap, resize

      ## will start a submap called "resize"
      submap = resize

      ## sets repeatable binds for resizing the active window
      binde = , L, resizeactive, 30 0
      binde = , H, resizeactive, -30 0
      binde = , J, resizeactive, 0 30
      binde = , K, resizeactive, 0 -30

      ## use reset to go back to the global submap
      bind = , escape, submap, reset

      ## will reset the submap, which will return to the global submap
      submap = reset

      ## keybinds further downwill be global again...

      ## will switch to a submap called move
      bind = $mainMod SHIFT, H, submap, move

      ## will start a submap called "move"
      submap = move

      ## sets repeatable binds for moving the active window
      binde = , L, swapwindow, r
      binde = , H, swapwindow, l
      binde = , J, swapwindow, d
      binde = , K, swapwindow, u

      ## use reset to go back to the global submap
      bind = , escape, submap, reset

      ## will reset the submap, which will return to the global submap
      submap = reset
    '';
  };
}
