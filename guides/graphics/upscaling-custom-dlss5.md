# Fallout 4 — Upscaling Custom with DLSS Neural Rendering

> **Tested guide** — practical setup validated on Fallout 4 OldGen with an RTX 4070, F4SE, LooksMenu, NAF, ENB and ReShade.
>
> The goal of this guide is to document a clean **Upscaling Custom** stack for DLSS Super Resolution, Frame Generation, NVIDIA Reflex and DLSS Neural Rendering without layering older RenoDX DLSS5 add-ons on top of ReShade.

---

## 1. Tested environment

The configuration used for validation was:

- **Fallout 4**: OldGen 1.10.163
- **F4SE**: 0.6.23
- **GPU**: NVIDIA GeForce RTX 4070 12 GB
- **NVIDIA driver**: 616.92 WHQL
- **Mod manager**: Mod Organizer 2
- **Upscaler**: Upscaling Custom
- **LooksMenu / F4EE**: enabled
- **f4ee-patched**: detours build enabled
- **NAF + NAF Bridge**: enabled
- **ENB**: enabled
- **ReShade**: enabled as a normal post-processing layer
- **Test resolution**: 1920 × 1080

Validation was intentionally performed in a heavily modified settlement area with a high mesh/object load, followed by repeated animation-framework tests and a full save / quit / relaunch / reload cycle.

---

## 2. Required and recommended components

### Upscaling Custom

https://www.nexusmods.com/fallout4/mods/108772

Upscaling Custom is a custom version of doodlum's Upscaling project. It provides DLSS / FSR upscaling, Frame Generation, NVIDIA Reflex and DLSS Neural Rendering support.

### F4SE Menu Framework

https://www.nexusmods.com/fallout4/mods/105090

Upscaling Custom is configured through **F4SE Menu Framework**. The regular MCM page is not used for Upscaling Custom settings.

### Address Library for F4SE Plugins

Required by the F4SE plugin stack.

### Motion Vector Fixes

https://www.nexusmods.com/fallout4/mods/98544

This fixes rendering bugs affecting temporal techniques such as TAA, upscaling and frame generation.

### Flutter Flicker Fixer For Foliage

https://www.nexusmods.com/fallout4/mods/79853

Use the correct download for **your own modpack**:

```text
PRP version     -> if your current setup actually uses Previsibines Repair Pack
Vanilla version -> if your current setup does not use Previsibines Repair Pack
```

The test environment documented in this guide used the **Vanilla** version because the actual **Previsibines Repair Pack had been removed from that NORA profile**. Another optimization or compatibility patch may still contain `PRP` in its file or mod name, but that alone does **not** mean the full Previsibines Repair Pack is active.

Choose this requirement according to the real state of **your own load order**, not according to the tested profile and not merely because another mod happens to contain `PRP` in its name.

### This Made My Spline Stiff

https://www.nexusmods.com/fallout4/mods/98935

This prevents wind-driven spline motion such as power lines, removing another source of unstable temporal motion.

---

## 3. Do not stack old upscalers and frame generators

Before testing Upscaling Custom, disable or remove other upscalers / frame generators that hook the same rendering path.

For the tested setup, the following older test components were **not active**:

```text
original Upscaling
original Frame Generation mod
dlss5-bridge.addon64
renodx-dlss5.addon64
renodx-dlss.addon64
renodx-dlss5-performance-fix.addon64
OptiScaler
```

ReShade itself may remain installed, but it should be used as a normal post-processing layer rather than as a host for an older DLSS5 injection stack.

The Upscaling Custom author also recommends disabling NVIDIA Smooth Motion.

---

## 4. Suggested MO2 organization

The exact separators are personal preference, but the logical arrangement used for testing was:

```text
Essentials
  F4SE Menu Framework
  Mod Configuration Menu

Upscaler
  Upscaling                  [disabled]
  Upscaling Custom           [enabled]

Frame Gen / temporal fixes
  Frame Generation           [disabled]
  Motion Vector Fixes        [enabled]
  Flutter Flicker Fixer      [enabled]
  This Made My Spline Stiff  [enabled]
```

### F4SE Menu Framework vs MCM file conflicts

In this setup, **F4SE Menu Framework was placed above Mod Configuration Menu** in the MO2 left pane so the regular MCM package won the shared script conflicts:

```text
Scripts\MCM.pex
Scripts\Source\User\MCM.psc
```

This arrangement worked correctly with the tested profile.

---

## 5. First launch: establish a clean baseline

Do not enable every feature at once.

Start with:

