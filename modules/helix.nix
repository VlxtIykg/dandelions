{
  config,
  lib,
  pkgs,
  ...
}:
# Nix, dear bastion of immutability, of functional programming
# please `map` me over some fate, because i cannot `deepSeq` this
# editors' configuration anymore... Purge this cursed "TOML" format
# send it back to Hades...
#
# Send help...
#
# Goodnight, Nix evaluator
# I hope your thousands of lines of C++ code
# read this cry for help
# and realize that your immutability and purity
# is also a curse and a blessing for the entire
# world. A world of all the peoples in the world.
#
# You unite and break apart,
# with just functions and minimal control flow...
#
# Imagine the power, if you had switch statements.!
let
  cfg = config.destiny.programs.helix;

  inherit (config.destiny.flake.system) user;
  inherit (lib.destiny) colorPicker flattenToml colorScheme;
  inherit (colorScheme) fg bg;
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;

  themeSet = {
    ui = {
      background = {
        bg = "bg";
      };
      cursor = {
        main = {
          fg = "red";
          modifiers = [ "reversed" ];
        };

        primary = {
          fg = "blue";
          modifiers = [ "reversed" ];
        };

        match = {
          fg = "yellow";
          underline.style = {
            color = "bg";
            style = "dashed";
          };
        };
      };

      text = {
        main = {
          fg = "text";
        };
        info = {
          fg = "text";
        };
        focus = {
          fg = "text";
        };
      };

      selection = {
        main = {
          bg = "lightBg";
        };

        primary = {
          fg = "blue";
          modifiers = [ "reversed" ];
        };
      };

      window = {
        fg = "red";
      };

      gutter = {
        bg = "bg";
      };

      statusline = {
        main = {
          fg = "text";
          bg = "bg";
        };
        active = {
          fg = "text";
          bg = "bg";
        };
        inactive = {
          fg = "text";
          bg = "bg";
        };
        normal = {
          fg = "text";
          bg = "bg";
        };
        insert = {
          fg = "green";
          bg = "bg";
        };
        select = {
          fg = "yellow";
          bg = "bg";
        };
      };

      linenr = {
        main = {
          fg = "text";
        };
        selected = {
          fg = "text";
        };
      };

      virtual = {
        ruler = {
          bg = "text";
        };
        whitespace = {
          fg = "text";
        };

        inlay-hint = {
          fg = "red";
        };
        jump-label = {
          fg = "red";
          modifiers = [ "bold" ];
        };
      };

      help = {
        fg = "text";
        bg = "bg";
      };

      highlight = {
        bg = "bg";
      };

      menu = {
        main = {
          fg = "text";
          bg = "bg";
        };

        selected = {
          fg = "text";
          modifiers = [ "reversed" ];
        };

        scroll = {
          fg = "text";
          bg = "bg";
        };
      };

      popup = {
        main = {
          bg = "lightBg";
          fg = "fg";
        };

        info = {
          bg = "lightBg";
          fg = "fg";
        };
      };
    };

    property = {
      main.fg = "text";
    }; # regex
    special = {
      main.fg = "cyan";
    };

    attribute = {
      main.fg = "magenta";
    };

    type = {
      main.fg = "cyan";

      builtin = {
        fg = "cyan";
      };
      enum.variant = {
        fg = "blue";
      };
    };

    constructor = {
      main.fg = "blue";
    };

    constant = {
      main.fg = "green";
      constant = {
        main.fg = "green";
      };
      builtin = {
        fg = "green";
        boolean = {
          fg = "cyan";
        };
      };
      character = {
        fg = "yellow";
      };
      character.escape = {
        fg = "yellow";
      };
      numeric = {
        fg = "cyan";
        integer = {
          fg = "cyan";
        };
        float = {
          fg = "cyan";
        };
      };
    };

    string = {
      main.fg = "red";
    };
    regexp = {
      fg = "yellow";
    }; # regexp literal
    special = {
      fg = "yellow";
      path = {
        fg = "yellow";
      };
      url = {
        fg = "yellow";
      };
      symbol = {
        fg = "yellow";
      };
    };

    comment = {
      main.fg = "darkFg";
      modifiers = [ "bold" ];

      line = {
        fg = "darkFg";
        modifiers = [ "bold" ];
      };
      block = {
        fg = "darkFg";
        modifiers = [ "bold" ];
      };
      block.documentation = {
        fg = "darkFg";
        modifiers = [
          "bold"
          "italic"
        ];
      };
    };

    variable = {
      fg = "text";

      builtin = {
        fg = "cyan";
      };
      parameter = {
        fg = "magenta";
      };
      other.member = {
        fg = "text";
      };
    };

    label = {
      fg = "cyan";
    };

    punctuation = {
      main.fg = "text";
      delimiter = {
        fg = "blue";
      };
      bracket = {
        fg = "blue";
      };
    };

    keyword = {
      main.fg = "green";
      control = {
        fg = "green";

        conditional = {
          fg = "green";
        };
        repeat = {
          fg = "green";
        };
        import = {
          fg = "green";
        };
        return = {
          fg = "green";
        };
        exception = { };
      };
      operator = {
        fg = "green";
      }; # `or`, `and`, `in`.
      directive = {
        fg = "green";
      }; # incase i forget, this is preprocessor shit
      function = {
        fg = "green";
        modifier = [ "bold" ];
      };
    };

    operator = {
      main.fg = "green";
    };

    function = {
      main.fg = "cyan";
      builtin = {
        fg = "cyan";
      };
      method = {
        fg = "cyan";
      }; # Class / Struct methods.
      macro = {
        fg = "cyan";
      };
      special = {
        fg = "cyan";
      }; # Preprocessor in C.
    };

    tag = {
      main.fg = "blue";
      error = {
        fg = "red";
      };
    };

    diagnostic = {
      info = {
        underline = {
          color = "blue";
          style = "curl";
        };

        bg = "bg";
        fg = "fg";
      };
      hint = {
        underline = {
          color = "green";
          style = "curl";
        };

        bg = "bg";
        fg = "fg";

      };
      warning = {
        underline = {
          color = "yellow";
          style = "curl";
        };

        bg = "bg";
        fg = "fg";
      };

      error = {
        underline = {
          color = "red";
          style = "curl";
        };

        bg = "bg";
        fg = "fg";
      };

      unnecessary = {
        modifiers = [ "dim" ];
      };
      deprecate = {
        modifiers = [ "crossed_out" ];
      };
    };

    info = {
      fg = "blue";
      modifiers = [ "bold" ];
    };

    hint = {
      fg = "green";
      modifiers = [ "bold" ];
    };

    warning = {
      fg = "yellow";
      modifiers = [ "bold" ];
    };

    error = {
      fg = "red";
      modifiers = [ "bold" ];
    };

    namespace = {
      fg = "blue";
    };

    diff = {
      plus = {
        fg = "green";
      };
      minus = {
        fg = "red";
      };
      delta = {
        fg = "yellow";
      };
      delta.moved = {
        fg = "blue";
      };
    };
  };

  theme = {
    palette = {
      inherit fg;
      inherit bg;

      lightBg = colorScheme.lightBg;

      text = fg;
      textDark = colorScheme.darkFg;

      dark = bg;
      light = fg;

      default = colorPicker 0;
      black = colorPicker 1;
      blue = colorPicker 2;
      cyan = colorPicker 3;
      green = colorPicker 4;
      magenta = colorPicker 5;
      red = colorPicker 6;
      white = colorPicker 7;
      yellow = colorPicker 8;
      gray = colorPicker 9;

      light-black = colorPicker 10;
      light-blue = colorPicker 11;
      light-cyan = colorPicker 12;
      light-green = colorPicker 13;
      light-magenta = colorPicker 14;
      light-red = colorPicker 15;
    };
  }
  // (flattenToml themeSet);
