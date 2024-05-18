{
  description = "Dev Shell for running in Nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              alejandra
              nodejs
              # (bun.overrideAttrs (_: rec {
              #   version = "1.1.4";
              #   src =
              #     {
              #       "aarch64-linux" = pkgs.fetchurl {
              #         url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-aarch64.zip";
              #         hash = "sha256-XsyjcqKZ667iVTVsOKjaD9iORze0Zs8ZHiDYvuXQ07A=";
              #       };
              #       "x86_64-linux" = fetchurl {
              #         url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64.zip";
              #         hash = "sha256-9H/1qR6ZHHy5/abq2SjoUbUX6Y92/8MQem2inuWhVC8=";
              #       };
              #     }
              #     .${system};
              # }))
              openssl
              yarn-berry
              # glibc

              # node-canvas:
              # python3
              # pkg-config
              # pixman
              # cairo
              # pango
              # libcxx
            ];

            # NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";

            shellHook = ''
              PATH="$PWD/node_modules/.bin:$PATH"
              PATH="$PWD/packages/database/node_modules/.bin:$PATH"
              PATH="$PWD/apps/pages/node_modules/.bin:$PATH"
              export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
              export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
            '';

            # LLVM_SYMBOLIZER = "${libllvm}/bin/llvm-symbolizer";
          };
      }
    );
}
