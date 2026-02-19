SvelteKit hello-world (static CDN-ready)
======================================

This is a minimal SvelteKit project configured with `@sveltejs/adapter-static` and hashed asset filenames for CDN (CloudFront) distribution.

Build:

```bash
cd p8i_web
npm install
npm run build
```

After building the `build` directory contains static files and a `manifest.json` mapping original names to hashed assets. You can sync `build` to S3 and point CloudFront to the bucket.

Example deploy (requires `aws` and configured credentials):

```bash
aws s3 sync build/ s3://your-bucket --delete --acl public-read --cache-control "public,max-age=31536000,immutable"
aws cloudfront create-invalidation --distribution-id <id> --paths "/index.html" "/200.html"
```
