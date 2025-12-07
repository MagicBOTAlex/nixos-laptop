{ pkgs, lib, ... }:
let
  toggles = import ./../toggles.nix;
in
{
  config = lib.mkIf (toggles.keyboardMouse.enable or false)
    {
      system.activationScripts.wl-kbptr = {
        text = ''
          USER=botlap

          mkdir -p "/home/$USER/.config"
          rm -fr "/home/$USER/.config/wl-kbptr"
          ln -sfn /etc/nixos/configs/wl-kbptr "/home/$USER/.config/wl-kbptr"

          chown -R $USER:users "/home/$USER/.config"
        '';
      };

      programs.ydotool.enable = true;
      users.users = {
        botlap = {
          extraGroups = [ "uinput" ];
        };
      };
      security.sudo.extraRules = [
        {
          users = [ "botlap" ];
          commands = [
            {
              command = "/home/botmain/.nix-profile/bin/ydotool";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
      environment.systemPackages = with pkgs; [
        wl-kbptr

        (writeShellScriptBin "wl-kbptr-ydotool" ''
          #!${pkgs.bash}/bin/bash
          
          out="$(${pkgs.wl-kbptr}/bin/wl-kbptr --only-print "$@")" || exit 1
          # e.g.: "23x23+0+0 +1707+0 n"
          read -r box coords side <<<"$out"

          if [[ "$coords" =~ \+([0-9]+)\+([0-9]+) ]]; then
            x="$${BASH_REMATCH[1]}"
            y="$${BASH_REMATCH[2]}"
          else
            echo "Unexpected wl-kbptr output: $out" >&2
            exit 1
          fi

          sudo YDOTOOL_SOCKET=/run/ydotoold/socket ${pkgs.ydotool}/bin/ydotool mousemove --absolute "$x" "$y"
          sudo YDOTOOL_SOCKET=/run/ydotoold/socket ${pkgs.ydotool}/bin/ydotool click 0xC0
        '')
      ];
    };
}
