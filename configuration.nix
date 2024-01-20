{ config, pkgs, ... }:

let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    config = {
      allowUnfree = true;
    };
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${stable}/nixos")  # Import stable channel configuration
  ];

  home-manager.users.kryptokazz = {
	home.stateVersion = "23.11";
 };
}


  # Enable experimental features (flakes)
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Auto optimize store
  nix.settings.auto-optimise-store = true;

  networking.hostName = "kryptokazz";
  networking.networkmanager.enable = true;
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

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager.sddm.enable = true;
  };

  virtualisation.containerd.enable = true;

  services.k3s = {
    enable = true;
    role = "server";
  };

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

  services.getty.autologinUser = "kryptokazz";

  system.autoUpgrade = {
    enable = true;
  };

  # Change this line to use the stable channel
  nixpkgs.config.allowBroken = true;

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

  security.polkit.enable = true;

  # Change this line to use the stable channel
  environment.systemPackages = with stable; [
    kitty
    swww
    libnotify 
    mako
    pkgs.home-manager
    swaylock
    material-design-icons
    rustc
    cargo
    waybar
    python3
    appimagekit
    appimage-run    
    unixODBC
    git
    subversion
    redshift
    nmap
    htop
    freetube
    rsync
    ncdu
    tree
    bruno
    modd
    mullvad-vpn
    mesa
    libGL
    gcc
    gnome.pomodoro
    alacritty
    gnumake
    cmake
    insomnia
    planify
    ghc
    tk
    glxinfo 
    nodejs_20
    unetbootin
    docker
    raven-reader
    dynamips
    bisq-desktop
    localsend
    nerdctl
    jdk
    haskell-ci
    mcomix
    syncthing
    unrar
    fluent-reader
    pgadmin4
    postgresql
    zip
    go
    retext
    elixir_1_14
    vim
    neovim
    htop
    firefox-bin
    tree
    unzip
    gnutar
    curl
    jq
    libsForQt5.sddm
    gzip
    curl
    wget
    netcat
    libstdcxx5
    openvpn
    openssh
    screen
    lsd
    tmux
    zsh
    bashInteractive
    podman
    terraform
    nix
    bun
    ansible
    libreoffice-fresh
    gns3-server
    gns3-gui
    packer
    mpv
  ];

  services.redshift = {
    enable = true;
    brightness = {
      day = 1;
      night = 1;
    };

    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  location.latitude = 151.209900;
  location.longitude = -33.865143;

  boot.initrd.kernelModules = [ "amdgpu" ];

  virtualisation.docker.enable = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

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

  # Change this line to use the stable channel
  system.stateVersion = "23.11";
}

