Place your logo image(s) in this folder.

Recommended path for the logo used in the app:

  p8i_web/static/images/logo.png

Files placed here are served verbatim at the site root (no build fingerprint):

  /images/logo.png

Usage examples:

  - In HTML (public, meta tags): <img src="/images/logo.png" alt="logo">
  - In SvelteKit head (meta): <link rel="icon" href="/images/logo.png" />

If you prefer a fingerprinted asset (long-term CDN cache), place the image
under `p8i_web/src/lib/assets/` and import it from your Svelte code.

To move the attached logo into place from the workspace root (example):

```bash
# if the logo file is saved locally as "peticlicki-logo.png"
mv peticlicki-logo.png p8i_web/static/images/logo.png
```
