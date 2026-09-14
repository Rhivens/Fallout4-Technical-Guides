# Addictol Guides

## Official Project Links

- [Addictol on Nexus Mods](https://www.nexusmods.com/fallout4/mods/84214)
- [Addictol source repository](https://github.com/Dear-Modding-FO4/Addictol)
- [Addictol releases](https://github.com/Dear-Modding-FO4/Addictol/releases)
- [Addictol Crash Logger source repository](https://github.com/Dear-Modding-FO4/AddictolCrashLogger)

> [!WARNING]
> The tested World of Depravity guide applies **only to Addictol 1.5.2 with Addictol Crash Logger 1.5**.
>
> Do not apply its version-specific configuration or removal list to Addictol 1.6 or later without a new audit. Migration to the newer Addictol branch has been deliberately deferred because the upstream code and configuration model are evolving quickly.

Addictol is an engine-level Fallout 4 component. It should be approached as an infrastructure change, not as a cosmetic or ordinary gameplay mod.

The guides in this directory deliberately separate one tested modlist procedure from a generic integration method.

## Available Guides

| Guide | Scope | Status |
|---|---|---|
| [World of Depravity installation](world-of-depravity.md) | Exact procedure tested on a modified WoD installation | Tested guide |
| [Generic integration checklist](generic-integration-checklist.md) | Decision and validation framework for other MO2 setups | Generic checklist |

## Important Distinction

The WoD guide contains an exact list of engine fixes disabled on the tested profile. That list is **not** a universal removal list.

For another modlist or personal installation, inventory the currently installed engine fixes and compare their functions with the current Addictol documentation before disabling anything.

## Tested Reference Setup

- World of Depravity 1.7.4, manually updated to 1.7.5.1
- Fallout 4 runtime 1.10.163
- F4SE 0.6.23
- Mod Organizer 2
- Addictol 1.5.2
- Addictol Crash Logger 1.5
- SKAR disabled
- custom ALR-based loading screens

Always check the current Nexus description, file notes and changelog before following version-specific instructions.
