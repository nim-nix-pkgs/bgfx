{
  description = ''BGFX wrapper for the nim programming language.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."bgfx-master".dir   = "master";
  inputs."bgfx-master".owner = "nim-nix-pkgs";
  inputs."bgfx-master".ref   = "master";
  inputs."bgfx-master".repo  = "bgfx";
  inputs."bgfx-master".type  = "github";
  inputs."bgfx-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."bgfx-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}