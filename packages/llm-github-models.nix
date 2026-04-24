{
  lib,
  buildPythonPackage,
  fetchPypi,
  azure-ai-inference,
  llm,
  aiohttp,
  setuptools,
}:
buildPythonPackage rec {
  pname = "llm-github-models";
  version = "0.18.0";
  pyproject = true;

  src = fetchPypi {
    pname = "llm_github_models";
    inherit version;
    hash = "sha256-t3iqb6Q+U+yzuGj8+YdbwOdgp3Sh+tduqQeiaVgqIEM=";
  };

  build-system = [ setuptools ];

  dependencies = [
    azure-ai-inference
    llm
    aiohttp
  ];

  doCheck = false;

  meta = {
    description = "LLM plugin providing access to GitHub Models";
    homepage = "https://github.com/simonw/llm-github-models";
    license = lib.licenses.asl20;
  };
}
