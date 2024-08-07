{
  description = "Python dev.";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  # Flake outputs
  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {

      devShells = forAllSystems ({ pkgs }: {
        default =
          let
            # Use Python 3.12
            python = pkgs.python312;
          in
          pkgs.mkShell {
            packages = [
              (python.withPackages (ps: with ps; [
                virtualenv # Virtualenv
                pip # The pip installer
                requests
                flask
                twine
                #python3 
                #scipy 
                #scikit-learn
                #pkgs.gccStdenv
                #pkgs.libgcc
                #pkgs.gcc
                #pkgs.libcxx
                #pkgs.cmake
                #pkgs.libstdcxx5
                #sklearn-deap
              ]))
            ];
          };
      });
    };
}




