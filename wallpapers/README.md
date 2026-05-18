# Wallpapers

This directory contains curated wallpapers organized by aesthetic category.
Wallpapers are extracted from cloned repos via `make extract-wallpapers`
or can be placed here manually.

## Categories

| Directory     | Vibe                        |
|---------------|-----------------------------|
| abstract/     | Geometric, colorful, modern |
| anime/        | Anime & manga inspired      |
| dark/         | Dark/moody, low-light       |
| gradients/    | Smooth color transitions    |
| landscapes/   | Mountains, forests, oceans  |
| minimal/      | Clean, simple, sparse       |
| nature/       | Natural world scenes        |
| space/        | Cosmos, stars, nebula       |
| tech/         | Cyber, circuit, glitch      |

## Adding Wallpapers

```bash
# From cloned repos
make extract-wallpapers

# Manual: place images in the appropriate subdirectory
cp my-wallpaper.jpg wallpapers/landscapes/
```
