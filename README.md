# Backdrop

Moving backgrounds, made for 9:16 first. Browse 35 looks in 8 families, tune the palette and shape, try variations, and export seamless loops. Looks you save to the library appear in Drift and Galileo.

**[Download the latest release](https://github.com/bomkino/backdrop/releases/latest)** · Apple silicon, macOS 14 or later

Backdrop is a native Mac app (SwiftUI and Metal) from pitch.dog. It shares its engine with [Drift 2](https://github.com/bomkino/pitchdog-drift), which turns decks into reels, and [Galileo 2](https://github.com/bomkino/galileo-gallery), which turns work into moving galleries; this repository holds Backdrop and the engine modules it is built from.

## Using Backdrop

- A new window opens on Soft Bloom in 9:16, already playing. Rest the pointer on any of the 35 looks, in 8 families, to audition it on the stage; click to use it. A palette you chose yourself stays when you switch looks.
- The inspector sets the palette (or borrows one from a picture), the shape, the film finish and the loop length. Variations of the current look sit beside the stage; click one to use it.
- **Preview a slide** lays a sample slide over the background, to judge it behind real work.
- Scroll with two fingers over the stage to move through the loop; playback carries on when you let go.
- **Save to Library** keeps the look, with its film finish and loop length, for Drift and Galileo, where it appears among their backgrounds. **Library** lists your saved looks to use again, rename or move to the Trash.
- The toolbar switches between 9:16, 4:5, 1:1 and 16:9; Cinema and 4K are in the menu beside it.
- Export writes MP4, HEVC, ProRes, numbered PNG frames or a still. Every look loops seamlessly and previews exactly as it exports.

## Installing a release

Download the disk image from the [Releases](https://github.com/bomkino/backdrop/releases) page, open it and drag Backdrop to Applications. The app is ad-hoc signed and not notarized, so the first time, Control-click it and choose Open (or allow it under System Settings › Privacy & Security). The same disk image also comes with each Drift 2 and Galileo 2 release.

## Build

Needs the Command Line Tools (no Xcode) on macOS 14 or later.

```bash
bash scripts/build.sh release
```

The app lands in `../dist/Backdrop.app`. The script builds against the macOS 26.5 SDK because the macOS 27 SDK expands SwiftUI's `@State` with a macro plugin that only ships with Xcode.

## Checking without a screen

```bash
bash scripts/verify.sh
```

Builds the app, then renders every look as a still in a tall and a wide frame and checks that none comes out blank. The app also takes flags for headless checks; give every flag a value, because AppKit reads a bare word after a valueless flag as a document to open:

```bash
"../dist/Backdrop.app/Contents/MacOS/Backdrop" --still out.png --scene aurora --format reel --time 2
```

`--scene` takes a look's id (`studio`, `softbloom`, `mesh`, `fade`, `solid`, `linear`, `radial`, `conic`, `paper`, `riso`, `wash`, `ink`, `halo`, `aurora`, `bloom`, `leak`, `bokeh`, `rays`, `caustics`, `fluted`, `frost`, `iris`, `contours`, `silk`, `linefield`, `ridgelines`, `dunes`, `smoke`, `marble`, `chrome`, `lava`, `cells`, `halftone`, `dotgrid`, `matrix`); `--format` is `reel`, `portrait`, `square` or `landscape`; `--palette-from <picture>` borrows a palette from a picture; `--preview-look <id>` shows a look as resting on it would; `--settle <seconds>` waits before rendering.

## Layout

| Module | Job |
|---|---|
| `Sources/RenderCore` | Metal context and caches, shader prelude (hashing, looping simplex noise, OKLab), palettes, finishing (bloom, grade, vignette, grain, dither), readback and video writing |
| `Sources/BackdropKit` | The 35 analytic looks in 8 families, the backdrop renderer and the shared library |
| `Sources/StageKit` | The shared stage: renderer, scene engine and exporter (Drift and Galileo draw their cards with it) |
| `Sources/StudioKit` | The shared window, stage, transport, inspector controls and export sheet |
| `Sources/BackdropApp` | Backdrop's window, look browser, inspector and entry point |
| `Resources/Icons` | Backdrop's icon |

## Changing Backdrop

Drift and Galileo draw these looks behind their cards and read the same library, so their documents and presets depend on Backdrop staying compatible:

- **Look ids are permanent.** An unknown id draws as Studio, silently. Add looks under new ids; never rename or remove one.
- **A shipped look keeps its pixels.** Drift's and Galileo's presets, documents and sample works use them. Redesign under a new id; only a genuine bug, such as a loop seam, changes an existing look.
- **New stored fields are optional,** with defaults that reproduce today's picture. A required field would stop older documents and library files from opening.
- **The library only grows:** same folder, same files, keys added, never changed.
- **Every look must compile.** All looks compile together at launch, and one error stops Backdrop, Drift and Galileo alike; `scripts/verify.sh` renders every look.
- **Release with Drift and Galileo,** so the new looks reach their pickers and they can draw everything Backdrop saves.

## Rights

Backdrop is released under the GNU AGPL 3.0 (see `LICENSE`); pitch.dog's name and marks are covered by `TRADEMARKS.md`. No fonts are bundled. Soft Bloom follows LUMEN's region structure (MIT, Leonxlnx); simplex noise is from webgl-noise (MIT, Ashima Arts and Stefan Gustavson). See `NOTICES.md`.
