{ options }:
{
  # Make user specific in the future
  user = {
    name = options.name;
    email = options.email;
    signingkey = "~/.ssh/github_keys/signing.pub";
  };
  alias = {
    st = "status -s";
    lol = "log --oneline --graph --all";
    # Assert to fish keybinds one day nrn
  };
  gpg = {
    format = "ssh";
    commit = "true";
  };
  diff = {
    algorithm = "histogram";
    colorMoved = "plain";
    mnemonicPrefix = true;
    renames = true;
  };
  help.autocorrect = "prompt";
  commit.verbose = true;
  rerere = {
    enabled = true;
    autoupdate = true;
  };
  core.excludesfile = "~/.gitignore";
  rebase = {
    autoSquash = true;
    autoStash = true;
    updateRefs = true;
  };
  merge.conflictstyle = "diff3";
  pull.rebase = true;

  # Semantic/styling stuff; shouldn't affect user to user
  column = {
    ui = "auto";
  };

  branch = {
    sort = "-committerdate";
  };

  tag = {
    sort = "version:refname";
  };

  init = {
    defaultBranch = "main";
  };

  # Affects the user but not a big impact
  push = {
    default = "simple";
    autoSetupRemote = true;
    followTags = true;
  };

  fetch = {
    prune = true;
    pruneTags = true;
    all = true;
  };
}
# email = "97310758+VlxtIykg@users.noreply.github.com";
