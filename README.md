# huskersec.github.io

Personal security research blog — vulnerability research, offensive security
writeups, tooling, and notes. Built with [Chirpy][chirpy] (Jekyll) and deployed
to GitHub Pages via GitHub Actions.

Live: https://huskersec.com (also reachable at https://huskersec.github.io)

## Local development

Requires Ruby + Bundler ([Jekyll install guide][jekyll-install]).

```bash
bundle install
bundle exec jekyll serve        # http://127.0.0.1:4000
bundle exec jekyll serve --drafts   # include _drafts/
```

## Writing a post

1. Create `_posts/YYYY-MM-DD-slug.md`.
2. Add front matter (see existing posts or `_drafts/TEMPLATE-vuln-writeup.md`).
3. `categories` is hierarchical (max 2 levels); `tags` are flat and lowercase.
4. Commit + push to `main` — the Actions workflow builds and deploys.

Work-in-progress posts live in `_drafts/` and only render with `--drafts`.

## Structure

```
_posts/     published posts
_drafts/    unpublished drafts + writeup template
_tabs/      sidebar pages (about, resume, archives, categories, tags)
assets/     images, files, custom static assets
_config.yml site configuration
```

## Custom domain

The site is served from the custom domain [huskersec.com](https://huskersec.com)
(with HTTPS enforced) and remains reachable at the default
`huskersec.github.io`.

[chirpy]: https://github.com/cotes2020/jekyll-theme-chirpy
[jekyll-install]: https://jekyllrb.com/docs/installation/
