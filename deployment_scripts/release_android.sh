#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

cd "${repo_root}"

echo "Checking git status..."
if [[ -n "$(git status --porcelain)" ]]; then
  echo "Error: Uncommitted changes detected."
  echo "Please commit or stash all changes before running the Android release."
  exit 1
fi

echo "Git working tree is clean."
echo "Building and uploading Android APK..."

bash "${script_dir}/upload_apk_to_bucket.sh"

echo "APK upload completed."

if [[ ! -f "${repo_root}/pubspec.yaml" ]]; then
  echo "Warning: pubspec.yaml not found. Skipping tag creation."
  exit 0
fi

version_line="$(grep '^version:' pubspec.yaml | head -n1 || true)"

if [[ -z "${version_line}" ]]; then
  echo "Warning: Could not find version in pubspec.yaml. Skipping tag creation."
  exit 0
fi

version="$(echo "${version_line}" | awk '{print $2}' | cut -d+ -f1)"
timestamp="$(date '+%Y-%B-%d-%H%M' | tr '[:upper:]' '[:lower:]')"
tag="v.${version}-${timestamp}"

echo "Creating git tag: ${tag}"
git tag -a "${tag}" -m "Android release ${tag}"

echo "Tag ${tag} created successfully."


