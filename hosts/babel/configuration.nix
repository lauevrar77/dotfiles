{ pkgs, modulesPath, lib, config, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  system.stateVersion = "22.11";

  # Install some packages
    environment.systemPackages = 
            with pkgs; 
            [
                zsh
                htop
                vim
                tailscale
            ]; 

  users.users.laurent = {
    isNormalUser  = true;
    home  = "/home/laurent";
    description  = "Laurent Evrard";
    extraGroups  = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys  = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVEwVqhmgtNWE6HwI2ZtsAfp4esjUur6AlWq4mzcH4o laurent@ipad" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWJZ2YHSY7YtzCgpYRya/lIa0duzyfyhDybiUFgkoeP laurent@Laurents-MacBook-Pro.local" ];
  };

  services.tailscale.enable = true;

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      # This key is safe to 'leak' as it is a one time use
      ${tailscale}/bin/tailscale up -authkey 'tskey-auth-kL8Yvz2CNTRL-Lr9jkvW6CV6hymZJtpWkN64auc1H1Vzdh'
    '';
  };

  networking.firewall = {
    # enable the firewall
    enable = true;
    checkReversePath = "loose";

    # always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];

    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];

    # allow you to SSH in over the public internet
    allowedTCPPorts = [ 22 ];
  };
}
