{
  lib,
  buildPythonPackage,
  fetchPypi,
  azure-core,
  isodate,
  typing-extensions,
  setuptools,
}:
buildPythonPackage rec {
  pname = "azure-ai-inference";
  version = "1.0.0b9";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_ai_inference";
    inherit version;
    hash = "sha256-H+tJa9hLAe4mkb78BDWPol18NE2CiOmTZEOIWa181aQ=";
  };

  build-system = [ setuptools ];

  dependencies = [
    azure-core
    isodate
    typing-extensions
  ];

  doCheck = false;

  meta = {
    description = "Azure AI Inference client library for Python";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/ai/azure-ai-inference";
    license = lib.licenses.mit;
  };
}
