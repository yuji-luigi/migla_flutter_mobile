.PHONY: release build

# Production API host used when "production" is selected in `make build`.
# Fallback matches prodHost in lib/env_vars.dart. Override per-build, e.g.
#   make build PRODURL=https://staging.migla.school
PRODURL ?= https://migla.school

# Localhost dev server used when "localhost" is selected.
LOCALURL ?= http://localhost:3566

release:
	bash deployment_scripts/release.sh

# Interactive: pick artifacts (iOS / APK / App Bundle) then API environment.
build:
	bash deployment_scripts/build.sh "$(PRODURL)" "$(LOCALURL)"
