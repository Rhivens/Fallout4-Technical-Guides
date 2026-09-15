# Addictol Guides

## Official Project Links

- [Addictol on Nexus Mods](https://www.nexusmods.com/fallout4/mods/84214)
- [Addictol source repository](https://github.com/Dear-Modding-FO4/Addictol)
- [Addictol releases](https://github.com/Dear-Modding-FO4/Addictol/releases)
- [Addictol Crash Logger source repository](https://github.com/Dear-Modding-FO4/AddictolCrashLogger)

> [!IMPORTANT]
> The Wasteland of Depravity guide has now been updated and validated for **Addictol 1.6 + Addictol Crash Logger 1.6** on the documented Fallout 4 1.10.163 / F4SE 0.6.23 setup.
>
> The exact list of disabled fixes is specific to that tested WoD installation and should not be copied blindly to unrelated modlists.

Addictol is an engine-level Fallout 4 component. It should be approached as an infrastructure change, not as a cosmetic or ordinary gameplay mod.

The guides in this directory deliberately separate one tested modlist procedure from a generic integration method.

## Available Guides

| Guide | Scope | Status |
|---|---|---|
| [Wasteland of Depravity installation](wasteland-of-depravity.md) | Exact Addictol 1.6 procedure tested on a modified WoD installation | Tested / validated |
| [Generic integration checklist](generic-integration-checklist.md) | Decision and validation framework for other MO2 setups | Generic checklist |

## Important Distinction

The WoD guide contains an exact list of engine fixes disabled on the tested profile. That list is **not** a universal removal list.

For another modlist or personal installation, inventory the currently installed engine fixes and compare their functions with the current Addictol documentation before disabling anything.

## Tested Reference Setup

- Wasteland of Depravity 1.7.4 base, heavily customized
- Fallout 4 runtime 1.10.163
- F4SE 0.6.23
- Mod Organizer 2
- Addictol 1.6 stable
- Addictol Crash Logger 1.6
- RobCo Patcher 4.4.6 retained unchanged during migration
- SKAR / SAKR not used
- custom loading screens retained with `bLoadScreen = false`

The previous Addictol 1.5.2 setup is retained only as a historical rollback reference in the detailed WoD guide.

Always check the current Nexus description, file notes and changelog before following version-specific instructions.