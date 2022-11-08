{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "laurent";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/laurent" else "/home/laurent";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["ssh-agent"];
    };
    shellAliases = {
      k8dev = "export KUBECONFIG=$HOME/.kube/dev.yaml";
      k8prod = "export KUBECONFIG=$HOME/.kube/prod.yaml";
      k8beta = "export KUBECONFIG=$HOME/.kube/beta.yaml";
    };
  };

  programs.git = {
    enable = true;
    ignores = ["justfile" "shell.nix" "requirements_dev.txt" ".envrc" ".vscode"];
    userEmail = "laurent@owlint.fr";
    userName = "laurent";
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
  xdg.configFile."nvim/after".source = ./nvim/after;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  home.file.".local/share/nvim/site/pack/packer/start/packer.nvim".source = pkgs.fetchFromGitHub {
    owner = "wbthomason";
    repo = "packer.nvim";
    rev = "6afb67460283f0e990d35d229fd38fdc04063e0a";
    sha256 = "CiDvG7OFg6T/e0xPm7u1rCSnnPwSLATYtjhEw0jlp/M=";
  };

  programs.tmux = {
      enable = true;
      clock24 = true;
      plugins = [
		{
			plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
                pluginName = "tokyonight";
                version = "0.1.1";
                src = pkgs.fetchFromGitHub {
                  owner = "janoamaral";
                  repo = "tokyo-night-tmux";
                  rev = "5c91632";
                  sha256 = "1bhdzsx3kdjqjmm1q4j8937lrpkzf71irr3fqhdbddsghwrrmwim";
                };
            };
		}
	];

  };


  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;
  xdg.configFile."alacritty/dracula.yml".source = ./alacritty/dracula.yml;

  home.packages = [ 
    pkgs.htop
    pkgs.restic
    pkgs.rclone
    pkgs.k9s
    pkgs.starship
    pkgs.zoxide
    pkgs.exa
    pkgs.rsync
    pkgs.jq
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.tokei
    pkgs.s3cmd
    pkgs.ffmpeg
    pkgs.ripgrep
    pkgs.fd
    pkgs.gcc
   ];

}
