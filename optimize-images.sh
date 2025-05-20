#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "ImageMagick is required but not installed. Please install it first:"
    echo "brew install imagemagick"
    exit 1
fi

# Process all images in the portfolio and realestate directories
find live/assets/images/portfolio live/assets/images/realestate -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r img; do
    echo "Processing $img..."
    
    # Get directory and filename
    dir=$(dirname "$img")
    filename=$(basename "$img")
    name="${filename%.*}"
    ext="${filename##*.}"
    
    # Create WebP version (if cwebp is available)
    if command -v cwebp &> /dev/null; then
        cwebp -q 80 "$img" -o "${dir}/${name}.webp"
    fi
    
    # Create responsive versions
    for size in 400 800; do
        # Resize and optimize original format
        convert "$img" -resize "${size}x" -quality 80 -strip "${dir}/${name}-${size}w.${ext}"
        
        # Create WebP version of the resized image (if cwebp is available)
        if command -v cwebp &> /dev/null; then
            cwebp -q 80 "${dir}/${name}-${size}w.${ext}" -o "${dir}/${name}-${size}w.webp"
        fi
    done
done

echo "Image optimization complete!"
