# Generic Addictol Integration Checklist

[Back to Addictol guides](README.md)

**Document type:** Generic checklist  
**Last revised:** September 14, 2026  
**Official mod page:** [Addictol on Nexus Mods](https://www.nexusmods.com/fallout4/mods/84214)  
**Official source:** [Dear-Modding-FO4/Addictol](https://github.com/Dear-Modding-FO4/Addictol)  
**Official releases:** [Addictol releases](https://github.com/Dear-Modding-FO4/Addictol/releases)  
**Official Crash Logger source:** [Dear-Modding-FO4/AddictolCrashLogger](https://github.com/Dear-Modding-FO4/AddictolCrashLogger)

## Scope

This checklist describes a controlled method for evaluating and integrating Addictol into an existing Mod Organizer 2 setup.

It is **not** a universal preset and does not provide a universal list of plugins to remove. Engine-fix stacks vary significantly between modlists, runtimes and personal installations.

The separate [Wasteland of Depravity guide](wasteland-of-depravity.md) documents one exact setup tested with **Addictol 1.5.2 and Addictol Crash Logger 1.5**. Its removal list must not be copied blindly into another profile.

> [!IMPORTANT]
> The WoD test does **not** cover Addictol 1.6 or later. Do not reuse the 1.5.2 TOML values, component-removal list, or Crash Logger assumptions for 1.6+ without a fresh upstream review and a complete retest. That migration is intentionally deferred while the upstream project is evolving rapidly.

## 1. Record the Current Baseline

Before installing anything, record:

- Fallout 4 runtime version;
- F4SE version;
- Mod Organizer 2 profile name;
- all installed F4SE plugins;
- engine fixes and their configuration mods;
- current crash logger;
- loading-screen framework;
- RobCo Patcher configuration;
- whether SKAR is enabled;
- current save and startup stability.

Confirm that the game can:

1. reach the main menu;
2. load a known test save;
3. create a new save;
4. fully exit and reload that save.

Do not troubleshoot Addictol on top of an already unstable baseline.

## 2. Prepare a Rollback Path

Use a separate MO2 profile or a complete working copy whenever possible.

Back up:

- the MO2 left pane;
- the MO2 right pane;
- profile-specific INI files;
- profile-specific saves;
- custom F4SE plugin configurations;
- generated outputs that may depend on the current engine-fix stack.

Keep the original engine fixes installed but disabled during the validation period. Do not delete them immediately.

## 3. Check the Current Addictol Release

Download Addictol only from its official page or official GitHub releases. Confirm the current Crash Logger source and compatibility at the same time.

Before installation, read the current:

- description;
- requirements;
- supported runtimes;
- file notes;
- changelog;
- configuration documentation;
- known incompatibilities.

This repository documents a successful test with Addictol 1.5.2 and Addictol Crash Logger 1.5. A newer release may use different options, packaging, logging components, or replacement rules.

## 4. Build an Overlap Matrix

Inventory every existing engine-level component before disabling one.

A simple comparison table is sufficient:

| Existing component | Current purpose | Addictol replacement confirmed? | Action | Rollback retained? |
|---|---|---:|---|---:|
| Example F4SE fix | Describe its function | Yes / No / Unknown | Keep / Disable / Investigate | Yes |

Only disable a component when its role and replacement status have been confirmed for the Addictol version being installed.

Do not assume that a mod is obsolete merely because it appears in another modlist's removal list.

Pay particular attention to:

- crash logging;
- memory and archive-limit fixes;
- Papyrus or engine-operation limit changes;
- disk or file caches;
- navigation fixes;
- save-related fixes;
- UI and persistent volume fixes;
- RobCo Patcher integrations;
- configuration packages that overwrite another F4SE plugin.

## 5. Install in Separate MO2 Entries

Where the current release packaging allows it, keep Addictol and its crash logger in separate MO2 entries.

Place them in the technical or engine-fix section of the left pane. Preserve a clear order and avoid mixing them with ordinary gameplay mods.

After enabling Addictol:

1. disable only the confirmed overlapping components;
2. check for unexpected conflicts;
3. confirm that no required file is being overwritten by an old configuration mod;
4. check the right pane for missing masters;
5. keep `Overwrite` empty before testing.

## 6. Review the Configuration File

The tested release used:

```text
F4SE\Plugins\Addictol.toml
```

Only configure options that exist in the currently installed release.

Values used successfully on the tested WoD profile were:

```toml
bFacegen = false
bLoadScreen = false
bRobCoPatcherCache = false
```

These are **examples, not generic defaults**.

### FaceGen

The appropriate FaceGen setting depends on the current Addictol release and the FaceGen-related components already present in the profile.

### Loading Screens

If another loading-screen framework is already responsible for images and text, test with Addictol's loading-screen management disabled.

On the tested WoD/ALR profile, enabling it produced black loading screens. Disabling it restored the existing images and text. This was an observed profile-specific result, not a universal rule.

### RobCo Patcher Cache and SKAR

Do not enable a RobCo Patcher cache option solely because another guide uses it.

Confirm:

- whether SKAR is installed and active;
- what the current Addictol documentation requires;
- whether the profile already contains another RobCo Patcher cache mechanism.

## 7. Preserve Crash Logging

If the integration disables the profile's existing crash logger, install and enable the crash-logging component recommended for the current Addictol release.

Do not intentionally crash the game merely to produce a log. After the next real CTD, confirm that:

- a log was generated;
- its timestamp matches the crash;
- it contains usable diagnostic data.

Until this has been confirmed, crash logging should be treated as installed but not fully validated.

## 8. Minimum Validation Matrix

Reaching the main menu is not sufficient.

### Startup and saves

- start through MO2;
- load a test save;
- create a new save;
- fully close the game;
- restart and reload the new save.

### Interface

- console;
- Pip-Boy;
- inventory;
- MCM;
- UI framework menus;
- audio and volume controls.

### World interaction

- interior-to-exterior transition;
- exterior-to-interior transition;
- several cell changes;
- fast travel;
- dialogue;
- container interaction;
- combat and looting.

### Installed frameworks

Test the important frameworks used by the profile, especially systems that depend on F4SE, animation frameworks, scripted overlays, RobCo Patcher or custom loading screens.

### Observation period

Do not combine the Addictol test with another major mod installation. Keep the profile otherwise unchanged long enough to identify new regressions.

## 9. Mid-Game Use

Addictol 1.5.2 with Addictol Crash Logger 1.5 was installed successfully mid-game on the tested WoD profile. Existing saves loaded, new saves were created and a full restart/reload cycle succeeded.

This is evidence for that setup only. It does not prove universal mid-game compatibility.

For another installation:

- follow the current author's guidance;
- retain a pre-installation save;
- avoid saving over the only known-good save;
- test with an isolated profile or copy first.

## 10. Rollback

If a repeatable regression appears:

1. close Fallout 4 and MO2;
2. disable Addictol and its associated crash logger;
3. re-enable the previous engine fixes and their matching configurations;
4. restore MO2 profile backups if necessary;
5. load a save created before the change;
6. repeat the baseline checks.

Rollback is appropriate when the new profile introduces:

- startup or save-load crashes;
- missing or unusable crash logs;
- repeatable interaction delay;
- broken menus or loading screens;
- framework failures;
- cache-related errors;
- instability not present in the recorded baseline.

## Quick Checklist

- [ ] Runtime and F4SE version recorded
- [ ] Stable baseline confirmed
- [ ] MO2 panes, INI files and saves backed up
- [ ] Current Addictol documentation reviewed
- [ ] Existing engine fixes inventoried
- [ ] Overlap matrix completed
- [ ] Only confirmed replacements disabled
- [ ] Configuration options reviewed individually
- [ ] Crash logging preserved
- [ ] Missing masters checked
- [ ] `Overwrite` checked
- [ ] Full validation matrix completed
- [ ] Rollback path retained

## Final Rule

Treat Addictol as an engine-infrastructure migration.

Change one technical layer at a time, record every disabled component and keep the previous working stack available until the new configuration has survived real testing.
