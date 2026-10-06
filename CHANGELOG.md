# Changelog

Notable user-visible changes to Backdrop. Backdrop shares its engine with Drift 2 and Galileo 2, whose repositories record their own changes.

## 2.1.0 — 6 October 2026

**Fixes and speed for 1080 × 1920 work; the looks keep their pixels.**

- **Fixed:** with "Preview a slide" on, the sample slide was written into exported files. Exports are now the background alone.
- **Fixed:** the stage kept playing under the export sheet, slowing the export and moving a Still past the frame on screen. It now holds still.
- The export sheet no longer offers Transparent or motion blur, which do nothing for a background.
- Dunes and Dot Grid no longer show a Motion slider that changed nothing.
- Opens on a new window, ready to go, instead of the Open panel. **⌘E** exports; a **Playback** menu plays, pauses and goes to the start; **⇧⌘R** makes a new variation.
- Exports are named with the look, its palette and its loop length, so two variations never ask to replace each other.
- Undoing a palette choice also forgets it, so switching looks afterwards uses the look's own palette again. Library rename and Trash errors are shown instead of ignored.
- Faster: the stage never renders more pixels than the export has, variation tiles render once a slider rests, PNG frames compress on several cores, and each shader compiles once at launch.
- Ships with Drift 2.4.0 and Galileo 2 3.4.0, which share its engine: their transparent exports now keep shadows and correct alpha.

## 2.0.0 — 5 October 2026

**Six new looks, seamless loops everywhere, and a studio that works like Drift and Galileo.**

- New looks: **Caustics** (sunlight through moving water, dancing on a pool floor), **Iridescence** (a thin film on a slowly folding sheet, held to a pearl sheen), and the gradients: **Solid**, **Linear**, **Radial** and **Conic**, each with a fine grain that keeps slow ramps from banding. 35 looks in all.
- Loop fixes: Frost's drops, Rays' dust and Dot Grid's sweep no longer jump where the loop joins.
- Rest the pointer on a look to audition it on the stage; click to use it. Switching looks keeps a palette you chose yourself.
- **Library**: use, rename or move saved looks to the Trash. Saved looks now keep their film finish and loop length.
- Drift 2.3 and Galileo 2 3.3 ship with the same engine, so the new looks appear among their backgrounds. Update all three together: earlier versions of Drift and Galileo draw a new look from the library as Studio.

## 1.1.0 — 5 October 2026

- Its own repository and releases.
- Scroll with two fingers over the stage to move through the loop, with the trackpad's own momentum; playback carries on when you let go.
- The looks and the engine are unchanged from 1.0.0.

## 1.0.0 — 5 October 2026

**Backdrop: the background studio for Drift 2 and Galileo 2, and a standalone app.**

- 29 analytic looks in 8 families, every one a seamless loop that previews exactly as it exports.
- Palette (including one borrowed from a picture), shape, film and loop-length controls, with variations beside the stage.
- A shared library: looks saved here appear in Drift and Galileo.
- Exports MP4, HEVC, ProRes, numbered PNG frames or a still, in the same shapes as Drift and Galileo, from 9:16 to 4K.
- First shipped alongside Drift 2.0.0 and Galileo 2 3.0.0.
