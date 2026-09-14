# Rebuilding NAFicator Output After Adding or Removing Animations

[Back to animation tool guides](README.md)

**Document type:** Tested historical procedure  
**Last revised:** September 14, 2026  
**Tested NAFicator version:** 0.1.72  
**Tested runtime:** Fallout 4 1.10.163 / F4SE 0.6.23  
**Mod manager:** Mod Organizer 2  
**Official mod page:** [NAFicator on Nexus Mods](https://www.nexusmods.com/fallout4/mods/88459)  
**Developer source repository:** [Panda Projects — NAFicator source](https://github.com/I-am-Panda-coder/Panda_Projects/tree/master/f4se-plugin/extern/NAFicator)  
**Animation framework:** [Native Animation Framework](https://github.com/Deweh/Native-Animation-Framework)

> [!WARNING]
> This procedure was validated with **NAFicator 0.1.72** on the Fallout 4 OG runtime. The current public source tree identifies itself as a newer 0.9.6 build. Do not assume that file locations, configuration keys, runtime support, or generated-output behavior remain identical in later releases. Read the current mod instructions before running the tool.

## Purpose

NAFicator converts or rebuilds animation XML data for use with Native Animation Framework and the surrounding NAF Bridge workflow.

Installing an animation pack does not guarantee that its animations will become available through an already-generated NAFicator output. The output must be rebuilt whenever the effective animation or XML set changes.

This includes:

- adding an animation pack;
- removing an animation pack;
- updating a pack whose XML data changed;
- adding, removing, or editing compatible XML files;
- changing another component whose generated NAF data depends on that animation set.

It is normally unnecessary after installing only textures, outfits, meshes, voices, or patches that contain no relevant animation XML data.

## Before You Start

1. Confirm that the game and existing NAF setup work before the change.
2. Back up the MO2 left and right panes.
3. Keep the current generated NAFicator output available for rollback.
4. Record the exact names and versions of:
   - NAFicator;
   - NAF;
   - NAF Bridge;
   - the current generated output;
   - every animation pack being added, removed, or updated.
5. Make sure the MO2 `Overwrite` directory contains no unrelated files.

> [!IMPORTANT]
> Do not delete or overwrite the last known-good generated output. Create a separate MO2 output mod for each rebuild until the new result has been validated.

## Add or Remove the Animation Files First

Before rebuilding:

- install and enable every animation pack or XML file that must be included;
- disable or remove from the active MO2 profile every animation pack or XML file that must disappear;
- finish all planned animation changes before running NAFicator.

For removal, merely uninstalling the animation pack is not sufficient if an older generated output still contains data derived from it. The old output must be disabled while the clean output is rebuilt.

## Rebuild Procedure

1. Disable the currently active generated NAFicator output.
2. Enable the NAFicator mod in the MO2 left pane.
3. In the tested 0.1.72 configuration, set:

   ```ini
   bNaficatorEnable=1
   ```

4. Confirm that `Overwrite` is empty.
5. Launch Fallout 4 through the same MO2 profile.
6. Wait for the NAFicator completion message. Do not close the game while generation is still running.
7. Exit Fallout 4 completely.
8. Inspect `Overwrite` and locate the newly generated `NAF` folder.
9. Create a separate MO2 mod from the generated files, for example:

   ```text
   [No Delete] - Custom NAFicator Output
   ```

10. Check the directory level. The output mod must expose the generated `NAF` directory at the level expected by the installed toolchain, without an accidental extra `Data` directory.
11. Clear `Overwrite` after the output mod has been created.
12. Disable NAFicator for normal gameplay.
13. In the tested 0.1.72 configuration, restore:

   ```ini
   bNaficatorEnable=0
   ```

14. Keep the previous generated output disabled.
15. Enable only the newly generated output.
16. Launch the game and validate the changed animation set.

Depending on the packaging and configuration of another NAFicator release, the generated destination may be controlled by its INI rather than appearing exactly as described above. Follow the documentation shipped with that release.

## Validation

After adding animations, verify that:

- at least one newly added animation can be selected or triggered;
- the intended actors and furniture types work;
- NAF scenes start and end normally;
- no required animation is unexpectedly missing;
- no old generated output wins file conflicts in MO2.

After removing animations, verify that:

- the removed animation entries no longer appear;
- scenes do not attempt to call removed XML data;
- remaining animations still work;
- no stale generated output reintroduces the removed data.

For every rebuild, also confirm that:

- NAFicator is disabled during normal gameplay;
- only one intended generated output is active;
- `Overwrite` is empty;
- no unexpected files were mixed into the output mod.

## Tested Result

The historical Wasteland of Depravity working profile produced **12 XML files** in a dedicated MO2 output. NAFicator was then disabled, the new output was enabled, and the animation stack was validated in game.

This is evidence for the stated profile and versions only. It is not a universal expected file count.

## Rollback

If the new output causes missing animations, failed scenes, or other regressions:

1. close Fallout 4 and MO2;
2. disable the new output;
3. restore the previously working animation packs and XML files;
4. re-enable the last known-good generated output;
5. keep NAFicator disabled;
6. repeat the original baseline test.

## Common Mistakes

- Leaving the old generated output active during rebuilding.
- Running NAFicator before all animation changes are complete.
- Forgetting to rebuild after removing an animation pack.
- Mixing unrelated files into `Overwrite`.
- Creating the MO2 output mod with an extra `Data` directory.
- Leaving NAFicator enabled during ordinary gameplay.
- Deleting the only working output before testing the replacement.
- Treating the historical count of 12 XML files as a universal target.

## Sharing and Support Notice

This independent community guide describes a procedure tested on a personal setup. It is not official NAFicator, NAF, NAF Bridge, or Wasteland of Depravity documentation.

No third-party binaries, XML files, animation assets, or copied documentation are redistributed here. Users remain responsible for version checks, backups, testing, and rollback preparation. No personalized installation support is guaranteed.
