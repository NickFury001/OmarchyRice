{ pkgs, inputs, ... }: {
  home.username = "yourusername";
  home.homeDirectory = "/home/yourusername";
  home.stateVersion = "24.11";

  # 1. INSTALL APPLICATIONS
  home.packages = [
    pkgs.git
    pkgs.fastfetch
    # Installing from your custom GitHub URL input!
    inputs.superfile.packages.${pkgs.system}.default
  ];

  # 2. MANAGE DOTFILES NATIVELY
  home.file.".bashrc".text = ''
    alias update-sys="home-manager switch --flake ~/.dotfiles#yourusername"
    echo "Welcome to your reproducible environment!"
  '';

  programs.home-manager.enable = true;
}
