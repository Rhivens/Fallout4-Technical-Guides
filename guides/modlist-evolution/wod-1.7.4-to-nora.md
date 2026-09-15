# From Wasteland of Depravity 1.7.4 to NORA

> **Modlist evolution case study — snapshot dated September 7, 2026**
>
> This document compares the Mod Organizer 2 left pane of a Wasteland of Depravity 1.7.4 base with a heavily customized NORA/Eleanor setup. Only meaningful differences are listed.

## Purpose

This is not an official Wasteland of Depravity update, a replacement modlist, or a ready-to-install recipe.

It is a practical example of how far a WoD 1.7.4 installation can be adapted while keeping WoD as its foundation. The result adds Nuka Ride, MSMA, Addictol, expanded NAF content, location overhauls, dynamic seasons, custom patches and isolated generated outputs.

The value of this comparison is architectural: it shows what kinds of changes are possible, what was replaced, what was deliberately disabled, and where custom compatibility work became necessary.

## Reading the tables

| Status | Meaning |
|---|---|
| Added | Not present in the WoD 1.7.4 baseline |
| Updated | A newer release replaced the baseline or an earlier NORA release |
| Replaced | Another component now performs the intended function |
| Disabled | Still installed in MO2 but not active in NORA |
| Removed | No longer present in the NORA branch |
| Custom patch | Locally created compatibility or behavior patch |
| Generated output | Files produced specifically for this load order |

A disabled entry is not a recommendation to disable it in another setup. Some choices are mutually dependent and only make sense as part of the complete NORA architecture.

## High-level changes

The NORA branch evolved WoD 1.7.4 in six main directions:

1. replacing parts of the crash-fix and runtime stack with Addictol;
2. extending NAF, Nuka Ride and MSMA gameplay;
3. rebuilding major locations without PRP/Rebuild AIO;
4. adding dynamic seasons and regenerating all relevant LOD;
5. creating local FaceGen, outfit, MCM and gameplay patches;
6. isolating every generated tool output instead of allowing it to accumulate in MO2's `Overwrite`.

## Runtime, stability and utility stack

| Component | NORA status | Reason or role |
|---|---|---|
| Long Save Bug Fix | Disabled | Kept in MO2 but inactive |
| Baka MaxPapyrusOps | Disabled | Kept in MO2 but inactive |
| Mentats - F4SE | Disabled | Kept in MO2 but inactive |
| Mentats - WoD Config | Disabled | Legacy configuration retained |
| X-Cell | Disabled/replaced | Functionally replaced by Addictol in this setup |
| X-Cell - WoD Config | Disabled | Legacy configuration retained |
| Buffout 4 | Disabled | Original WoD component retained but inactive |
| Buffout 4 - WoD Config | Disabled | Original configuration retained |
| Daytripper 4 | Replaced | Replaced by Addictol |
| Daytripper 4 - WoD Config | Disabled | Legacy configuration retained |
| Buffout and X-Cell - New WoD Configs | Disabled | Not used with the selected Addictol stack |
| Addictol 1.5.2 | Added | Selected runtime and stability layer |
| Addictol Crash Logger | Added | Matching crash-logging component |
| Shadow Boost FO4 | Disabled | Installed but inactive |
| Long Loading Times Fix | Disabled | Installed but inactive |
| Disk Cache Enabler | Disabled | Installed but inactive |
| Fallout 4 Upscaler | Disabled | Earlier upscaling solution retained in reserve |
| DLAA | Disabled | Earlier configuration retained |
| Frame Generation | Disabled | Installed but inactive |
| Motion Vector Fixes | Disabled | Installed but inactive |
| Faster Decompression | Added | Performance utility |
| Pip-Boy Light Detection Fix - F4SE | Added | Targeted fix |
| Tint Fix | Added | Complements the Rusty Face Fix stack |
| F4SE ChangeHeadPart Fix | Retained/moved | Still active in NORA |

Addictol was not simply added on top of every older crash and memory component. It replaced a selected group, and the corresponding legacy configurations were disabled to avoid overlapping responsibilities.

