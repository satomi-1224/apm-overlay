#!/usr/bin/env bash
set -euo pipefail

# Updates version and hash in a fetchPypi-based nix file.
update_package() {
  local nix_file="$1"
  local pypi_name="$2"

  local current_version
  current_version=$(grep 'version = ' "$nix_file" | head -1 | sed 's/.*version = "\(.*\)".*/\1/')

  local latest_version
  latest_version=$(curl -sf "https://pypi.org/pypi/${pypi_name}/json" | jq -r '.info.version')

  if [ "$current_version" = "$latest_version" ]; then
    echo "${pypi_name}: already at ${current_version}"
    return
  fi

  echo "${pypi_name}: ${current_version} → ${latest_version}"

  local url
  url=$(curl -sf "https://pypi.org/pypi/${pypi_name}/${latest_version}/json" | \
    jq -r '.urls[] | select(.packagetype == "sdist") | .url')

  local new_hash
  new_hash=$(nix store prefetch-file --json --hash-type sha256 "$url" | jq -r '.hash')

  local old_hash
  old_hash=$(grep 'hash = "sha256-' "$nix_file" | sed 's/.*hash = "\(sha256-[^"]*\)".*/\1/')

  sed -i "s/version = \"${current_version}\"/version = \"${latest_version}\"/" "$nix_file"
  sed -i "s|hash = \"${old_hash}\"|hash = \"${new_hash}\"|" "$nix_file"

  echo "Updated ${pypi_name} to ${latest_version}"
}

update_package "packages/apm-cli.nix"              "apm-cli"
update_package "packages/azure-ai-inference.nix"   "azure-ai-inference"
update_package "packages/llm-github-models.nix"    "llm-github-models"
