{...}: {
  # Enable the uinput module
  boot.kernelModules = ["uinput"];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = {};

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          "/dev/input/by-path/pci-0000:00:14.0-usb-0:2:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:00:14.0-usb-0:6:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:2:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:6:1.0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          ;; https://github.com/dreamsofcode-io/home-row-mods/tree/main
          ;; defsrc is still necessary
          ;; key codes: https://github.com/jtroo/kanata/blob/main/parser/src/keys/mod.rs

          ;;(defcfg
          ;;  process-unmapped-keys yes
          ;;)

          (defvar
            tap-time 200
            hold-time 200
          )

          (defalias
            escctrl (tap-hold 200 200 esc lctl)
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lsft)
            f (tap-hold $tap-time $hold-time f lctl)
            j (tap-hold $tap-time $hold-time j rctl)
            k (tap-hold $tap-time $hold-time k rsft)
            l (tap-hold $tap-time $hold-time l ralt)
            ; (tap-hold $tap-time $hold-time ; rmet)

            da (tap-hold $tap-time $hold-time a lmet)
            do (tap-hold $tap-time $hold-time o lalt)
            de (tap-hold $tap-time $hold-time e lsft)
            du (tap-hold $tap-time $hold-time u lctl)
            dh (tap-hold $tap-time $hold-time h rctl)
            dt (tap-hold $tap-time $hold-time t rsft)
            dn (tap-hold $tap-time $hold-time n ralt)
            ds (tap-hold $tap-time $hold-time s rmet)

            spchold (tap-hold $tap-time $hold-time spc (layer-while-held spacehold))
            g (tap-hold $tap-time $hold-time g (layer-while-held special))
            h (tap-hold $tap-time $hold-time h (layer-while-held special))
            di (tap-hold $tap-time $hold-time i (layer-while-held special))
            dd (tap-hold $tap-time $hold-time d (layer-while-held special))
          )

          (defsrc
            esc
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lmet lalt           spc            ralt rmet rctl
          )

          ;; The first layer defined in your configuration file will be the starting layer
          ;; when  kanata runs. Other layers can be temporarily activated or switched to
          ;; using actions.
          (deflayer base
            @escctrl
            _        _    _    _    _    _    _    _    _    _    _    _    _    _
            tab      _    _    _    _    _    _    _    _    _    _    _    _    _
            @escctrl @a   @s   @d   @f   @g   @h   @j   @k   @l   @;   _    _
            _        _    _    _    _    _    _    _    _    _    _    _
            _        _    _              @spchold       _    _    _
          )

          (deflayer dvorak
            @escctrl
            grv      1    2    3    4    5    6    7    8    9    0    [    ]    bspc
            tab      '    ,    .    p    y    f    g    c    r    l    /    =    \
            @escctrl @da  @do  @de  @du  @di  @dd  @dh  @dt  @dn  @ds  -    ret
            lsft     ;    q    j    k    x    b    m    w    v    z    rsft
            lctl     lmet lalt           spc            ralt rmet rctl
          )

          #|
          This is
          a multi-line comment block
          ! ==> S-1
          @ ==> S-2
          # ==> S-3
          $ ==> S-4
          5 ==> S-5
          6 ==> S-6
          & ==> S-7
          * ==> S-8
          ( ==> S-9
          ) ==> S-0
          |#

          (deflayer spacehold
            @escctrl
            XX       XX   XX   XX   XX   XX    XX   XX   XX   XX   XX   XX   XX   bspc
            tab      S-1  S-2  S-3  S-4  S-5   S-6  S-7  S-8  S-9  S-0  -    XX   XX
            @escctrl 1    2    3    4    5     6    7    8    9    0    +    ret
            lsft     [    ]    S-[  S-]  S-grv S-\  \    S--  grv  =    rsft
            lctl     lmet lalt           XX              ralt rmet rctl
          )

          (deflayer special
            @escctrl
            XX       XX   XX   XX   XX   XX    XX   XX   XX   XX   XX   XX   XX   XX
            blup     brdn brup vold volu mute  XX   prev pp   next prnt XX   XX   XX
            @escctrl XX   XX   XX   XX   XX    XX   XX   XX   XX   XX   XX   ret
            XX       XX   XX   XX   XX   XX    XX   XX   XX   XX   XX   rsft
            lctl     lmet lalt           XX              ralt rmet rctl
          )
        '';
      };
    };
  };
}
