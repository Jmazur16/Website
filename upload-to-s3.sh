#!/bin/bash

# Set bucket name
BUCKET_NAME="www.clearshotcny.com"

# Upload HTML files
find live -name "*.html" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "text/html" --acl public-read \;

# Upload CSS files
find live -name "*.css" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "text/css" --acl public-read \;

# Upload JavaScript files
find live -name "*.js" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "application/javascript" --acl public-read \;

# Upload image files
find live \( -name "*.jpg" -o -name "*.jpeg" \) -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "image/jpeg" --acl public-read \;
find live -name "*.png" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "image/png" --acl public-read \;
find live -name "*.gif" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "image/gif" --acl public-read \;
find live -name "*.svg" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "image/svg+xml" --acl public-read \;

# Upload font files
find live -name "*.woff" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "font/woff" --acl public-read \;
find live -name "*.woff2" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "font/woff2" --acl public-read \;
find live -name "*.ttf" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "font/ttf" --acl public-read \;
find live -name "*.eot" -type f -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --content-type "application/vnd.ms-fontobject" --acl public-read \;

# Upload other assets with default content type
find live -type f ! \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.svg" -o -name "*.woff" -o -name "*.woff2" -o -name "*.ttf" -o -name "*.eot" \) -exec aws s3 cp {} s3://${BUCKET_NAME}/{} --acl public-read \;
