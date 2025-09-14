
// astro.config.mjs
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  integrations: [
    starlight({
      title: 'Sustainable Survival',
      sidebar: [
        { label: 'Docs', autogenerate: { directory: 'docs' } },
      ],
    }),
  ],
});