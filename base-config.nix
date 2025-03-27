# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    defaultGateway = {
      address = "172.31.1.1";
      interface = "enp1s0";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    hostName = "nixos";
  };

  environment.systemPackages = with pkgs; [
    curl
    tree
  ];

  users.users.rc-14 = {
    extraGroups = [ "wheel" ];
    initialPassword = "1234";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3gaPO0iFZ8kcDHMsFT5YPWA9k5mou9+VyZYwEvA470w/8UkC5y3rVse+FTxsIO7ju5/NaQQK94jMKNrb8qNErnOGbdaWwKXHhlnWhvntW4qpl23g/2UV244OxuSHKz5ECWt3BbBqQv0VKT8b7mqsGQY+6mTi0wa9PcGrnZ/wQlMBXAk7pxMxJVzG3q4KPpKpTX57mXYhL+FWnridgzddI0WgE0G2/7ZZZGfnxjWojb3nvsUC41dtDZ7eJk+vzvUnZhbyC4RZ1UM+Pb+8fhcpeRFOgyCu+0n/FSqUpdceyNItu21JQe7hy6eCDprx13G/TrJSLiE1X5/mXZlEOU5RfBwbMIMm2WlxfbL9HCViZm8oL9ZXFOmgM7kyVb2tw4Fj2AC+OlDVtL0prwKX3UTSmMsNQVdWsM+AIExDqNQHQghFBXrM17A9GUs2wu/l1+ba1hsQLKSf7lVc9Ushk0IzCZqv6Nw4CPbj9hmHa0d7LNPHa7WIG/L6557x5E+COuFk= rc-14@THINKPAD2"
    ];
    packages = with pkgs; [ ];
  };

  programs = {
    bash = {
      shellAliases = {
        l = "ls";
        la = "ls -A";
        ll = "ls -lh";
        lla = "ls -lhA";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      authorizedKeysInHomedir = false;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
