# Converting CBBE Outfits to Fusion Girl

[Back to BodySlide guides](README.md)

**Document type:** Cross-checked technical guide  
**Last revised:** September 14, 2026  
**Tools:** BodySlide and Outfit Studio, Mod Organizer 2  
**Practical baseline:** Vtaw Kaine Babydoll 1.1 (Dress and Panties)  
**Baseline result:** Converted projects built successfully and validated in game  
**Extended workflow status:** Reference layering and special-case handling are cross-checked against the credited external guides; test every conversion individually

> [!IMPORTANT]
> This guide documents an independent workflow. It does not redistribute conversion templates, body meshes, outfit assets, screenshots, or third-party documentation.
>
> Back up the original project and save the conversion under new project names. Never overwrite the source CBBE BodySlide project.

## Purpose

This procedure converts an existing Fallout 4 CBBE BodySlide project to Fusion Girl while preserving a clean rollback path.

The most important rule is to use the Fusion Girl references for different purposes:

1. **Fusion Girl Nude** is the complete base-body reference.
2. **Fusion Girl Clothes** is an optional specialized reference for selected opaque meshes covering the breasts or genitals.
3. **Fusion Girl Uniboob** is an optional specialized reference for selected tops whose material should remain stretched between the breasts.
4. **Fusion Girl Nude** is loaded again as the final visual reference for slider inspection.

Using Fusion Girl Clothes as the only global reference can hide relevant body morphs and make troubleshooting misleading.

## Requirements

Install and configure the current versions appropriate to your Fallout 4 runtime:

