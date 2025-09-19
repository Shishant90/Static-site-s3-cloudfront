
#!/bin/bash

# Configuration
BUCKET_NAME=$1
WEBSITE_DIR="../website"

if [ -z "$BUCKET_NAME" ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

echo "Uploading website files to S3 bucket: $BUCKET_NAME"

# Upload HTML files
aws s3 cp "$WEBSITE_DIR/index.html" "s3://$BUCKET_NAME/" --content-type "text/html"
aws s3 cp "$WEBSITE_DIR/about.html" "s3://$BUCKET_NAME/" --content-type "text/html"
aws s3 cp "$WEBSITE_DIR/error.html" "s3://$BUCKET_NAME/" --content-type "text/html"

# Upload assets
aws s3 sync "$WEBSITE_DIR/assets/" "s3://$BUCKET_NAME/assets/" --delete

echo "Upload completed!"
