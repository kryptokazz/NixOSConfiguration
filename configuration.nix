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


  time.timeZone = "Australia/Brisbane";

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



  services.mullvad-vpn = {
    enable = true;
  };

  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

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
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    noto-fonts-cjk
    nerdfonts
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
    ghc
    gnome.pomodoro
    SDL
    SDL2
    SDL2_image
    bun 	
    porsmo
    anki-bin
    localsend
    mullvad
    cargo
    nss 
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
    firefox
    keepassxc
    mpv
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

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