```text
Upscaling Method : NVIDIA DLSS
Quality Mode      : Quality
Frame Generation  : Disabled
DLSS NR           : Disabled
```

Launch through F4SE, load a known-good save and verify:

- the game loads without a CTD;
- F4SE Menu Framework appears;
- the Upscaling Custom page is available;
- DLSS Quality works normally;
- image output is stable.

Once that baseline is confirmed, enable Neural Rendering and Frame Generation separately.

---

## 6. Hot configuration through F4SE Menu Framework

One of the major practical advantages of this setup is that Upscaling Custom settings can be changed **in-game** through F4SE Menu Framework.

The tested build applied the relevant quality / NR settings successfully without requiring a full game restart.

This makes visual tuning much easier: use one controlled change at a time, close the menu, inspect the same scene, then continue.

---

## 7. Tested settings

The following settings passed the stability tests described later in this guide.

### Super Resolution

```text
Upscaling Method  : NVIDIA DLSS
Quality Mode       : Quality
Sharpness          : 0.20
DLSS Model Preset  : K
```

`Recommended` is also a sensible baseline. A forced model preset should only be kept if it has been visually tested on the target resolution and quality mode.

### Frame Generation / Reflex

```text
Frame Generation        : Auto
Generated Frames        : 1 (2x)
Dynamic Multi Frame Gen : On
NVIDIA Reflex           : On
Output FPS Limit        : 90
```

Hardware-accelerated GPU Scheduling is required for Frame Generation.

### DLSS Neural Rendering

```text
DLSS Neural Rendering    : On
Position                 : Before SR
NR Passes                : 1
NR Style                 : Cinematic
NR Intensity             : 0.50
Local Tone Strength      : 1.00
Local Structure Strength : 1.00
Automatic Mask           : On
Skin Structure Strength  : 1.00
```

These values are a tested baseline, not universal visual recommendations.

---

## 8. Example `Upscaling.ini`

After the successful test, the plugin persisted the selected values into `Upscaling.ini`.

Example:

```ini
[Settings]
iUpscaleMethodPreference = 2
iQualityMode = 1
fSharpness = 0.200000
iFrameGenerationMode = 2
iDLSSGGeneratedFrames = 0
bDynamicMFGEnabled = 1
iReflexMode = 1
iDLSSModelPreset = 2

[DLSSNR]
iPosition = 0
bEnabled = 1
iPassCount = 1
iStyle = 2
fIntensity = 0.500000
fLocalToneStrength = 1.000000
fLocalStructureStrength = 1.000000
bUseAutoMask = 1
fSkinStructureStrength = 1.000000

[Presentation]
iVSyncMode = 0
iOutputFPSLimit = 90
```

Do **not** assume the numeric values will always map to the same UI labels in future releases. Check the actual in-game menu after updating the mod.

---

## 9. ReShade tuning with Neural Rendering

A ReShade preset tuned for a different upscaler may become too aggressive after switching to Neural Rendering.

In the tested setup, the existing preset produced excessive micro-contrast and an engraved / over-sharpened look.

The first successful adjustments were:

```text
CAS            : Off
LumaSharpen     : 0.350
LocalContrast   : reduced to 40
Curves          : 0.350
```

The important lesson is not the exact values. It is the tuning method:

1. disable duplicate sharpening first;
2. reduce local contrast before reducing overall detail;
3. inspect skin, hair, wood, stone, foliage and thin geometry;
4. compare interiors and exteriors;
5. change one parameter at a time.

Neural Rendering already adds structure and detail. Layering several sharpening techniques on top can make the result look artificial very quickly.

---

## 10. Stability validation

The final stack was tested beyond a simple menu launch.

### Runtime test

Five consecutive NAF scenes were run with:

- DLSS Quality enabled;
- DLSS Neural Rendering enabled;
- Frame Generation enabled;
- Dynamic MFG enabled;
- Reflex enabled.

Observed result:

```text
Player body morph stability : OK
Actor morph state           : OK
Animation framework         : OK
Immediate CTD               : none
```

### Save / reload test

After the runtime test:

1. a new save was created;
2. Fallout 4 was fully closed;
3. the game was relaunched through F4SE;
4. the new save was loaded;
5. Upscaling Custom settings were checked again.

Observed result:

```text
Save creation               : OK
Full game restart           : OK
Save reload                 : OK
Upscaling settings restored : OK
CTD                          : none
MO2 Overwrite               : empty
```

This is a much stronger validation than simply confirming that the menu appears or that a single save loads once.

---

## 11. Why save testing matters with LooksMenu / F4EE

