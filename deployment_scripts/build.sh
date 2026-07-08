#!/usr/bin/env bash
#
# Interactive build helper for the MIGLA Flutter app.
#
# Invoked by the Makefile `build` target. Lets you multi-select which
# artifacts to build (iOS / APK / Android App Bundle), then pick the API
# environment (production or localhost). The chosen host is injected into
# the app via --dart-define=API_HOST=... (see lib/env_vars.dart).
#
# Args (passed by the Makefile):
#   $1 = PRODURL   production API host   (fallback: env_vars.dart prodHost)
#   $2 = LOCALURL  localhost API host
#
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
cd "${repo_root}"

PRODURL="${1:-https://migla.school}"
LOCALURL="${2:-http://localhost:3566}"

# ---------------------------------------------------------------------------
# 1. Multi-select: what do you want to build?
# ---------------------------------------------------------------------------
targets=("iOS (.app)" "Android APK (.apk)" "Android App Bundle (.aab)")
checked=(0 0 0)
cursor=0

render_menu() {
  clear
  echo "What do you want to build?  (↑/↓ move · SPACE toggle · ENTER confirm)"
  echo
  for i in "${!targets[@]}"; do
    mark=" "
    [[ ${checked[$i]} -eq 1 ]] && mark="x"
    if [[ $i -eq $cursor ]]; then
      printf "> [%s] %s\n" "$mark" "${targets[$i]}"
    else
      printf "  [%s] %s\n" "$mark" "${targets[$i]}"
    fi
  done
}

while true; do
  render_menu
  IFS= read -rsn1 key
  if [[ $key == $'\x1b' ]]; then
    IFS= read -rsn2 key
    case "$key" in
      "[A") cursor=$(( (cursor - 1 + ${#targets[@]}) % ${#targets[@]} )) ;;
      "[B") cursor=$(( (cursor + 1) % ${#targets[@]} )) ;;
    esac
  elif [[ "$key" == " " ]]; then
    checked[$cursor]=$(( 1 - checked[$cursor] ))
  elif [[ -z "$key" ]]; then
    break
  fi
done

if [[ ${checked[0]} -eq 0 && ${checked[1]} -eq 0 && ${checked[2]} -eq 0 ]]; then
  echo "Nothing selected. Aborting."
  exit 0
fi

# ---------------------------------------------------------------------------
# 2. Single-select: which API environment?
# ---------------------------------------------------------------------------
envs=("production  ->  ${PRODURL}" "localhost   ->  ${LOCALURL}")
env_cursor=0

while true; do
  clear
  echo "Which API endpoint?  (↑/↓ move · ENTER confirm)"
  echo
  for i in "${!envs[@]}"; do
    if [[ $i -eq $env_cursor ]]; then
      printf "> %s\n" "${envs[$i]}"
    else
      printf "  %s\n" "${envs[$i]}"
    fi
  done
  IFS= read -rsn1 key
  if [[ $key == $'\x1b' ]]; then
    IFS= read -rsn2 key
    case "$key" in
      "[A") env_cursor=$(( (env_cursor - 1 + ${#envs[@]}) % ${#envs[@]} )) ;;
      "[B") env_cursor=$(( (env_cursor + 1) % ${#envs[@]} )) ;;
    esac
  elif [[ -z "$key" ]]; then
    break
  fi
done

if [[ $env_cursor -eq 0 ]]; then
  API_HOST="${PRODURL}"
  env_name="production"
else
  API_HOST="${LOCALURL}"
  env_name="localhost"
fi

clear
echo "Environment : ${env_name}"
echo "API_HOST    : ${API_HOST}"
echo "Targets     :"
[[ ${checked[0]} -eq 1 ]] && echo "  - iOS"
[[ ${checked[1]} -eq 1 ]] && echo "  - Android APK"
[[ ${checked[2]} -eq 1 ]] && echo "  - Android App Bundle"
echo

DEFINE="--dart-define=API_HOST=${API_HOST}"

if [[ ${checked[0]} -eq 1 ]]; then
  echo ">>> flutter build ios --release ${DEFINE}"
  flutter build ios --release "${DEFINE}"
fi
if [[ ${checked[1]} -eq 1 ]]; then
  echo ">>> flutter build apk --release ${DEFINE}"
  flutter build apk --release "${DEFINE}"
fi
if [[ ${checked[2]} -eq 1 ]]; then
  echo ">>> flutter build appbundle --release ${DEFINE}"
  flutter build appbundle --release "${DEFINE}"
fi

echo
echo "Done."
