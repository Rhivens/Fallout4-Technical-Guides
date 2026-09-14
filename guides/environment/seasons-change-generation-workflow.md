# Integrating Seasons Change into a Fallout 4 Generation Workflow

> **Tested guide — Seasons Change 3.0**
>
> This procedure records a configuration tested on Fallout 4 1.10.163 with Mod Organizer 2, NAC, True Grass, FOLIP 8.x, TexGen and xLODGen. It includes configuration-specific troubleshooting and must not be treated as a universal compatibility patch.

## Scope and version notes

[Seasons Change - A Merry Modding Days Mod](https://www.nexusmods.com/fallout4/mods/76710) by DoubleYou adds dynamic seasonal trees, grass, weather and optional winter snow.

The tested setup used:

- Seasons Change main file version **3.0**
- `Seasons.esm`
- optional winter snow through `Seasonal Snow.esl`
- the Seasons xEdit integration script
- NAC as the active weather overhaul
- True Grass
- custom compatibility patches described below

The following optional downloads were **not used or validated** in this setup:

- the version 3.1 wind-movement fix for tree branches
- `Vivid Weathers Patch`
- `Seasons Change - Garden of Eden Scripts`

At publication time, Nexus identifies the project as version 3.1. The 3.1 download is described as a fix for wind movement of tree branches to prevent flickering and blurring and is installed in addition to the main file. Users should check the current Files tab and changelog rather than assuming this tested 3.0 configuration is still the newest combination.

## Requirements and installation

Version 3.0 introduced a FOMOD installer and seasonal grass. Its current requirements include:

- all Fallout 4 DLC listed on the mod page
- Console Util for seasonal grass updates
- Mod Configuration Menu as a soft requirement for its MCM controls

Install the mod through the mod manager and make deliberate FOMOD choices for texture resolution, snow and compatibility options.

The author's general load-order guidance places Seasons high enough that later compatibility and weather plugins can intentionally override it. If winter snow is enabled:

```text
Seasons.esm
Seasonal Snow.esl
```

`Seasonal Snow.esl` must load after `Seasons.esm`. It is optional and can be disabled if winter snow is not wanted.

Do not install optional weather integrations for weather mods that are not present in the setup.

## Weather integration

Seasons Change 3.0 includes seasonal weather, including winter snowstorms. A later weather overhaul can override those weather records.

The tested configuration used NAC. The Seasons author states that NAC X has its own seasonal weather and may override Seasons without a direct conflict. Nevertheless, inspect the actual winning records in xEdit because a large modlist may add further overrides.

Do not assume that a clean plugin load means the intended weather behavior is winning.

## Generate the Seasons compatibility patch

The included xEdit script dynamically builds integration data against the active load order and is intended for advanced users.

Before running it:

1. Finish installing all mods that add or modify worldspaces, trees, grass, settlements, locations or weather.
2. Resolve known plugin conflicts.
3. Back up the MO2 profile.
4. Disable or isolate the previous generated `Seasons - Patch.esp`.
5. Start with a clean MO2 `Overwrite`.
6. Verify the xEdit path used by `Seasons.bat`.

Then:

1. Configure `Seasons.bat` so its **Start in** directory points to the xEdit installation directory.
2. Launch `Seasons.bat` through the intended modding environment.
3. Allow the script to finish and close normally.
4. Install the generated output as a dedicated MO2 mod.
5. Activate the new `Seasons - Patch.esp`.
6. Run a targeted xEdit `Check for Errors`.
7. Inspect conflicts against vegetation, weather, settlement and location overhauls.
8. Do not begin LOD generation until the Seasons output and all compatibility patches are final.

The mod page explicitly requires regenerating LOD after running the Seasons script.

## Position in the complete generation workflow

Seasons is an **input** to the final generation chain, not an output to add afterward.

Use this order:

1. Install Seasons Change and its selected options.
2. Install all worldspace, vegetation, weather, settlement and location mods.
3. Run the Seasons xEdit script.
4. Validate `Seasons - Patch.esp`.
5. Create and validate any required compatibility patches.
6. Freeze the load order.
7. Run conditional BodySlide and NAFicator stages if their inputs changed.
8. Run Synthesis and Complex Item Sorter when plugin or item inputs require them.
9. Run **FOLIP**.
10. Run **TexGen**.
11. Run **xLODGen**.
12. Perform seasonal smoke tests.

The essential downstream chain is:

```text
Seasons and compatibility patches
                    ↓
                  FOLIP
                    ↓
                  TexGen
                    ↓
                 xLODGen
```

If a Seasons tree mesh, LOD model, worldspace record or related compatibility patch changes later, rebuild at least:

```text
FOLIP → TexGen → xLODGen
```

See the [complete output generation workflow](../workflows/complete-output-generation-workflow.md).

## Compatibility case study: True Grass, NAC and Seasons

### Observed problem

In the tested setup, True Grass won several records that were needed for the intended Seasons/NAC behavior.

For records `Shared01` through `Shared03`, the relevant chain was primarily Seasons followed by NAC. Other inspected records generally needed NAC to remain the winner except for deliberate seasonal values.

### Resolution

A small custom patch was created to forward only the required values and prevent True Grass from unintentionally replacing them.

The patch was:

- deliberately minimal
- flagged ESL
- placed low enough in the plugin order to win
- validated with xEdit `Check for Errors: 0`
- tested for expected seasonal grass behavior, including winter

### Do not copy this blindly

This conflict depends on the installed versions, grass mod, weather system and load order. Inspect each relevant record and forward only the values required by the actual setup.

A large copied override is more likely to erase valid changes from another mod.

## Troubleshooting case study: broken Maple trees near Nuka-World

### Symptoms

Several Maple trees in the forest near Nuka-World produced very large black or colored triangles and stretched geometric planes. Some areas became difficult to see through.

The defect:

- did not appear around Sanctuary or Concord
- disappeared when the Seasons/FOLIP block was disabled
- remained after disabling the general custom Seasons/NAC/True Grass patch

This isolated the problem from the general compatibility patch.

### Diagnosis

The affected references all used the same seasonal base object:

```text
TreeMaplePrewar06_Seasons [STAT:192E0E2A]
```

Its model was:

```text
Landscape\Trees\Prewar\TreeMaplePrewar06_Seasons.nif
```

The seasonal reference system itself was working. Inspected summer and autumn references used matching positions and rotations with different seasonal `Enable Parent` records. The problem was therefore not four seasonal copies being simultaneously enabled.

### Tested fix for the 3.0 setup

A dedicated plugin was created:

```text
Seasons-NukaWorld-Tree-Fix.esp
```

Instead of overriding every placed reference, it contained a single override of `STAT:192E0E2A`. The broken model and LOD paths were replaced with those of the healthy vanilla Maple:

```text
TreeMaplePreWar06Gr [STAT:00061643]
```

Paths used:

```text
Model
Landscape\Trees\Chargen\TreeMaplePreWar06Green.nif

LOD #0
LOD\Landscape\Trees\Chargen\TreeMaplePW06Gr_LOD_0.nif

LOD #1
LOD\Landscape\Trees\Chargen\TreeMaplePW06Gr_LOD_1.nif

LOD #2
LOD\Landscape\Trees\Chargen\TreeMaplePW06Gr_LOD_2.nif

LOD #3
LOD\Landscape\Trees\Chargen\TreeMaplePW06Gr_LOD_2.nif
```

All other seasonal record data was preserved, including the seasonal reference system, `Enable Parent` behavior and material swaps.

The plugin was placed as a late patch after the Seasons/FOLIP-related plugins in the right MO2 pane, then included before final LOD regeneration.

### Validation

The forest near Nuka-World was retested with:

- summer: passed
- autumn: passed
- winter: passed
- no further stretched geometry observed

The fix trades some of that Maple model's specific seasonal appearance for a stable vanilla mesh.

### Version warning

This fix was developed for the tested Seasons Change 3.0 setup. Version 3.1 provides a separate tree-branch wind fix. Do not install this custom override automatically on 3.1.

First test without it. Apply or recreate a targeted patch only if the same base object and mesh defect are confirmed.

## Known limitation: snow inside mod-added buildings

During winter, snow may appear on floors inside houses or sheltered structures added or rebuilt by settlement and location-overhaul mods. This was particularly visible with modified Sanctuary buildings.

These structures may visually look like interiors while still belonging to an exterior worldspace. Their surfaces can therefore be treated as outdoor geometry by the seasonal snow system.

This is usually a compatibility limitation between snow coverage and the affected building mod. It is not, by itself, evidence that FOLIP, TexGen or xLODGen failed.

If this occurs:

1. Identify the building or location overhaul responsible.
2. Check whether the affected structure remains in an exterior cell.
3. Test without the overhaul if practical.
4. Do not repeatedly regenerate LOD expecting the floor snow to disappear.
5. Accept the visual limitation or create a targeted compatibility patch for the affected surfaces.

The Seasons mod page also documents general snow limitations, including transparency issues, occasional z-fighting, low-poly surfaces becoming more visible and a brief application flash after cell changes.

## Final seasonal smoke test

Test more than one location and force or wait for multiple seasons.

Check at least:

- spring, summer, autumn and winter tree variants
- seasonal grass density and color
- winter snow activation
- NAC or the selected weather overhaul
- Sanctuary and other modified settlements
- Diamond City and Goodneighbor surroundings
- Nuka-World trees
- mod-added buildings and sheltered exterior structures
- distant object and terrain transitions
- save, full exit and reload
- an interior-to-exterior transition

For winter snow that fails to refresh, use the mod's MCM snow-fix function before assuming the generated LOD is broken.

## Rollback

Keep separate backups of:

- the previous `Seasons - Patch.esp`
- custom compatibility patches
- FOLIP output
- TexGen output
- xLODGen output
- MO2 profile and plugin order

If a new Seasons build fails, restore the entire matching set. Do not combine an older Seasons patch with newer LOD outputs unless that combination has been deliberately validated.

## Credits and references

- **DoubleYou** — author of [Seasons Change - A Merry Modding Days Mod](https://www.nexusmods.com/fallout4/mods/76710).
- **ElminsterAU and the xEdit team** — xEdit and tooling credited by the mod author.
- **Sheson** — xLODGen and TexGen.
- **Neanka, reg2k and shadowslasher410** — Mod Configuration Menu.
- **BadDogSkyrim and contributors** — PyNifly.
- The remaining project credits are listed on the Seasons Change Nexus page and remain the authoritative credit record.

This guide contains original procedural notes from practical testing. It does not redistribute Seasons Change files, scripts, assets or documentation.
