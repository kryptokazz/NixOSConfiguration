# /etc/nixos/configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;

  environment.systemPackages = with pkgs; [
    auto-cpufreq
    bumblebee
    primus
    tlp
    tlp-rdw
    vim
    neovim
    htop
    make
    gcc
    linuxHeaders
    firefox
    networkmanagerapplet
    wget
    git
    tmux
    wl-clipboard
  ];

  environment.variables.EDITOR = "nvim";

  services = {
    auto-cpufreq = {
      enable = true;
    };

    bumblebee = {
      enable = true;
      package = pkgs.bumblebee;
    };

    tlp = {
      enable = true;
      package = pkgs.tlp;
    };
  };

  nixpkgs.config.allowUnfree = true; # Allow proprietary drivers in nvidia packages

  # Add any additional hardware-specific configuration here.

  # Include the necessary kernel modules for bumblebee.
  boot.kernelModules = ["i915" "bbswitch" "nvidia" "nvidia_modeset" "nvidia_uvm"];

  # Add your user to the bumblebee group.
  users.extraUsers.<your-username> = {
    isNormalUser = true;
    extraGroups = ["bumblebee"];
  };

  # Optional: Enable the GNOME desktop environment.
  # services.xserver.desktopManager.gnome.enable = true;

  # Optional: Add powertop for further optimization.
  # environment.systemPackages = [ pkgs.powertop ];

  # Additional configuration can be added as needed.
}