During earlier experiments with a different generic DLSS5 / RenoDX injection stack, the player body could enter an incorrect morph state during animation-framework scenes.

Later, several saves would CTD when loaded with their F4SE co-save present. The same `.fos` could load after temporarily removing its `.f4se` co-save, but the player body state was then incorrect.

That pointed strongly toward serialized F4SE / LooksMenu state rather than a damaged base `.fos` alone.

A manual reset of the player's LooksMenu body state followed by a fresh save restored reliable loading.

### Practical lesson

Before testing a new rendering hook, upscaler or Neural Rendering path on a heavily modded game:

- keep a known-good reference save;
- use dedicated test saves;
- test body / overlay / morph-heavy systems if your load order uses them;
- fully quit the game before the final reload test;
- do not overwrite your last known-good save until the new stack survives that cycle.

This does **not** prove that a graphics add-on directly writes LooksMenu data. It does show why cross-system stability tests matter in complex F4SE setups.

---

## 12. Additional compatibility notes

### Borderless mode

The Upscaling Custom author recommends running the game in borderless window mode:

```ini
bBorderless=1
bFull Screen=0
```

### NVIDIA Smooth Motion

Disable it. It can interfere with DX11 hooks and ImGui-style overlays.

### NAF Bridge and f4ee-patched

The Upscaling Custom author notes that an older NAF Bridge can conflict with `f4ee-patched` and prevent F4SE Menu Framework from appearing. Update NAF Bridge if the menu is missing in a setup that uses both.

### NVIDIA driver

DLSS Neural Rendering requires a sufficiently recent NVIDIA driver. The tested RTX 4070 configuration used **616.92 WHQL**.

### Frame Generation

Hardware-accelerated GPU Scheduling must be enabled for Frame Generation.

---

## 13. Troubleshooting checklist

### F4SE Menu Framework does not appear

Check:

```text
F4SE version
Address Library
F4SE Menu Framework installation
NAF Bridge version if using f4ee-patched
NVIDIA Smooth Motion disabled
```

### Upscaling Custom page appears but settings do not behave as expected

Confirm that the original `Upscaling` and other frame-generation injectors are not still enabled.

### Visual output looks over-sharpened

Temporarily disable ReShade CAS / sharpening effects and retest before changing Neural Rendering itself.

### Foliage flickers badly

Confirm that Motion Vector Fixes and the correct Flutter Flicker Fixer variant are installed.

### A new save suddenly fails to reload

Do not immediately overwrite additional saves. Return to a known-good save and test whether the issue follows the new rendering stack, the F4SE co-save, or a separate gameplay/plugin state change.

---

## 14. Final tested stack

### Enabled

```text
F4SE Menu Framework
Address Library for F4SE Plugins
Motion Vector Fixes
Flutter Flicker Fixer For Foliage
This Made My Spline Stiff
Upscaling Custom
```

### Disabled / not stacked

```text
original Upscaling
original Frame Generation mod
older RenoDX DLSS5 add-ons
ShortFuse DLSS add-on
DLSS5 Performance Fix add-on
OptiScaler test stack
NVIDIA Smooth Motion
```

### Validation status

```text
DLSS Quality                : PASS
DLSS Neural Rendering       : PASS
Frame Generation            : PASS
Dynamic MFG                 : PASS
NVIDIA Reflex               : PASS
Hot configuration           : PASS
Repeated NAF scenes         : PASS
Player body morph stability : PASS
Save creation               : PASS
Full restart + reload       : PASS
```

---

## 15. Conclusion

On the tested Fallout 4 OldGen / RTX 4070 setup, **Upscaling Custom provided the cleanest and most stable DLSS Neural Rendering path tested so far**.

Its main advantage was architectural simplicity: DLSS SR, FG, Reflex and Neural Rendering were handled by the upscaler itself instead of requiring a separate generic RenoDX / ReShade bridge stack.

The tested profile remained stable across repeated animation-framework scenes and a full save / restart / reload cycle.

Treat the values in this guide as a **validated starting point**, not a universal preset. Keep rollback saves, verify requirements against the current mod page, and retest after every major Upscaling Custom update.

---

## Credits / third-party projects

This guide does not redistribute any third-party binaries or assets.

Projects referenced here include Upscaling Custom, the original Upscaling project, F4SE Menu Framework, Motion Vector Fixes, Flutter Flicker Fixer For Foliage, This Made My Spline Stiff, F4SE, Address Library, NVIDIA DLSS / Streamline technologies, ReShade, ENB, LooksMenu and NAF.

All project names and assets belong to their respective authors.