- [BodySlide and Outfit Studio](https://www.nexusmods.com/fallout4/mods/25);
- [Fusion Girl](https://www.nexusmods.com/fallout4/mods/37268);
- a compatible CBBE-to-Fusion-Girl conversion reference;
- the original outfit and its CBBE BodySlide files;
- a mod manager such as Mod Organizer 2;
- NifSkope when inspection of the generated NIF files is required.

One commonly used conversion resource is [CBBE to Fusion Girl Bodyslide Conversion Reference by Bumex](https://www.nexusmods.com/fallout4/mods/37380).

Names, available reference templates, sliders, and menu wording may differ between releases. Check the current descriptions, requirements, file notes, and changelogs before starting.

## Before You Start

1. Confirm that the original CBBE outfit works.
2. Create a dedicated MO2 mod for the conversion, for example:

   ```text
   Outfit Name - Fusion Girl Conversion
   ```

3. Open the original CBBE project and record:

   - Display Name;
   - Output File Name;
   - Output Data Path;
   - Single Weight or Low/High Weight output;
   - Shape Data folder and file;
   - Slider Set file;
   - whether **Copy reference shape into output** is enabled.

4. Keep the original mod and project available for rollback.
5. Start from the untouched CBBE project, not from an earlier conversion attempt.

## 1. Inspect and Preserve Special Bones

Before deleting anything, select the original body reference in the **Meshes** tab and inspect the **Bones** tab.

Bones unused by the body reference may belong to the outfit itself. Typical examples include:

- finger bones used by gloves;
- cloth bones used by skirts or dresses;
- bones used by animated accessories.

If special bones are present:

1. export a backup with **File > Export > To NIF**;
2. keep that NIF as a temporary source;
3. note which outfit shapes use the special bones.

This backup will later be used to restore only the special weights.

## 2. Sanitize the CBBE Project

In the **Meshes** tab, delete only the old body-reference shapes:

- the CBBE body;
- CBBE feet when they are reference-only shapes;
- any other source-body reference.

Do not delete real outfit meshes.

In the **Bones** tab:

1. select all bones;
2. use **Delete > From Project** or **Remove From Project**, depending on the installed version;
3. confirm that the old bone list is empty.

Deleting all bones is intentional, but only after special bones have been identified and backed up.

## 3. Convert the Base Shape

Load the CBBE-to-Fusion-Girl conversion template:

```text
File > Load Reference > From Template
Convert: CBBE to FusionGirl
```

Then:

1. run **Slider > Conform All**;
2. set `CBBEToFusionGirl` to 100%;
3. inspect the outfit for obvious deformation;
4. run **Slider > Set Base Shape**.

The slider returning visually to 0% after setting the base shape is normal. The conversion has been baked into the new base shape.

## 4. Load the Complete Fusion Girl Reference

Load:

```text
Fusion Girl Nude
```

This is the primary body reference. It supplies the complete body shape and slider set needed for the general conversion.

Do not begin with Fusion Girl Clothes as the sole reference.

## 5. Copy Fusion Girl Bone Weights

Select only the outfit meshes, not the green Fusion Girl body reference.

Use:

```text
Shape > Copy Bone Weights
```

A practical starting point is:

```text
Search Radius       = 5
Max Vertex Targets  = 4
No Target Limit     = disabled
```

After copying the weights, run:

```text
Slider > Conform All
```

At this point every applicable outfit mesh should receive the complete Fusion Girl Nude slider behavior.

## 6. Restore Special Bones

Skip this section when the original outfit had no special bones.

For each saved glove, skirt, dress, or accessory shape:

1. load the backup NIF with **Load Reference > From File**;
2. choose the matching source shape;
3. select only its special bones;
4. select the corresponding target outfit mesh;
5. use **Copy Selected Weights**.

Do not copy every old weight back onto the converted outfit. Restore only the weights belonging to the preserved special bones.

## 7. Apply Specialized Clothing References

### Fusion Girl Clothes

Some nipple and genital sliders can deform opaque clothes unnecessarily. Fusion Girl Clothes omits those effects.

When this behavior is wanted:

1. load **Fusion Girl Clothes**;
2. select only opaque meshes covering the breasts and/or genitals;
3. run **Slider > Conform Selected**.

Do not use **Conform All** here.

For transparent clothing, keep the complete Nude behavior and adjust the mesh manually instead of suppressing body-region morphs.

### Fusion Girl Uniboob

Use this optional reference for a top whose material should remain stretched across the space between the breasts:

1. load **Fusion Girl Uniboob**;
2. select only the relevant chest meshes;
3. run **Slider > Conform Selected**.

Uniboob is a specialized overlay, not the global project reference.

## 8. Handle High Heels When Required

For shoes using a compatible `HighHeel` slider:

1. adjust the slider until the feet align with the shoes;
2. inspect the toes, heel, ankle, and sole;
3. when the position is correct, use **Slider > Set Base Shape**;
4. recheck weights and slider behavior.

High-heel projects vary considerably. Treat this as a special case and validate it in game.

## 9. Check for Unweighted Vertices

Attempt to export the project to NIF or use **Save Project As**.

If Outfit Studio reports unweighted vertices:

1. cancel the export or save;
2. select only the affected shape;
3. preserve the mask created by Outfit Studio, or use **Mask Weighted Vertices** to isolate the problem;
4. invert the mask when required so that only the unweighted area receives new weights;
5. copy bone weights again with a wider radius.

Try a radius of 7 or 8 first. Increase it only as needed and inspect the affected area after each attempt. A very large radius can copy weights from unrelated body regions and produce strange movement.

Do not accept an unweighted-vertices warning merely to finish the export.

## 10. Inspect and Correct Slider Behavior

Reload **Fusion Girl Nude** as the final visual body reference.

Move relevant sliders from 0% to 100% while comparing the body and every layer of the outfit. Reset each slider after inspection.

Check at least:

- pregnant, large, and tucked belly shapes;
- breast size, position, width, gravity, and combined breast shapes;
- waist, back, and hip shapes;
- all important butt shapes, individually and in combinations;
- `Legs Chubby` and `Thighs Size`, individually and together;
- broad full-body or athletic morphs;
- nipple and genital morphs for transparent outfits or meshes not conformed to Clothes.

Layered outfits must also be checked for clothing-on-clothing clipping.

### Editing a Slider

When a slider needs correction:

1. click its pencil icon to enter slider-editing mode;
2. select only the affected mesh;
3. use Move, Inflate, Deflate, or Smooth in small increments;
4. exit editing mode;
5. test the slider alone and in combinations.

> [!WARNING]
> Never reshape the mesh while a slider is merely moved and its pencil-editing mode is not active. This can corrupt the slider data.

If one slider produces unusable data on a specific mesh or vertex area:

1. mask everything that must remain unchanged;
2. select only the affected slider;
3. use **Slider > Clear Slider Data**;
4. recreate the intended movement manually in slider-editing mode.

## 11. Diagnose “Ghost Morphs”

If the outfit moves while the displayed body seems static, or if a shape appears to follow an invisible morph:

1. verify that the final reference is **Fusion Girl Nude**;
2. return every slider to zero;
3. reopen the newly saved FG project rather than an intermediate conversion;
4. do not use Fusion Girl Clothes as the only global reference;
5. inspect whether the affected mesh was globally conformed to Nude and only selectively conformed to Clothes or Uniboob;
6. preview the project in BodySlide with morph generation enabled when required;
7. rebuild and test in game.

The **Append new sliders** option only controls whether sliders missing from the current project are added. It cannot correct an inappropriate body reference or a global conform performed with a specialized clothing reference.

## 12. Create Hidden Body Zaps When Appropriate

This section applies when the generated outfit includes its body reference.

For an opaque outfit, hidden body zaps can prevent covered body areas from clipping through the clothing during morphs or physics.

General procedure:

1. display the outfit meshes in wireframe mode;
2. select the body reference;
3. preserve all skin that must remain visible, including a safety margin;
4. create a new zap slider for the fully covered body area;
5. open its properties;
6. enable **Zapped** and **Hidden**;
7. preview the built result carefully.

Do not zap skin that must remain visible through openings or transparent materials.

Hidden body zaps address body-through-clothing clipping. They do not replace proper outfit slider correction.

## 13. Save as a New Fusion Girl Project

Use **File > Save Project As** and create distinct names:

```text
Display Name       : Outfit Name FG
Slider Set File    : OutfitNameFG.osp
Shape Data Folder  : OutfitNameFG
Shape Data File    : OutfitName.nif
```

Preserve the original values required by the game:

- Output File Name;
- Output Data Path;
- weight-output mode.

### Copy Reference Shape Into Output

Match the design of the original outfit rather than applying a universal value.

- Enable it when the outfit must include the body.
- Disable it when the output should contain only the clothing meshes.
- Slot 33 is a useful clue, not an automatic rule.

Inspect the original project and the resulting NIF before deciding.

## 14. Organize the MO2 Output

Outfit Studio may write project files to MO2’s `Overwrite` directory:

```text
Tools\BodySlide\ShapeData\...
Tools\BodySlide\SliderSets\...
Tools\BodySlide\SliderGroups\...
```

Move only the relevant files into the dedicated conversion mod.

Keep together:

- the new `.osp` SliderSet;
- ShapeData `.nif` and `.osd` files;
- optional SliderGroup XML;
- final generated NIF and TRI files.

Before building, ensure that `Overwrite` contains no unrelated files.

## 15. Build and Validate

In BodySlide:

1. select the new FG project;
2. select the intended Fusion Girl preset;
3. enable morph generation when the setup requires TRI files;
4. direct the output to the dedicated MO2 conversion mod;
5. build only the intended FG projects.

In MO2, verify that:

- the conversion wins conflicts against the original CBBE meshes;
- no older BodySlide output overwrites it;
- the output path contains no accidental extra `Data` directory;
- expected NIF and TRI files exist.

Test in game and inspect:

- breasts, belly, waist, hips, butt, thighs, hands, and feet;
- movement and physics;
- high heels and gloves when present;
- transparent materials;
- missing body sections;
- body-through-clothing and clothing-on-clothing clipping;
- LooksMenu or in-game morph behavior.

A clean Outfit Studio preview is not sufficient evidence. The final validation must be performed in game.

## Rollback

If the conversion fails:

1. disable the dedicated FG conversion mod;
2. restore the original CBBE outfit and its previous generated output;
3. confirm that the original outfit still works;
4. reopen the untouched source project;
5. repeat the conversion without reusing intermediate ShapeData.

Because the source project was never overwritten, rollback should remain immediate.

## Common Mistakes

- Deleting bones before checking for finger, cloth, or accessory bones.
- Overwriting the original CBBE project.
- Using Fusion Girl Clothes as the only global body reference.
- Running **Conform All** after loading Clothes or Uniboob.
- Selecting the reference body while copying outfit bone weights.
- Recopying all old weights while restoring special bones.
- Using an excessive bone-weight search radius.
- Checking only one or two sliders.
- Ignoring combinations of extreme sliders.
- Editing geometry without activating the slider pencil.
- Including or excluding the reference body without checking the original project.
- Trusting the preview without an in-game test.

## Credits and Further Reading

This workflow was developed from practical conversion work and cross-checked against the following community resources:

- **GrafPanzer** — [Graf's Guide to Fallout 4 Outfit Conversions, version 1.2](https://www.nexusmods.com/fallout4/mods/50006). This guide informed the staged use of Nude, Clothes, and Uniboob references; preservation of special bones; slider inspection; and hidden body-zap workflow.
- **erri120** — [Converting CBBE To Fusion Girl](https://www.nexusmods.com/fallout4/mods/40555) and its [AGPL-3.0 source repository](https://github.com/erri120/CBBEToFusionGirlGuide). This extensive guide documents the general conversion sequence, slider inspection, clipping correction, zaps, BodySlide organization, and validation.
- **Bumex** — [CBBE to Fusion Girl Bodyslide Conversion Reference](https://www.nexusmods.com/fallout4/mods/37380).
- **ousnius and contributors** — [BodySlide and Outfit Studio](https://github.com/ousnius/BodySlide-and-Outfit-Studio).
- The CBBE, Fusion Girl, and ZeX teams and contributors for their respective body, skeleton, and conversion ecosystems.

GrafPanzer's PDF, screenshots, sample files, and wording are not redistributed here. The erri120 guide remains governed by its AGPL-3.0 license. This document uses independently written instructions and links readers to the original resources for full credit and further detail.

## Publishing Converted Outfits

Publishing this guide does not grant permission to redistribute an outfit conversion.

Before releasing converted meshes or BodySlide files:

1. check the original outfit author's permissions;
2. obtain explicit permission when required;
3. credit the original outfit author and all required body, skeleton, and tool projects;
4. list dependencies accurately;
5. do not bundle third-party assets unless their license or author permits it;
6. document the body version and the conversion's tested scope.

## Support Notice

This is independent community documentation, not official support for BodySlide, CBBE, Fusion Girl, or any credited third-party project.

Body presets, physics configurations, mesh topology, custom bones, and slider sets vary between outfits. Users remain responsible for backups, version checks, permissions, testing, and rollback preparation.
