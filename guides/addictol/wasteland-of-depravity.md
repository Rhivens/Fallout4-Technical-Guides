# Community Guide — Installing Addictol in Wasteland of Depravity

[Back to Addictol guides](README.md)

**Guide version:** 1.1 — September 14, 2026  
**Tested setup:** Wasteland of Depravity 1.7.4, manually updated to 1.7.5.1 — Fallout 4 runtime 1.10.163 / F4SE 0.6.23 — Mod Organizer 2  
**Tested Addictol version:** 1.5.2  
**Tested Addictol Crash Logger version:** 1.5  
**Official mod page:** [Addictol on Nexus Mods](https://www.nexusmods.com/fallout4/mods/84214)  
**Official source:** [Dear-Modding-FO4/Addictol](https://github.com/Dear-Modding-FO4/Addictol)  
**Official Crash Logger source:** [Dear-Modding-FO4/AddictolCrashLogger](https://github.com/Dear-Modding-FO4/AddictolCrashLogger)

> [!WARNING]
> This procedure applies **only to Addictol 1.5.2 with Addictol Crash Logger 1.5**. Its configuration values and WoD removal list have not been validated for Addictol 1.6 or later. The migration to 1.6+ is intentionally deferred until the rapidly evolving upstream project can be audited and the complete procedure retested.

---

## Community Notice

This is **not an official Wasteland of Depravity guide**.

It was written by a WoD user based on a personal installation, practical testing, and information shared in the community Discord. It is being provided as a personal contribution for community support and knowledge sharing.

Results may vary depending on:

- the Wasteland of Depravity version;
- the Fallout 4 runtime;
- the Addictol version;
- personal changes made to the MO2 profile;
- other F4SE plugins or engine-level fixes installed.

Before making any changes, create backups of your MO2 profile and keep a reliable rollback solution.

> **No technical support is provided**  
> This guide is shared for informational and community purposes only. Its author does not provide technical support, personalized diagnosis, troubleshooting, follow-up, or installation assistance. Each user remains fully responsible for their own setup, backups, save files, and changes made to their MO2 profile.

---

## Acknowledgements

Special thanks to Discord user **TheSpurs**, whose detailed discussions and feedback about installing Addictol in his MO2 profile greatly helped with understanding and refining this procedure.

---

## 1. Purpose

Addictol consolidates and replaces several low-level F4SE fixes already included in WoD.

Its integration may help with:

- simplifying the engine-fix layer used by the modlist;
- replacing several redundant or incompatible F4SE plugins;
- improving the handling of certain engine limits, including BA2 archive limits;
- keeping usable crash logs through **Addictol Crash Logger**.

Addictol should be treated as an **infrastructure-level modification**, not as a simple gameplay mod or cosmetic addition.

---

## 2. Precautions Before Installation

Before starting:

1. create a backup of the MO2 left pane;
2. create a backup of the MO2 right pane;
3. confirm that the game starts correctly before the change;
4. keep a known working test save;
5. avoid performing the procedure on your only stable installation without a rollback option.

The safest method is to work with:

- a full copy of WoD;
- or a properly configured separate MO2 profile.

---

## 3. Installing Addictol

Download Addictol from its [official Nexus Mods page](https://www.nexusmods.com/fallout4/mods/84214).

Install the following in MO2:

1. **Addictol 1.5.2**
2. **Addictol Crash Logger 1.5**

It is recommended to install them as two separate MO2 mods. This makes checking, updating, and rolling back much easier.

Enable both mods.

### Recommended Position in the MO2 Left Pane

In the standard WoD separator structure, place both mods inside the separator:

```text
Buffout
```

Recommended order:

1. `Addictol`
2. `Addictol Crash Logger`

Keep them together in this technical section, near the engine-level fixes they replace. The replaced mods must then be disabled as described in the next section.

> **Why install Addictol Crash Logger?**  
> This procedure disables Buffout 4. Addictol Crash Logger is therefore required to keep a system capable of producing usable crash logs after a CTD.

---

## 3.1 Mid-Game Installation

Addictol was successfully tested **mid-game**, without starting a new game and without losing existing saves.

On the tested setup:

- existing saves were preserved;
- previous saves continued to load normally;
- new saves could be created;
- a full game shutdown, restart, and reload of the latest save were validated.

This change can therefore be considered **mid-game compatible in the tested WoD setup**, provided that the procedure is followed correctly, the replaced fixes are disabled, and backups are kept.

This does not remove the need to back up both the MO2 profile and Fallout 4 save files before making changes. Personal setups may differ.

---

## 4. WoD Fixes to Disable

After installing and enabling Addictol, disable the following mods in the MO2 left pane:

1. `Baka MaxPapyrusOps`
2. `Mentats - F4SE`
3. `Mentats - WoD Config`
4. `X-Cell`
5. `X-Cell - WoD Config`
6. `Buffout 4`
7. `Buffout 4 - WoD Config`
8. `Buffout and X-Cell - New WoD Configs`
9. `Interior NavCut Fix`
10. `Daytripper`
11. `Daytripper - WoD Config`
12. `Persistent Volume Sliders`
13. `Long Save Bug Fix`
14. `Disk Cache Enabler`
15. `Companion Shoots at Player Fix - F4SE`

These are mainly F4SE plugins and related configuration mods. Disabling them should not normally change the active ESP/ESM count or create missing masters.

A full MO2 check is still required after the change.

> **Important:** Do not immediately delete these mods. Disable them only, so that the previous configuration can be restored easily if needed.

---

## 5. Configuring Addictol

Open the following file:

```text
F4SE\Plugins\Addictol.toml
```

Depending on your MO2 setup, this file should normally be located inside the Addictol mod folder.

---

## 5.1 FaceGen

Find:

```toml
bFacegen = true
```

Change it to:

```toml
bFacegen = false
```

### Recommended Value for WoD

```toml
bFacegen = false
```

This value was used and validated on the tested setup.

---

## 5.2 Loading Screen Compatibility

Find the following setting:

```toml
bLoadScreen = true
```

The correct value depends on the loading screen system you want to keep.

| Loading screen setup | Recommended value |
|---|---:|
| Original WoD loading screens | `false` |
| Animated Loading Screens / ALR | `false` |
| Another equivalent custom loading screen system | `false` |
| Addictol loading screen management | `true` |

### To Keep WoD, ALR, or Another Custom Loading Screen System

Use:

```toml
bLoadScreen = false
```

This disables Addictol loading screen management and allows the existing system to continue working.

During testing with ALR, the value:

```toml
bLoadScreen = true
```

caused completely black loading screens, with no image and no text.

Changing it to:

```toml
bLoadScreen = false
```

immediately restored the custom loading screen images and text.

This behavior was observed on the tested setup and may not apply universally to every installation.

### To Use Addictol Loading Screen Management

Users who want Addictol to manage loading screens may keep:

```toml
bLoadScreen = true
```

---

## 5.3 Special Case: SKAR and RobCo Patcher Cache

In the relevant section of `Addictol.toml`, find:

```toml
bRobCoPatcherCache = false
```

### If SKAR Is Enabled

If **SKAR** is active under **NSFW Optional Stuff**, use:

```toml
bRobCoPatcherCache = true
```

### If SKAR Is Not Enabled

Keep:

```toml
bRobCoPatcherCache = false
```

Do not enable this setting without a reason. It depends on the actual profile configuration.

---

## 6. Tested Configuration

The following configuration was used successfully:

```toml
bFacegen = false
bLoadScreen = false
bRobCoPatcherCache = false
```

Context:

- Wasteland of Depravity 1.7.4, manually updated to 1.7.5.1;
- Fallout 4 runtime 1.10.163 / F4SE 0.6.23;
- SKAR disabled;
- custom loading screens based on ALR;
- Addictol 1.5.2;
- Addictol Crash Logger 1.5 enabled.

---

## 7. MO2 Checks

After installing, configuring, and disabling the previous fixes:

1. confirm that Addictol is enabled;
2. confirm that Addictol Crash Logger is enabled;
3. confirm that all fifteen previous fixes are disabled;
4. check for missing masters;
5. make sure no unexpected plugin was disabled;
6. make sure `Overwrite` is empty before the first test;
7. create new backups of both the MO2 left and right panes.

---

## 8. Minimum Test Procedure

Do not consider the installation validated just because the game reaches the main menu.

Perform at least the following checks.

### Startup and Saves

- start the game through MO2;
- reach the main menu;
- load a test save;
- create a new save;
- fully close the game;
- start the game again;
- reload the latest save.

### Interface and Menus

- open the console;
- open the Pip-Boy;
- open the inventory;
- check the MCM;
- check FallUI menus;
- check volume sliders.

### World and Gameplay

- move from an interior to an exterior;
- move from an exterior to an interior;
- use fast travel;
- change cells;
- talk to several NPCs;
- perform a basic combat test;
- loot items and open containers;
- monitor interaction delay when using the activation key.

### WoD Frameworks and Features

- test a NAF/AAF scene;
- test group animations if available;
- test Bound in Public features;
- test Tats After Rape application;
- test alcohol and drug visual effects;
- verify menus and features related to sensitive mods in the profile.

### Loading Screens

- confirm that images appear;
- confirm that text appears;
- confirm normal loading screen rotation;
- confirm that loading screens are not completely black.

---

## 9. Results on the Tested Setup

The following checks were validated successfully:

- game startup;
- save loading;
- creation of new saves;
- full shutdown and restart;
- console;
- Pip-Boy;
- MCM;
- inventory;
- FallUI;
- fast travel;
- cell transitions;
- combat;
- looting;
- NAF/AAF scenes;
- group scene;
- several consecutive Bound in Public scenes;
- automatic release;
- Tats After Rape;
- alcohol, heroin, and Ultra Jet visual effects;
- custom ALR loading screens with `bLoadScreen = false`.

No CTD, freeze, or obvious malfunction was observed during this test series.

This does not guarantee that another setup or a long playthrough will be completely free of issues.

---

## 10. Crash Logs

With Buffout 4 disabled, Addictol Crash Logger becomes the main CTD logging system.

After a real crash:

1. confirm that a crash log was generated;
2. keep the file before launching the game repeatedly;
3. verify that the date and time match the CTD;
4. use that log for troubleshooting.

It is not recommended to intentionally crash the game only to test the logger.

---

## 11. Validation Criteria

The installation can be considered functional if:

- the game starts correctly;
- saves load and save normally;
- no missing masters appear;
- no unexpected plugin is disabled;
- menus remain functional;
- dialogue and interactions show no abnormal delay;
- cell transitions work;
- NAF/AAF remains operational;
- the selected loading screen system displays correctly;
- Addictol Crash Logger remains enabled;
- no obvious regression appears during testing.

---

## 12. Rollback Procedure

If a major problem appears:

1. close Fallout 4 and MO2;
2. disable Addictol;
3. disable Addictol Crash Logger;
4. re-enable the fifteen previous WoD fixes;
5. restore the MO2 backups if necessary;
6. load a save created before installing Addictol;
7. confirm that the previous setup works again.

A rollback is recommended in case of:

- startup crash;
- repeatable save-load crash;
- no usable crash logs;
- increased delay or freezing;
- NAF/AAF malfunction;
- RobCo Patcher or SKAR issue;
- major regression not present before Addictol;
- unstable behavior that cannot be clearly linked to another change.

---

## 13. Final Recommendations

- Install Addictol before adding large quest mods or other major technical layers.
- Do not change several major systems at the same time.
- Test Addictol by itself before continuing modlist work.
- Keep the previous fixes disabled rather than deleted during the entire validation period.
- Document every change made to `Addictol.toml`.
- After an Addictol update, read the changelog and confirm that the available settings have not changed.
- Create new MO2 backups after validation.
- Use a new game for large projects such as Nuka Ride or MSMA when recommended by those mods.

---

## 14. Quick Summary

1. Back up the MO2 left and right panes.
2. Install Addictol 1.5.2.
3. Install Addictol Crash Logger 1.5.
4. Disable the fifteen previous WoD fixes listed in this guide.
5. At minimum, set:

```toml
bFacegen = false
```

6. To keep WoD loading screens, ALR, or another custom system:

```toml
bLoadScreen = false
```

7. If SKAR is not enabled:

```toml
bRobCoPatcherCache = false
```

8. Check masters and `Overwrite`.
9. Test the game thoroughly.
10. Keep a rollback option available.

---

# Preliminary Migration Notes — Addictol 1.6

> [!CAUTION]
> **Not yet tested on the setup documented above.**  
> This section records the current WoD Discord migration procedure for Addictol 1.6. It is provided as a preparation note only. The validated configuration in this guide remains **Addictol 1.5.2 + Addictol Crash Logger 1.5** until the 1.6 migration is fully tested.

## What Changes in 1.6

The fifteen fixes already disabled for Addictol 1.5.2 remain disabled. Addictol 1.6 additionally replaces three fixes that should also be disabled:

16. `Armor Penetration Bug Fix - F4SE`
17. `Moon Rotation Fix`
18. `Sprint Stuttering Fix`

The complete current WoD removal list for Addictol 1.6 is therefore:

1. `Baka MaxPapyrusOps`
2. `Mentats - F4SE`
3. `Mentats - WoD Config`
4. `X-Cell`
5. `X-Cell - WoD Config`
6. `Buffout 4`
7. `Buffout 4 - WoD Config`
8. `Buffout and X-Cell - New WoD Configs`
9. `Interior NavCut Fix`
10. `Daytripper`
11. `Daytripper - WoD Config`
12. `Persistent Volume Sliders`
13. `Long Save Bug Fix`
14. `Disk Cache Enabler`
15. `Companion Shoots at Player Fix - F4SE`
16. `Armor Penetration Bug Fix - F4SE`
17. `Moon Rotation Fix`
18. `Sprint Stuttering Fix`

Do not delete these mods immediately. Disable them so rollback remains easy.

## Crash Logger

Install the matching **Addictol Crash Logger** file from the Main Files section so crash logs remain available after Buffout 4 is disabled.

## FaceGen Setting

Open:

```text
F4SE\Plugins\Addictol.toml
```

and set:

```toml
bFacegen = false
```

This remains part of the current WoD procedure for Addictol 1.6.

## Loading Screens

The tested 1.5.2 setup in this guide uses:

```toml
bLoadScreen = false
```

to preserve WoD / ALR / custom loading screens.

This value should be **rechecked during the 1.6 migration** before being considered validated for 1.6.

## SKAR / RobCo Patcher Cache

The old 1.5.2 instruction to set:

```toml
bRobCoPatcherCache = true
```

when SKAR is enabled **does not apply to Addictol 1.6**. The `bRobCoPatcherCache` option has been removed from Addictol 1.6 because caching is handled upstream by current RobCo Patcher builds.

## Suggested 1.6 Migration Order

1. Back up the MO2 left pane, right pane, and test saves.
2. Replace Addictol 1.5.2 with Addictol 1.6.
3. Install the matching Addictol Crash Logger.
4. Keep the original fifteen replaced fixes disabled.
5. Disable `Armor Penetration Bug Fix - F4SE`, `Moon Rotation Fix`, and `Sprint Stuttering Fix`.
6. Set `bFacegen = false`.
7. Do not carry over the old `bRobCoPatcherCache` instruction.
8. Recheck loading-screen behavior before assuming the old `bLoadScreen` value is still correct.
9. Perform the full validation procedure from this guide.
10. Keep the previous Addictol 1.5.2 setup available for rollback until the new version has been tested over multiple sessions.

## Current Recommendation

Because Addictol is still evolving quickly upstream, there is no need to migrate a stable working WoD installation immediately. Waiting for development activity to settle, or for a specific build to be clearly recommended by the WoD team, is a reasonable approach.

---

## Sharing Notice and No Support

This guide may be freely shared within the WoD community as long as the following remain included:

- the notice that it is not official;
- the tested setup information;
- the acknowledgement to **TheSpurs**;
- the warning that installations may differ;
- the explicit statement that no technical support is provided by the author.

Sharing this guide does not create any obligation to provide support, troubleshooting, updates, or individual replies.

Assistance requests should be directed to the appropriate community support channels rather than to the author of this guide.
