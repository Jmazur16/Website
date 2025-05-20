// Image optimization and lazy loading
document.addEventListener('DOMContentLoaded', function() {
    const lazyImages = document.querySelectorAll('.gallery-item img');
    
    // Create WebP versions of images
    function getWebPPath(originalPath) {
        return originalPath.replace(/\.(jpg|jpeg|png)$/i, '.webp');
    }

    // Create responsive image URLs
    function getResponsiveImagePath(originalPath, width) {
        const extension = originalPath.match(/\.[^/.]+$/)[0];
        return originalPath.replace(extension, `-${width}w${extension}`);
    }

    // Lazy load implementation
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                const originalSrc = img.getAttribute('data-src');
                
                // Create picture element for WebP support
                const picture = document.createElement('picture');
                
                // WebP source
                const webpSource = document.createElement('source');
                webpSource.srcset = `
                    ${getWebPPath(getResponsiveImagePath(originalSrc, 400))} 400w,
                    ${getWebPPath(getResponsiveImagePath(originalSrc, 800))} 800w,
                    ${getWebPPath(originalSrc)} 1200w
                `;
                webpSource.type = 'image/webp';
                webpSource.sizes = '(max-width: 400px) 400px, (max-width: 800px) 800px, 1200px';
                
                // Original format source (JPEG/PNG fallback)
                const originalSource = document.createElement('source');
                originalSource.srcset = `
                    ${getResponsiveImagePath(originalSrc, 400)} 400w,
                    ${getResponsiveImagePath(originalSrc, 800)} 800w,
                    ${originalSrc} 1200w
                `;
                originalSource.sizes = '(max-width: 400px) 400px, (max-width: 800px) 800px, 1200px';
                
                // Replace img attributes
                img.src = originalSrc;
                img.removeAttribute('data-src');
                
                // Assemble picture element
                picture.appendChild(webpSource);
                picture.appendChild(originalSource);
                picture.appendChild(img.cloneNode(true));
                
                // Replace original img with picture element
                img.parentNode.replaceChild(picture, img);
                
                observer.unobserve(entry.target);
            }
        });
    }, {
        rootMargin: '50px 0px',
        threshold: 0.01
    });

    // Convert existing images to lazy loading format
    lazyImages.forEach(img => {
        img.setAttribute('data-src', img.src);
        img.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'; // Tiny transparent placeholder
        imageObserver.observe(img);
    });
});