See:

- [Installing Addictol 1.5.2 in WoD](../addictol/wasteland-of-depravity.md)
- [Generic Addictol integration checklist](../addictol/generic-integration-checklist.md)

## Interface and quality-of-life additions

| Component | NORA status | Role |
|---|---|---|
| Quick User Saves | Added | Replaced Save Hot Key - ArchMod |
| Base Object Swapper | Added | Framework utility |
| Auto Gamepad Switch | Added | Input convenience |
| ESC to Menu Close | Added | Menu QoL |
| ImGui Fonts | Added | Interface dependency |
| Cell Offset Generator | Added | Utility |
| Scroll Zoom | Added | Interface QoL |
| NPCs Don't Move In Dialogue | Added | Dialogue behavior fix |
| HoloTime - HUD Clock Widget | Added | HUD convenience |
| Lamplighter - Useable Lanterns | Added | Lighting/gameplay |
| Tactical Flashlights | Added | Lighting/gameplay |

## Adult gameplay, animation and body systems

| Component | NORA status | Role |
|---|---|---|
| Devious Devices 2.0 RC9 Beta 2 Hotfix | Added/updated | Current Devious Devices stack |
| DDRC9BS (FG conversion) | Added | Fusion Girl conversion |
| DDRC9FGFix | Added | Fusion Girl correction |
| Autonomy Sex | Replaced/evolved | Replaced the older AAF Autonomy Enhanced Redux choice |
| Immersive Lovers Embrace Remastered AAF Patch | Added | Gameplay integration |
| ILER (AAF) Magnolia | Added | Immersive Lovers Embrace extension |
| Indecent Captivity | Added | Gameplay |
| Animated Tentacles The Walking Dongs 1.592 | Added | Animation/gameplay |
| Hot Pockets | Added | Gameplay |
| Sex Attributes Arousal Helper | Added | Sex Attributes extension |
| PotC Morph Plus | Added | Additional morph support |
| Expand Holes | Added | Additional morph support |
| Expand Holes - PotC Patch | Added | Compatibility patch |
| NORA Dangerous Nights - NAF | Added | Locally developed NAF mod |

The NORA branch expanded NAF-related content and therefore required controlled NAFicator rebuilds rather than copying a stale animation cache.

See [Rebuilding NAFicator after animation changes](../animations/naficator-add-remove-animations.md).

## Nuka Ride and MSMA

| Component | NORA status | Note |
|---|---|---|
| Nuka Ride 7.1.4 | Added/updated | Active Nora route baseline in this snapshot |
| Nuka Ride 7.1.3c | Disabled | Previous release retained for rollback |
| Nuka Ride 7 - FaceGen 1.6 | Updated | Replaced FaceGen 1.5 |
| Nuka Ride 7 - Voices 1.7 | Updated | Replaced Voices 1.5 |
| Nuka Ride 7 - BodySlide Fusion Girl 1.4 | Added | Nuka Ride outfit generation |
| NAF Check Patch for 7.1.4 | Custom/temporary patch | Compatibility fix for the active release |
| MSMA Stable 13.4 | Added/updated | Active MSMA release in this snapshot |
| MSMA Stable 13.1 | Disabled | Previous release retained for rollback |
| Scripted Face Tints 1.3.2 | Updated | Replaced 1.3.1 |
| SFT HiPoly Redux patch (Fusion Girl Seamless) | Added | HiPoly/Fusion Girl compatibility |
| Captive Tattoos 4.2 | Updated | Active tattoo framework/content baseline |

Nuka Ride and MSMA were introduced through a dedicated Pre-War MO2 profile, a transferred save pair, late MSMA initialization and deliberate Nora/Norita route handling.

See:

- [Controlled Pre-War profile and late MSMA initialization](../nuka-ride-msma/controlled-prewar-profile.md)
- [Nora/Norita route selection and deferred starts](../nuka-ride-msma/route-selection-and-sanctuary.md)

