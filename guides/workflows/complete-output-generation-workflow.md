# Complete Fallout 4 Output Generation Workflow

> **Tested guide — FOLIP 8.x**
>
> Developed on a large Mod Organizer 2 setup derived from Wasteland of Depravity. This is a reproducible workflow, not a universal preset. Check every project's current requirements, file notes and changelog before generating.

## Purpose

Generated patches and LOD assets depend on the active load order. Rebuild them only after the modlist is stable, and never allow an old generated patch to become an input to its own replacement.

Use this order:

1. BodySlide, if outfits or body meshes changed
2. NAFicator, if NAF animations or XML changed
3. Synthesis / Make Items Weightless
4. M8r98a4f2's Complex Item Sorter
5. Check and translate generated plugins
6. FOLIP xEdit Script
7. TexGen
8. xLODGen
9. Final checks and smoke test

## Tested baseline and version scope

The complete procedure was validated on Fallout 4 1.10.163 with MO2 and FOLIP 8.x. At publication time, [Far Object LOD Improvement Project](https://www.nexusmods.com/fallout4/mods/61884) is at version 8.1.

The important generation change was introduced in FOLIP 8.0. Settings and requirements may change in later releases, so tested values must not override the current mod page.

## Before starting

- Finish installations, removals, translations and manual patches.
- Finish outfit conversions.
- Freeze the plugin list and load order.
- Back up both MO2 panes and the active profile.
- Keep recoverable copies of the previous outputs.
- Empty MO2's `Overwrite`.
- Use separate output mods and clean external output directories.
- Close other generators before replacing an output.

Do not add or remove content halfway through the chain.

## What should be rebuilt?

| Change | Rebuild |
|---|---|
| Outfit, body or converted mesh only | BodySlide |
| NAF animation pack or XML | NAFicator |
| Item or plugin content | Synthesis, then Complex Item Sorter |
| Worldspace, placed static, vegetation or LOD resource | FOLIP, TexGen, then xLODGen |
| Major load-order/profile change | Full chain |
| No relevant input changed | Keep the validated output |

Inspect what changed instead of automatically rebuilding everything.

## 1. BodySlide

Run BodySlide first when body or outfit meshes changed.

1. Activate the final body, preset, conversions and outfit sources.
2. Launch BodySlide through MO2.
3. Build into a dedicated output mod.
4. Confirm that no unexpected mesh was written to `Overwrite`.
5. Test representative outfits in game.

It does not need to be repeated after sorter or LOD generation unless a mesh source changes again.

See [Converting CBBE outfits to Fusion Girl](../bodyslide/cbbe-to-fusion-girl.md).

## 2. NAFicator — conditional

Rebuild NAFicator output only after adding, removing or modifying NAF animations or XML.

1. Isolate the previous output and start with an empty `Overwrite`.
2. Enable NAFicator generation mode.
3. Launch Fallout 4 and wait for completion.
4. Exit and move the generated `NAF` directory into a dedicated MO2 output.
5. Disable generation mode for normal play.
6. Test an affected animation.

See [Rebuilding NAFicator output](../animations/naficator-add-remove-animations.md).

## 3. Synthesis / Make Items Weightless

[Synthesis](https://github.com/Mutagen-Modding/Synthesis) runs patchers against the active load order. The tested setup used it to create:

```text
Make Items Weightless.esp
```

1. Keep the output mod available, but move the old generated plugin to MO2's `Optional ESPs`.
2. Launch Synthesis through MO2 and verify the game data path and profile.
3. Run only the intended patcher group.
4. Restore the newly generated plugin.
5. Run a targeted xEdit `Check for Errors`.

If Synthesis reports `Win32Exception (5): Access denied` while starting its temporary .NET runner, check write and execute permissions under:

```text
%LOCALAPPDATA%\Temp\Synthesis
```

Do not also enable Complex Item Sorter's weightless module when Synthesis already handles weights.

## 4. M8r98a4f2's Complex Item Sorter

Run the sorter after Synthesis so it sees the final item state.

1. Move all old `M8r Complex Sorter*.esp` outputs to `Optional ESPs`.
2. Keep the new Synthesis output active.
3. Launch the sorter through MO2.
4. Use `Purge / New` for a clean major rebuild.
5. Select only modules required by the modlist.
6. Keep duplicate functions disabled.
7. Generate into a dedicated output mod.

### Clear caches after major changes

After changing installation, copying a profile or substantially changing the load order, run:

```text
Advanced Options > Clear all caches
```

before `Purge / New`. In the tested rebuild, this removed stale FormIDs and unresolved references inherited from the earlier configuration.

After generation:

- Check every generated plugin in xEdit.
- Determine whether an error is inherited from a source or created by the patch.
- Place sorter outputs after their sources.
- Place intentional post-sorter fixes after the generated outputs.

See the [STEP Complex Item Sorter reference](https://stepmodifications.org/wiki/Fallout4:M8r98a4f2%27s_Complex_Item_Sorter), then follow the current sorter documentation for modules and options.

## 5. Check and translate outputs

Before LOD generation:

1. Check the Synthesis and sorter outputs in xEdit.
2. Investigate unresolved references; do not assume the generator created every reported error.
3. Translate generated strings when using a localized modlist.
4. Confirm that translation changed only intended strings.
5. Freeze the plugin content and load order.

Any later plugin-content change requires repeating the affected stages.

## 6. FOLIP 8.x

### FOLIP 8 removed the second pass

Do **not** run the historical `FOLIP - After Generation` step.

The official FOLIP 8.0 changelog states that the second pass was removed because Addictol now handles the bugs it was designed to fix. Version 8.0.1 also renamed:

```text
FOLIP Before Generation Output.zip
```

to:

```text
FOLIP Output.zip
```

The current chain is:

```text
FOLIP → TexGen → xLODGen
```

An old archive name is not evidence that a second FOLIP pass is required.

### Preparation

1. Install the current compatible FOLIP 8.x files and requirements.
2. Review the current FOLIP page for LOD resources and compatibility files.
3. Keep the `FOLIP Output` mod as a container, but move its previous generated plugins to `Optional ESPs`.
4. Disable the old TexGen and xLODGen output mods.
5. Empty the external TexGen and xLODGen output directories.
6. Confirm that `Overwrite` is clean.
7. Disable xEdit `Simple Records` when required by current FOLIP instructions.

### Generation

1. Launch xEdit through MO2.
2. Load the complete final load order.
3. Select all relevant plugins.
4. Run the current `FOLIP.pas`.
5. Review its options instead of blindly reusing an old preset.
6. Let the script complete without altering MO2.
7. Install `FOLIP Output.zip` as an MO2 mod.
8. Verify its plugins and resources before continuing.

The tested normal pass left `Deep Scan` disabled. It is an advanced compatibility feature that may find inaccurate matches; enable it only for a specific reason.

## 7. TexGen

With the new FOLIP output active:

1. Keep the old TexGen output disabled.
2. Start with a clean external output directory.
3. Launch TexGen through MO2.
4. Choose settings appropriate to the target resolution and modlist.
5. Wait for `TexGen completed successfully`.
6. Replace the dedicated TexGen output mod and activate it.
7. Review file conflicts and `Overwrite`.

A base size of 256 was used for the tested 1440p setup. It is not a universal recommendation.

## 8. xLODGen

With the new FOLIP and TexGen outputs active:

1. Keep the old xLODGen output disabled.
2. Start with a clean external directory.
3. Launch xLODGen through MO2.
4. Review every detected worldspace.
5. Select only worldspaces that need generated LOD.
6. Apply settings appropriate to the modlist and hardware.
7. Generate the required object and terrain LOD.
8. Wait for `LOD generation done`.
9. Replace and activate the dedicated xLODGen output.
10. Check `Overwrite`.

Never copy another modlist's worldspace list blindly. Evaluate mod-added worldspaces individually.

## 9. Final checks

- No missing masters or unexpected MO2 warnings.
- `Overwrite` is empty.
- Generated outputs are active in the intended priority.
- Targeted xEdit checks pass, or inherited errors are understood and documented.
- Both MO2 panes are backed up again.
- The load order remains frozen during testing.

Typical output priority:

```text
FOLIP Output
TexGen Output
xLODGen Output
```

This is file priority, not a universal plugin order.

## 10. Smoke test

Test at least:

- main menu and new-game startup;
- inventory tags, sorting and item weights;
- a rebuilt outfit;
- an affected NAF animation;
- interior/exterior cell transitions;
- heavily modified cities or settlements;
- distant objects and terrain from several viewpoints;
- relevant mod-added worldspaces;
- weather or seasons, if installed;
- save, full exit and reload.

Reaching the main menu is not sufficient validation.

## Rollback

1. Exit the game and all generators.
2. Restore previous output mods and MO2 backups.
3. Identify the first affected stage from the rebuild table.
4. Clean that stage's inputs and output.
5. Rebuild forward from there.
6. Never merge a failed output into the last known-good baseline.

## Credits and references

- **DoubleYou** — author of [Far Object LOD Improvement Project](https://www.nexusmods.com/fallout4/mods/61884) and its FOLIP 8 workflow.
- **Sheson, Ehamloptiran and Zilav** — credited by FOLIP for xLODGen; **Sheson** for TexGen.
- **Mutagen Modding community** — [Synthesis](https://github.com/Mutagen-Modding/Synthesis).
- **M8r98a4f2 and sorter-module authors** — Complex Item Sorter ecosystem.
- **iAmRillie** — thanks for contributing practical generation-workflow knowledge to the Wasteland of Depravity community.
- **Wasteland of Depravity community** — original modlist context from which the tested workflow was adapted.

No third-party binary, archive or documentation is redistributed here.
