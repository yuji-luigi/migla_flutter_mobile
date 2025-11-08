#!/bin/bash
HOST=eu-central-1.linodeobjects.com

flutter build apk --release

s3cmd --host="$HOST" --host-bucket="%(bucket)s.$HOST" \
  put ./build/app/outputs/flutter-apk/app-release.apk s3://migla-storage/releases/migla-app-release.apk \
  --acl-public \
  --mime-type="application/vnd.android.package-archive" \
  --add-header='Content-Disposition: attachment; filename="app-release.apk"'