## Location and settlement architecture

### Removed baseline layers

| Component | NORA status | Note |
|---|---|---|
| Previsibines Repair Pack (PRP) | Removed | Deliberate branch-level architectural choice |
| The Rebuild Collection - Shared Resources | Removed | Not used in NORA |
| The Rebuild Collection - AIO | Removed | Not used in NORA |
| Interior NavCut Fix | Disabled | Retained but inactive |
| Companion Shoots At Player Fix - F4SE | Disabled | Retained but inactive |
| Homemaker 1.79.6 | Disabled | Earlier addition ultimately not used |
| Transfer Settlements | Added | Used for settlement/blueprint work |

Removing PRP and Rebuild AIO is not a generic recommendation. NORA replaced their role with a tested combination of location-specific overhauls, optimization patches, custom conflict resolution and regenerated LOD.

### Diamond City

| Component | NORA status |
|---|---|
| Grrlie's Home Plate v4 - Eleanor | Added/customized |
| Diamond City Expansion 1.6.2 | Added |
| Diamond City Expansion StripperFix - Eleanor | Custom patch |
| Diamond City Expansion - eXoPatch | Added |
| Diamond City Colonial Taphouse | Added |
| Diamond City Outskirts 1.15 | Added |
| Diamond City Outskirts - Fix Eleanor | Custom patch |
| Diamond City Optimization | Added |

### Goodneighbor

| Component | NORA status |
|---|---|
| Goodneighbor Expanded | Added |
| Better The Third Rail | Added |
| Better Third Rail - Previsibines and Fixes | Added |
| Goodneighbor Expanded - FaceGen Fix Eleanor | Custom FaceGen patch |
| eXofied Goodneighbor | Added |
| Goodneighbor Loft | Added |

Goodneighbor required explicit plugin priority, previs compatibility and custom FaceGen repair. The fact that this stack worked in NORA does not make every subset or different order safe.

### Sanctuary, Red Rocket and other locations

| Component | NORA status |
|---|---|
| Sanctuary Lives Again and Bridged | Added |
| Rockin' Red Rocket | Added |
| Army Bunker player home and settlement | Added |
| New Taffington modern house | Added |
| Marlborough Mansion DLC Version | Added |
| Marlborough Mansion OAR Patch Eleanor | Custom patch |
| Flourishing Salem - Overhaul ESL | Added |
| Flourishing Salem Patch - Eleanor | Custom patch |

Sanctuary Lives Again required delayed activation after Preston's group reached Sanctuary, even though the mod was included earlier when producing the final LOD assets. That sequencing is documented in the [Nuka Ride route and Sanctuary guide](../nuka-ride-msma/route-selection-and-sanctuary.md).

## Seasons and environment

| Component | NORA status | Role |
|---|---|---|
| Seasons Change | Added | Dynamic seasonal system |
| Seasons Change xEdit Script and ESM resources | Added | Load-order integration |
| Saison Nora Patch Eleanor | Custom patch | Seasons/NAC/grass conflict resolution |
| Season Nuka World Tree Fix - Eleanor | Custom patch | Targeted seasonal tree correction |
| FOLIP Output | Regenerated output | Object LOD integration |
| TexGen Output | Regenerated output | LOD textures |
| xLODGen Output | Regenerated output | Final LOD |

The Nuka-World tree correction was specific to the tested Seasons Change 3.0 + Nuka Ride combination. It is not a universal Seasons patch.

See [Integrating Seasons Change into the generation workflow](../environment/seasons-change-generation-workflow.md).

## Tattoos, appearance and personal content

| Component | NORA status |
|---|---|
| Alpia Slavetats Body | Added |
| Alpia Slavetats Fallout 4 - Face 1K | Added |
| Tissemanns (Captive) Tattoos 1.0 | Added |
| Eleanor Tattoos | Custom content |
| Eleanor Loadscreens 2.0 | Custom content |
| Eleanor Loadscreens 2.0 - WoD Nuka Patch | Custom patch |
| RMM - Eleanor | Character-specific mod |
| NAC Flashlight Slot 57 Eleanor | Custom slot patch |
| Family Planning Contraceptive Pill Eleanor | Custom 48-hour gameplay patch |
| Output preset LooksMenu Eleanor | Character-specific generated output |

