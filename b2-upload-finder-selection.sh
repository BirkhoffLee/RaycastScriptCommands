#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Upload Finder Selection to B2
# @raycast.mode fullOutput
# @raycast.packageName Birkhoff

# Optional parameters:
# @raycast.icon ☁️
# @raycast.description Upload the selected Finder file to B2 and copy a 7-day presigned URL to clipboard.

export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:$PATH"
unset LC_ALL

FILE=$(osascript -e '
  tell application "Finder"
    set sel to selection
    if sel is {} then
      return ""
    else
      return POSIX path of (item 1 of sel as alias)
    end if
  end tell')

if [[ -z "$FILE" ]]; then
  echo "No file selected in Finder"
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "Selection is not a file: $FILE"
  exit 1
fi

FILENAME=$(basename "$FILE")

export AWS_ENDPOINT_URL=https://s3.us-west-002.backblazeb2.com
export AWS_DEFAULT_REGION=us-west-002
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

AWS_ACCESS_KEY_ID=$(op read "op://Private/B2 Application Key/keyID") || {
  echo "Failed to read credentials from 1Password"
  exit 1
}
AWS_SECRET_ACCESS_KEY=$(op read "op://Private/B2 Application Key/applicationKey") || {
  echo "Failed to read credentials from 1Password"
  exit 1
}

BUCKET_NAME=assets-birkhoff-private

# Files are uploaded into /t which has the lifecycle rule of objects
# being only valid for 7 days (i.e. they get deleted after a week).

echo "Uploading $FILENAME..."
aws s3 cp "$FILE" "s3://$BUCKET_NAME/t/$FILENAME" 2>&1 | awk 'BEGIN{RS="\r"} NF{print; fflush()}'
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
  echo "Upload failed"
  exit 1
fi

URL=$(aws s3 presign "s3://$BUCKET_NAME/t/$FILENAME" --expires-in 604800)
URL="${URL/$BUCKET_NAME.s3.us-west-002.backblazeb2.com/download.birkhoff.me}"

echo -n "$URL" | pbcopy
EXPIRY_DATE=$(date -v+7d +"%d/%m/%Y")
echo "Copied URL for $FILENAME (valid until $EXPIRY_DATE)"
