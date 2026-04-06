{ pkgs }:
let
  # https://search.nixos.org/packages?channel=unstable&sort=alpha_asc&type=packages&query=vimPlugins.nvim-treesitter-parsers
  my-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    p: with p; [
      vim
      comment # highlight todos
      gitcommit
      nix
      cpp
      javascript
      rust
      tsx
      typescript
      css
      csv
      diff
      html
      json
      toml
      yaml
      bash
      fish
      gitignore
      git_rebase
      java
      python
      lua
      luadoc
      typst
    ]
  );
in
[ my-treesitter ]
