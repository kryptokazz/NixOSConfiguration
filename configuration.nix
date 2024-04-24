{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;





  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;





  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
   { config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;





  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swaylock
    framesh
    swww
    waybar
    python3
    libxcrypt
    libsForQt5.qt5ct
    git
    redshift
    htop		
    gnome.pomodoro
    gnome.gvfs
    typescript 
    calibre-web
    bk
    SDL
    SDL2
    gnumake
    julia_18-bin
    zoxide
    nodePackages_latest.gulp
    electron_28    
   (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
    obs-backgroundremoval
    obs-pipewire-audio-capture
    wlrobs
    ];
    })
    
    wine
    unrar
    nix-index
    wayshot
    pkgsi686Linux.gperftools
    pcmanfm
    imagemagick
    wayland-protocols
    waylandpp
    wayland-utils
    wayland-scanner
    firefox-devedition
    wireplumber
    pamixer
    qalculate-qt
    playerctl
    river
    scdoc
    rustup
    mullvad-browser
    tldr
    bat
    mullvad-closest
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad	
    glfw
    freeglut
    mesa
    cargo
    nss 
    ventoy-full
    iputils
    nodejs_21
    libnotify 
    gtk3 
    vim  
    gcc
    ncurses
    mesa
    libGL
    alacritty
    pgadmin4
    postgresql
    unzip
    curl
    jq
    zsh
    nix
    ansible
    libreoffice-fresh
    mpv
    firefox-bin
    keepassxc
    mpv
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
 
  hardware.opengl.extraPackages = with pkgs; [ amdvlk
	];

hardware.opengl.extraPackages32 = with pkgs; [
	driversi686Linux.amdvlk
];


hardware.opengl.enable = true;


  programs.zsh.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";

  # Use /dev/nvme0n1p3 for /home/nixoshome
  fileSystems."/home/nixoshome" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4"; # Adjust if using a different file system type
  };
}
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
 
  hardware.opengl.extraPackages = with pkgs; [ amdvlk
	];

hardware.opengl.extraPackages32 = with pkgs; [
	driversi686Linux.amdvlk
];


hardware.opengl.enable = true;


  programs.zsh.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";

  # Use /dev/nvme0n1p3 for /home/nixoshome
  fileSystems."/home/nixoshome" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4"; # Adjust if using a different file system type
  };
}


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swaylock
    framesh
    swww
    waybar
    python3
    libxcrypt
    libsForQt5.qt5ct
    git
    redshift
    htop		
    gnome.pomodoro
    gnome.gvfs
    typescript 
    calibre-web
    bk
    SDL
    SDL2
    gnumake
    julia_18-bin
    zoxide
    nodePackages_latest.gulp
    electron_28    
   (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
    obs-backgroundremoval
    obs-pipewire-audio-capture
    wlrobs
    ];
    })
    
    wine
    unrar
    nix-index
    wayshot
    pkgsi686Linux.gperftools
    pcmanfm
    imagemagick
    wayland-protocols
    waylandpp
    wayland-utils
    wayland-scanner
    firefox-devedition
    wireplumber
    pamixer
    qalculate-qt
    playerctl
    river
    scdoc
    rustup
    mullvad-browser
    tldr
    bat
    mullvad-closest
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad	
    glfw
    freeglut
    mesa
    cargo
    nss 
    ventoy-full
    iputils
    nodejs_21
    libnotify 
    gtk3 
    vim  
    gcc
    ncurses
    mesa
    libGL
    alacritty
    pgadmin4
    postgresql
    unzip
    curl
    jq
    zsh
    nix
    ansible
    libreoffice-fresh
    mpv
    firefox-bin
    keepassxc
    mpv
  ];

 { config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;




  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swaylock
    framesh
    swww
    waybar
    python3
    libxcrypt
    libsForQt5.qt5ct
    git
    redshift
    htop		
    gnome.pomodoro
    gnome.gvfs
    typescript 
    calibre-web
    bk
    SDL
    SDL2
    gnumake
    julia_18-bin
    zoxide
    nodePackages_latest.gulp
    electron_28    
   (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
    obs-backgroundremoval
    obs-pipewire-audio-capture
    wlrobs
    ];
    })
    
    wine
    unrar
    nix-index
    wayshot
    pkgsi686Linux.gperftools
    pcmanfm
    imagemagick
    wayland-protocols
    waylandpp
    wayland-utils
    wayland-scanner
    firefox-devedition
    wireplumber
    pamixer
    qalculate-qt
    playerctl
    river
    scdoc
    rustup
    mullvad-browser
    tldr
    bat
    mullvad-closest
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad	
    glfw
    freeglut
    mesa
    cargo
    nss 
    ventoy-full
    iputils
    nodejs_21
    libnotify 
    gtk3 
    vim  
    gcc
    ncurses
    mesa
    libGL
    alacritty
    pgadmin4
    postgresql
    unzip
    curl
    jq
    zsh
    nix
    ansible
    libreoffice-fresh
    mpv
    firefox-bin
    keepassxc
    mpv
  ];

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;





  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swaylock
    framesh
    swww
    waybar
    python3
    libxcrypt
    libsForQt5.qt5ct
    git
    redshift
    htop		
    gnome.pomodoro
    gnome.gvfs
    typescript 
    calibre-web
    bk
    SDL
    SDL2
    gnumake
    julia_18-bin
    zoxide
    nodePackages_latest.gulp
    electron_28    
   (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
    obs-backgroundremoval
    obs-pipewire-audio-capture
    wlrobs
    ];
    })
    
    wine
    unrar
    nix-index
    wayshot
    pkgsi686Linux.gperftools
    pcmanfm
    imagemagick
    wayland-protocols
    waylandpp
    wayland-utils
    wayland-scanner
    firefox-devedition
    wireplumber
    pamixer
    qalculate-qt
    playerctl
    river
    scdoc
    rustup
    mullvad-browser
    tldr
    bat
    mullvad-closest
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad	
    glfw
    freeglut
    mesa
    cargo
    nss 
    ventoy-full
    iputils
    nodejs_21
    libnotify 
    gtk3 
    vim  
    gcc
    ncurses
    mesa
    libGL
    alacritty
    pgadmin4
    postgresql
    unzip
    curl
    jq
    zsh
    nix
    ansible
    libreoffice-fresh
    mpv
    firefox-bin
    keepassxc
    mpv
  ];
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kryptokazz"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];  

  time.timeZone = "Australia/Brisbane";

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
        extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
          pkgs'.gperftools
        ]);
      });
    })
  ];


  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };


# Enable IBus input method framework 
i18n.inputMethod = {
	enabled = "ibus";
	ibus.engines = with pkgs.ibus-engines; [libpinyin hangul];
};


 environment.etc."alacritty/alacritty.yml".source = ~/.config;

  services.mullvad-vpn = {
    enable = true;
  };


 services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
  
  programs.thunar.enable = true; 
  programs.xfconf.enable = true;
  programs.steam.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-pluginAre your account recovery settings up to date? If not, you risk getting locked out of your account.
  thunar-volman
  ];


  programs.noisetorch.enable = true; 

  services.gvfs.enable = true; 
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;





  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  services.xserver.videoDrivers = ["modesetting"];


  services.getty.autologinUser = "kryptokazz";

  services.printing.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.kryptokazz = {
    isNormalUser = true;
    description = "kryptokazz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];


  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swaylock
    framesh
    swww
    waybar
    python3
    libxcrypt
    libsForQt5.qt5ct
    git
    redshift
    htop		
    gnome.pomodoro
    gnome.gvfs
    typescript 
    calibre-web
    bk
    SDL
    SDL2
    gnumake
    julia_18-bin
    zoxide
    nodePackages_latest.gulp
    electron_28    
   (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
    obs-backgroundremoval
    obs-pipewire-audio-capture
    wlrobs
    ];
    })
    
    wine
    unrar
    nix-index
    wayshot
    pkgsi686Linux.gperftools
    pcmanfm
    imagemagick
    wayland-protocols
    waylandpp
    wayland-utils
    wayland-scanner
    firefox-devedition
    wireplumber
    pamixer
    qalculate-qt
    playerctl
    river
    scdoc
    rustup
    mullvad-browser
    tldr
    bat
    mullvad-closest
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad	
    glfw
    freeglut
    mesa
    cargo
    nss 
    ventoy-full
    iputils
    nodejs_21
    libnotify 
    gtk3 
    vim  
    gcc
    ncurses
    mesa
    libGL
    alacritty
    pgadmin4
    postgresql
    unzip
    curl
    jq
    zsh
    nix
    ansible
    libreoffice-fresh
    mpv
    firefox-bin
    keepassxc
    mpv
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
 
  hardware.opengl.extraPackages = with pkgs; [ amdvlk
	];

hardware.opengl.extraPackages32 = with pkgs; [
	driversi686Linux.amdvlk
];


hardware.opengl.enable = true;


  programs.zsh.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "unstable";

  # Use /dev/nvme0n1p3 for /home/nixoshome
  fileSystems."/home/nixoshome" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4"; # Adjust if using a different file system type
  };
}
