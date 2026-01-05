{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      nrb = "sudo nixos-rebuild switch --flake /etc/nixos --impure  --fallback";
      nrbr = "nrb && sudo reboot -f";
      ni = "nvim /etc/nixos/configuration.nix";
      bat =
        "upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E 'state|percentage'";
      gpu = "nvidia-smi -q | grep -i 'draw.*W'";
      wifi = "sudo nmtui";
      all = "sudo chmod -R a+rwx ./*";
      ng = "cd /etc/nginx/ && sudo nvim .";
      copy = "xclip -sel clip";
      pubkey = "cat ~/.ssh/id_ed25519.pub | wl-copy";
      up = "docker compose up -d";
      down = "docker compose down";
      server = "ssh botserver@gitea.deprived.dev -p 224";
      main = "ssh botmain@192.168.50.58";
      vpnup = "systemctl start openvpn-work.service";
      vpndown = "systemctl down openvpn-work.service";
      inspect = "nix edit nixpkgs#$1";
      workssh = "ssh zhen@188.245.106.241";
      desk = "ssh botmain@gitea.deprived.dev -p 226";
      r = "nix run";

      fe = "nix develop";
      fed = "nvim flake.nix";
      cdn = "cd /etc/nixos";
      yaaumma-server = "ssh zhen@188.245.106.241";

    };

    interactiveShellInit = ''
      set -g fish_user_paths ~/bin $fish_user_paths
      function enter
        if test (count $argv) -lt 1
          echo "usage: enter <container-name-or-id>"
            return 1
        end
        docker exec -it $argv[1] sh
      end
      function inspect
        if test (count $argv) -lt 1
          echo "usage: inspect <package name>"
            return 1
        end
        nix edit "nixpkgs#$argv[1]"
      end
      function plasma-check
        set -l before (mktemp -t rc2nix_before.XXXXXX)
        set -l after  (mktemp -t rc2nix_after.XXXXXX)

        # 1) snapshot current state
        rc2nix > $before

        # 2) wait for user to tweak Plasma settings
        read -n 1 -P "Make your Plasma change, then press any key… "

        # 3) snapshot again
        rc2nix > $after

        # 4) show unified diff
        echo "=== Diff (before → after) ==="
        diff -u --label before --label after $before $after

        # 5) extract relevant added lines, trim '+', trim leading spaces
        set -l relevant (diff -u $before $after | awk '
          /^(\+\+\+|---|@@)/ {next}
          /^[+][^+]/ {
            sub(/^[+]/,""); sub(/^[[:space:]]+/,""); print
          }' | string collect)

        if test -n "$relevant"
          echo "=== Copied to clipboard ==="
          printf "%s\n" "$relevant"
          printf "%s" "$relevant" | wl-copy
        else
          echo "No relevant additions found."
        end

        rm -f $before $after
      end
    '';
  };
}
