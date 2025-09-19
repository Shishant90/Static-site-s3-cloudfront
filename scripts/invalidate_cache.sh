
#!/bin/bash

DISTRIBUTION_ID=$1

if [ -z "$DISTRIBUTION_ID" ]; then
    echo "Usage: $0 <cloudfront-distribution-id>"
    exit 1
fi

echo "Creating CloudFront invalidation for distribution: $DISTRIBUTION_ID"

aws cloudfront create-invalidation \
    --distribution-id "$DISTRIBUTION_ID" \
    --paths "/*"

echo "Invalidation created!"
