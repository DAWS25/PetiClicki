import adapter from '@sveltejs/adapter-static';
import preprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  kit: {
    adapter: adapter({ pages: 'build', assets: 'build', fallback: '200.html' }),
    prerender: { default: true },
    vite: {
      build: {
        manifest: true,
        rollupOptions: {
          output: {
            entryFileNames: 'assets/[name]-[hash].js',
            chunkFileNames: 'assets/[name]-[hash].js',
            assetFileNames: 'assets/[name]-[hash][extname]'
          }
        }
      }
    }
  },
  preprocess: preprocess()
};

export default config;
import preprocess from 'svelte-preprocess';

/** Minimal Svelte config for vite-plugin-svelte */
export default {
  preprocess: preprocess(),
  compilerOptions: {
    dev: false
  }
};
