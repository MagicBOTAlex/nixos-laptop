{ pkgs, ... }:
{
  # # Input Method Configuration - fcitx5 with Chinese Pinyin and Danish
  # i18n.inputMethod = {
  #   enable = true;
  #   type = "fcitx5";
  #   fcitx5 = {
  #     waylandFrontend = true;
  #     plasma6Support = true;
  #     addons = with pkgs; [
  #       fcitx5-gtk # GTK integration
  #       kdePackages.fcitx5-qt # Qt6 integration for Plasma 6
  #       fcitx5-configtool # GUI configuration tool
  #       fcitx5-chinese-addons # Chinese input methods including Pinyin
  #       fcitx5-nord # Optional: Nord theme
  #     ];
  #
  #     # Basic declarative configuration
  #     settings = {
  #       # Input method configuration
  #       inputMethod = {
  #         "Groups/0" = {
  #           Name = "Default";
  #           "Default Layout" = "dk";
  #           DefaultIM = "keyboard-dk";
  #         };
  #         "Groups/0/Items/0" = { Name = "keyboard-dk"; };
  #         "Groups/0/Items/1" = { Name = "pinyin"; };
  #         GroupOrder."0" = "Default";
  #       };
  #     };
  #   };
  # };
}
