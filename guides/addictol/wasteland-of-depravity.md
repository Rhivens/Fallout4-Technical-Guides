# Community Guide — Installing Addictol 1.6 in Wasteland of Depravity

[Back to Addictol guides](README.md)

**Guide version:** 1.2 — September 15, 2026  
**Tested setup:** Wasteland of Depravity 1.7.4 base, heavily customized — Fallout 4 runtime 1.10.163 / F4SE 0.6.23 — Mod Organizer 2  
**Tested Addictol version:** 1.6 stable  
**Tested Addictol Crash Logger version:** 1.6  
**Official mod page:** [Addictol on Nexus Mods](https://www.nexusmods.com/fallout4/mods/84214)  
**Official source:** [Dear-Modding-FO4/Addictol](https://github.com/Dear-Modding-FO4/Addictol)  
**Official Crash Logger source:** [Dear-Modding-FO4/AddictolCrashLogger](https://github.com/Dear-Modding-FO4/AddictolCrashLogger)

> [!IMPORTANT]
> This guide documents a **tested Addictol 1.6 migration on a modified Wasteland of Depravity setup**. The exact removal list is specific to that setup and should not be treated as a universal list for every Fallout 4 installation.

---

## Community Notice

This is **not an official Wasteland of Depravity guide**.

It was written by a WoD user based on a personal installation, practical testing, and information shared in the community Discord. It is provided as a community reference and knowledge-sharing document.

Results can differ depending on:

- the Wasteland of Depravity version;
- Fallout 4 runtime;
- Addictol version;
- personal MO2 changes;
- installed F4SE plugins;
- custom loading-screen systems;
- RobCo Patcher / SKAR / SAKR configuration.

Back up your MO2 profile and keep a reliable rollback path before changing engine-level plugins.

> **No technical support is provided.**  
> This document is informational. Each user remains responsible for their own setup, backups, saves and changes.

---

## 1. Purpose

Addictol consolidates and replaces several low-level F4SE fixes commonly present in WoD.

It should be treated as an **engine/infrastructure modification**, not as an ordinary gameplay mod.

The goals of the tested migration were to:

- simplify the engine-fix layer;
- avoid redundant or conflicting low-level plugins;
- retain Addictol's integrated engine fixes;
- preserve crash logging through Addictol Crash Logger;
- keep the OG Fallout 4 1.10.163 runtime stable;
- preserve custom loading screens and the rest of the mod stack.

---

## 2. Tested Reference Setup

The migration described here was validated on:

- Wasteland of Depravity **1.7.4 base**, heavily customized;
- Fallout 4 **1.10.163 (OG / pre-NG)**;
- F4SE **0.6.23**;
- Mod Organizer 2;
- Addictol **1.6 stable**;
- Addictol Crash Logger **1.6**;
- RobCo Patcher **4.4.6** retained unchanged;
- SKAR / SAKR not used;
- custom loading screens retained with Addictol loading-screen handling disabled.

The migration was performed mid-game on a dedicated test save and then used during normal gameplay before final validation.

---

## 3. Before Installing

Before changing anything:

1. back up the MO2 left pane;
2. back up the MO2 right pane;
3. keep a known working save;
4. confirm the game starts correctly before the migration;
5. keep the previous Addictol version and replaced fixes installed but disabled until validation is complete;
6. avoid updating unrelated engine-level components at the same time.

The last point matters. In the tested setup, **RobCo Patcher 4.4.6 was deliberately left unchanged** so that Addictol was the only major infrastructure change being tested.

---

## 4. Installing Addictol 1.6

Install as separate MO2 mods:

1. **Addictol 1.6**
2. **Addictol Crash Logger 1.6**

If migrating from Addictol 1.5.2:

1. disable Addictol 1.5.2;
2. disable the previous Crash Logger;
3. enable Addictol 1.6;
4. enable Addictol Crash Logger 1.6;
5. keep the old packages installed until the new setup is validated.

### Recommended MO2 Placement

Keep Addictol and Addictol Crash Logger together in the same technical separator used for Buffout / engine-level fixes.

The tested WoD layout keeps them near the old Buffout section.

---

## 5. WoD Fixes Disabled with Addictol 1.6

The following items were disabled on the tested WoD profile:

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

Items 16–18 are the additional removals compared with the previously tested Addictol 1.5.2 setup.

> [!WARNING]
> Do not copy this list blindly to another modlist. It reflects one specific WoD setup. Compare your installed engine fixes with the current Addictol feature set before disabling anything.

Do not delete the replaced mods immediately. Leaving them installed but disabled makes rollback much easier.

---

## 6. Addictol.toml Configuration

Open:

```text
F4SE\Plugins\Addictol.toml
```

### 6.1 FaceGen

Use:

```toml
bFacegen = false
```

This value was retained from the WoD procedure and validated on the tested setup.

### 6.2 Custom Loading Screens

To preserve the existing custom loading-screen system, use:

```toml
bLoadScreen = false
```

On the tested setup, enabling Addictol loading-screen handling caused custom loading screens to become black. Disabling that Addictol feature preserved the custom images and text correctly.

If you intentionally want Addictol to manage loading screens, test that behavior separately. Do not assume the same value is correct for every custom loading-screen solution.

### 6.3 RobCo Patcher Cache Setting Removed

The Addictol 1.5.2 option:

```toml
bRobCoPatcherCache
```

is **not present in Addictol 1.6**.

Do not carry old 1.5.2 instructions for that setting into a 1.6 configuration.

In the tested setup, SKAR / SAKR was not used and RobCo Patcher **4.4.6** was kept unchanged during the migration.

---

## 7. Relevant Integrated Fixes in Addictol 1.6

The tested 1.6 TOML includes integrated fixes corresponding to several standalone plugins disabled above, including:

```toml
bInteriorNavCut = true
bBakaMaxPapyrusOps = true
bSprintStutter = true
bMoonRotation = true
bFixesArmorPenetration = true
```

Other important engine-level options used in the tested configuration include:

```toml
bMemoryManager = true
bSmallBlockAllocator = true
bScaleformAllocator = true
bArchiveLimits = true
bSaveCompression = true
```

Always review the actual TOML shipped with the Addictol version you install. Options can change between releases.

---

## 8. First-Launch Validation

The first launch with Addictol 1.6 was successful:

- main menu reached without CTD;
- Cell Offset Cache loaded correctly;
- F4SE Menu Framework loaded correctly;
- an existing test save loaded successfully;
- a heavy modded cell loaded without CTD or freeze;
- a new save was created successfully;
- the first load was slightly longer than usual, but no persistent problem followed.

A successful main-menu launch alone is not enough to validate the migration.

---

## 9. Recommended Test Procedure

After the first boot, verify at least:

### Startup and Saves

- load an existing save;
- create a new save;
- quit to desktop;
- restart the game;
- reload the new save.

### Interface

- console;
- Pip-Boy;
- inventory;
- MCM / F4SE menu systems;
- FallUI or equivalent UI stack.

### World and Gameplay

- interior/exterior transitions;
- fast travel;
- several cell changes;
- sprinting;
- combat;
- looting;
- dialogue and activation interactions;
- workshop functions if used.

### Frameworks

On a heavily modded WoD profile, also verify the animation and quest frameworks you actually use, for example NAF / AAF and other script-heavy systems.

### Loading Screens

If retaining a custom loading-screen system:

- confirm images appear;
- confirm text appears;
- verify multiple loading screens;
- ensure screens are not completely black.

---

## 10. Final Validation Result

After continued normal gameplay on the tested WoD setup, **Addictol 1.6 was considered fully functional**.

Observed result:

- normal startup;
- saves load normally;
- new saves can be created;
- world and cell transitions remain functional;
- menus and frameworks load correctly;
- no obvious regression attributable to Addictol 1.6 was observed;
- the custom loading-screen system remains functional with `bLoadScreen = false`;
- the overall mod stack continues to operate normally.

This result is specific to the tested configuration and does not guarantee identical behavior on another installation.

---

## 11. Addictol Crash Logger 1.6

With Buffout 4 disabled, Addictol Crash Logger becomes the active CTD logging solution.

After a real crash:

1. verify that a crash log was created;
2. confirm its timestamp matches the CTD;
3. keep the log before repeated relaunches;
4. use it for troubleshooting.

There is no need to intentionally crash the game only to test the logger.

---

## 12. RobCo Patcher Note

The tested migration deliberately retained:

```text
RobCo Patcher 4.4.6
```

This was the existing WoD version and worked correctly before the Addictol migration.

The purpose was to change one subsystem at a time. Updating RobCo Patcher simultaneously would make troubleshooting much less reliable.

If SKAR / SAKR is introduced later, re-audit the relationship between RobCo Patcher, its cache behavior and the current Addictol version rather than reusing old Addictol 1.5.2 advice.

---

## 13. Rollback

If a serious regression appears:

1. close Fallout 4;
2. disable Addictol 1.6;
3. disable Addictol Crash Logger 1.6;
4. restore the previous Addictol / engine-fix setup;
5. restore the previous TOML configuration;
6. re-enable the standalone fixes that were required by the old setup;
7. load a known-good save if necessary.

Do not delete rollback components until the new configuration has been used long enough to be trusted.

---

## 14. Historical Note — Addictol 1.5.2

Before the successful 1.6 migration, the same project had also validated:

- Addictol **1.5.2**;
- Addictol Crash Logger **1.5**;
- fifteen standalone fixes disabled;
- `bFacegen = false`;
- `bLoadScreen = false`;
- `bRobCoPatcherCache = false` with SKAR not used.

That setup is now retained only as a historical rollback reference. The current validated configuration is **Addictol 1.6 + Addictol Crash Logger 1.6**.

---

## 15. Quick Summary

1. Back up the MO2 profile and saves.
2. Install Addictol 1.6.
3. Install Addictol Crash Logger 1.6.
4. Disable the eighteen replaced WoD fixes listed above.
5. Set:

```toml
bFacegen = false
```

6. To keep the tested custom loading screens, set:

```toml
bLoadScreen = false
```

7. Do **not** look for `bRobCoPatcherCache`; it was removed in Addictol 1.6.
8. Keep RobCo Patcher unchanged while validating Addictol unless you have a specific reason to update it.
9. Test saves, transitions, menus, gameplay and your major frameworks.
10. Keep a rollback path until the new setup has proven stable.

**Test result on the documented WoD setup: Addictol 1.6 validated.**