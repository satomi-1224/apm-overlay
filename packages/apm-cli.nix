{
  lib,
  buildPythonApplication,
  fetchPypi,
  setuptools,
  click,
  colorama,
  pyyaml,
  requests,
  python-frontmatter,
  llm,
  llm-github-models,
  toml,
  rich,
  rich-click,
  watchdog,
  gitpython,
}:
buildPythonApplication rec {
  pname = "apm-cli";
  version = "0.35.0";
  pyproject = true;

  src = fetchPypi {
    pname = "apm_cli";
    inherit version;
    hash = "sha256-nxsG7nw1SF0rZajpdPvHGV81jiFJkTqDEvF1BmmOE2M=";
  };

  build-system = [ setuptools ];

  dependencies = [
    click
    colorama
    pyyaml
    requests
    python-frontmatter
    llm
    llm-github-models
    toml
    rich
    rich-click
    watchdog
    gitpython
  ];

  doCheck = false;

  meta = {
    description = "Microsoft Agent Package Manager CLI";
    homepage = "https://microsoft.github.io/apm/";
    license = lib.licenses.mit;
    mainProgram = "apm";
  };
}
