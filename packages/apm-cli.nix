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
  version = "0.30.0";
  pyproject = true;

  src = fetchPypi {
    pname = "apm_cli";
    inherit version;
    hash = "sha256-T0EsZarGoZhkwFUpBBmdhejxoobGDeSOvTsUIuzLdg8=";
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