These entries demonstrate that character-specific material is easier to maintain when isolated from original mod files.

## Vehicles and additional quests

| Component | NORA status |
|---|---|
| Flyable Personal Vertibird | Added |
| FPV Paintjobs - Eleanor | Disabled; unsuccessful experiment retained |
| Problems of Survivor | Added |
| Problems of Survivor Far Harbor | Added |

Keeping a failed or unfinished experiment disabled in MO2 made rollback easier without pretending it belonged to the validated active setup.

## Isolated generated outputs

NORA moved tool-generated and character-specific files into named MO2 output mods:

| Output | Purpose |
|---|---|
| BodySlide Output - Nuka Ride MSMA | Final outfit/body meshes |
| Bodyslide Devious Device Output - Eleanor | Devious Devices meshes |
| Transfer Settlements - Generated Files - Eleanor | Settlement tool output |
| WoD - Generated Files Eleanor | General generated files |
| Eleanor MCM ini | Isolated MCM configuration |
| Outfits Screen Archer Output - Eleanor | Screen Archer outfit output |
| NAF Cache Eleanor | NAF runtime cache |
| Tint Fix Cache | Tint-fix cache |
| OUT - Creation Kit FO4 | Creation Kit output |
| FO4Edit Cache & Backups | xEdit cache and backups |
| FOLIP Output | FOLIP-generated resources |
| TexGen Output | TexGen-generated resources |
| xLODGen Output | xLODGen-generated resources |

This is one of the most reusable lessons from the branch: keep generated files out of `Overwrite`, identify their producer, and make every output independently replaceable.

See the [complete output generation workflow](../workflows/complete-output-generation-workflow.md).

## What this case study demonstrates

Starting from WoD 1.7.4, it was possible to:

- replace a selected technical subsystem rather than rebuild the entire modlist;
- integrate Nuka Ride and MSMA through controlled initialization;
- change the location architecture after removing conflicting global previs layers;
- add dynamic seasons and regenerate compatible LOD;
- repair specific FaceGen, mesh, slot and worldspace conflicts locally;
- develop small custom gameplay mods;
- preserve old versions and failed experiments as disabled rollback layers;
- isolate generated outputs so that future rebuilds remain understandable.

None of those changes was risk-free. The working result came from incremental installation, xEdit checks, controlled saves, in-game A/B testing and documented rollback points.

## What should not be copied blindly

Do not treat this comparison as an installation order.

In particular:

- do not remove PRP because NORA removed it;
- do not combine Addictol with an unchanged legacy crash-fix stack;
- do not ESL-convert large location overhauls without a dedicated audit;
- do not copy FaceGen or compatibility patches for different NPC records;
- do not reuse generated FOLIP, TexGen, xLODGen, BodySlide, sorter or NAF outputs from another load order;
- do not enable every listed adult gameplay system simultaneously without reviewing overlapping triggers;
- do not assume a disabled NORA component is defective.

Use the comparison to identify possibilities, then reproduce the validation process—not the final folder list.

## Snapshot limitations

- The source comparison was captured on September 7, 2026.
- Mods unchanged from WoD 1.7.4 are intentionally omitted.
- The exact right-pane plugin order is documented separately in the private working project.
- Personal patches are examples of local problem solving, not distributed compatibility products.
- Versions listed here describe the snapshot and may no longer be current.

## Credits and status

[Wasteland of Depravity](https://github.com/iAmMe27/WoD) remains the foundation of the installation.

All third-party project names belong to their respective authors. This page does not redistribute mods, archives, assets, patches or private documentation. It documents differences observed in one independently customized installation.

NORA/Eleanor is a personal branch and is not affiliated with, endorsed by, or supported by the WoD team.