in
{
  options.destiny.programs.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.helix = {
        enable = true;
        themes = {
          montrouge = theme;
        };
        settings = {
          theme = "gruber-darker";
          editor = {
            completion-timeout = 5;
            line-number = "relative";
            file-picker.hidden = false;
            end-of-line-diagnostics = "hint";

            # lsp = { display-inlay-hints = true; };

            inline-diagnostics = {
              cursor-line = "warning";
              other-lines = "info";
            };

            soft-wrap = {
              enable = true;
              max-wrap = 30;
            };

            statusline = {
              right = [
                "diagnostics"
                "selections"
                "register"
                "position"
                "file-encoding"
                "file-type"
              ];
              mode = {
                normal = "normal";
                insert = "insert";
                select = "select";
              };
            };
          };

          keys = {
            insert = {
              up = "no_op";
              down = "no_op";
              left = "no_op";
              right = "no_op";
              pageup = "no_op";
              pagedown = "no_op";
              home = "no_op";
              end = "no_op";
            };
          };
        };

        languages = {
          language-server.clangd = {
            command = "${pkgs.clang-tools}/bin/clangd";
          };

          language-server.rust-analyzer.config = {
            check.command = "clippy";

            # inlayHints = {
            # closingBraceHints.minLines = 6;
            # bindingModeHints.enable = true;
            # parameterHints.enable = true;
            # };
          };

          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
            }
            {
              name = "cpp";
              auto-format = true;
              formatter.command = "${pkgs.clang-tools}/bin/clang-format";
            }
          ];
        };
      };
    };
  };
}
