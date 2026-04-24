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
  version = "0.9.2";
  pyproject = true;

  src = fetchPypi {
    pname = "apm_cli";
    inherit version;
    hash = "sha256-hWh8A0+0LjLRjVKqy4awQp+6/z38JDD916zHPOMBxHM=";
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
