# Controlled Pre-War Profile and Late MSMA Initialization

> **Tested guide — configuration-specific**
>
> Developed with Fallout 4 1.10.163, Mod Organizer 2, Start Me Up Redux, Nuka Ride, MSMA 1.121 and a Wasteland of Depravity-derived setup. The method was tested across Nuka Ride 7.09 and a later 7.1.x branch. Exact prompts may differ in other releases.

## Purpose

A heavy adult modlist can initialize many scripts and MCM systems at the same time as the opening sequence. MSMA also expects a carefully timed first initialization near Vault 111.

This workflow uses two MO2 profiles:

- **PreWar** — a temporary startup profile with MSMA and selected generated or intrusive plugins disabled
- **Main** — the complete gameplay profile used after the player character reaches the Commonwealth

The objective is to create the character, complete Start Me Up Redux's startup work, then let MSMA initialize only after loading the transferred save in the full profile.

## Important distinction

This guide separates three different events:

1. **MSMA plugin activation** — `MSMA_Sexual_Journey.esp` is enabled in the main profile.
2. **MSMA technical initialization** — startup questions, registrations and background setup complete.
3. **MSMA narrative start** — the player interacts with the Mysterious Scientist and later Marina.

Technical initialization does not require immediately starting MSMA's narrative route.

## Before creating the profiles

1. Finish installing Nuka Ride, MSMA and all required animation, outfit, tattoo, piercing and interface dependencies.
2. Finish Fusion Girl conversions and BodySlide output.
3. Rebuild NAFicator if animation or XML inputs changed.
4. Finish all generated plugin and LOD outputs intended for the final modlist.
5. Back up both MO2 panes.
6. Enable profile-specific saves and profile-specific INI files.
7. Clone the intended main profile to create `PreWar`.

Do not use an existing long-running save. Both Nuka Ride and MSMA should be introduced through a controlled new game.

## Tested PreWar exclusions

The following plugins were disabled in the tested PreWar profile:

```text
MSMA_Sexual_Journey.esp
EleanorLoadscreens_WoD_Nuka_Patch.esp
FOLIP - Patch.esp
M8r Complex Sorter.esp
M8r Complex Sorter-part2.esp
Make Items Weightless.esp
FP_SexualHarassment.esp
HotPockets-SHarassmentthieves.esp
WoD Dialogue Tweaks.esp
```

This is not a universal exclusion list.

Each entry was removed for a reason:

- MSMA must not initialize during the opening.
- Generated late patches can depend on the final gameplay state and are unnecessary during character creation.
- intrusive dialogue or approach mods may interrupt the prologue.
- in the tested setup, Sexual Harassment could trigger inappropriate behavior from Nate during the Pre-War sequence.

Disable the **whole mod** as well as its plugin when its loose files or archives can affect startup. Do not assume that unticking only an ESP removes all of a mod's resources.

## Create the character

1. Launch Fallout 4 with the `PreWar` profile.
2. Create the player character.
3. When character creation ends, do nothing.
4. Wait until the MCM and mod-initialization notifications stop scrolling.
5. Approach the bathroom exit.
6. Select `NUKA RIDE` in the Start Me Up Redux choice window.
7. Select the requested attributes, statistics, bonuses and penalties.
8. Allow Start Me Up Redux to complete the transition.

In the tested setup, selecting `NUKA RIDE` teleported the player character directly outside Vault 111. It did not require playing through the vault interior.

The vault remains accessible later on the Nora route after Duke has been told that the player will travel to Nuka-World later.

## Stabilize the PreWar save

After appearing outside Vault 111:

1. Wait for the Start Me Up notification and all subsequent startup messages.
2. Do not immediately open menus while messages are still being processed.
3. **Do not speak to Duke yet.**
4. Wait until the screen remains quiet for a reasonable period.
5. Create a new full manual save.
6. Exit Fallout 4 completely.

Do not overwrite the last clean startup save.

## Transfer to the main profile

With profile-specific saves enabled, copy the matching save pair from the PreWar profile to the main profile:

```text
save-name.fos
save-name.f4se
```

The `.f4se` cosave must travel with its corresponding `.fos` file.

Then:

1. Switch to the normal gameplay profile.
2. Confirm that MSMA and the intended final plugins are enabled.
3. Keep any location overhaul that requires delayed activation fully disabled until its own activation point.
4. Load the transferred save.
5. Do not move or interact while the full profile initializes.

## Let MSMA initialize

MSMA may immediately present many prompts. Answer them carefully and allow enough time between windows for background initialization.

1. Complete MSMA's startup questions.
2. Wait for all MSMA and other mod messages to finish.
3. Do not use the global `ForceStart` button merely because initialization takes time.
4. If MSMA reports Start Me Up Redux but continues initializing, wait.
5. Use targeted MCM diagnostics only when the normal initialization has genuinely failed.

In the tested setup, MSMA initialized successfully after loading the transferred save even though it warned that alternate-start detection could interfere.

## Apply the WoD MCM setup

Apply the WoD configuration **after MSMA has completed its technical initialization**.

Follow the current [Wasteland of Depravity Mod Setup](https://github.com/iAmMe27/WoD/blob/main/ModSetup.md):

1. Open `Mod Config → -= MCM Settings Manager =-`.
2. Apply the main profile preset.
3. Apply an optional compatible preset only after the main preset.
4. Open `Commonwealth Captives Outfit Injector`.
5. Select `Global Settings → Inject All Clothing`.
6. Wait for the injection-complete message.
7. Exit the MCM.

Presets may overwrite personal choices. In the tested setup, settings checked again included:

- Sex Attributes belly morph
- AAF Violate companion participation
- BLTC cum-addiction behavior
- camera preferences
- MSMA compatibility choices

Review the settings that matter to the intended playthrough rather than copying these values blindly.

## Create the main baseline save

When initialization, presets and injection are complete:

1. Wait again until no messages remain.
2. Create a new full manual save.
3. Keep the transferred PreWar save unchanged as rollback.
4. Record the active MO2 mod and plugin lists.
5. Continue with [route selection and deferred quest starts](route-selection-and-sanctuary.md).

## Troubleshooting

### The Mysterious Scientist is not visible

In the tested setup, only the quest marker appeared.

Try, in order:

1. wait for MSMA initialization to finish;
2. save and reload;
3. use the targeted MCM option that forces the Mysterious Scientist dialogue.

Do not use the global MSMA `ForceStart` if the framework has already initialized.

### Marina is not visible

Try her bell, then save and reload. Terrain and Sanctuary-area overhauls can also interfere with her placement.

### Black screen with a hidden prompt

Try `E`, `Enter` or `Tab` before assuming the game has frozen. MSMA also provides MCM controls for certain stuck black overlays.

## Rollback points

Keep separate saves for:

1. character creation complete;
2. outside Vault 111 before speaking to Duke;
3. main profile after MSMA initialization;
4. WoD presets and clothing injection complete;
5. immediately before selecting the Nuka Ride route.

Never clean an active Nuka Ride save with ReSaver as a routine troubleshooting step, and do not uninstall Nuka Ride or MSMA mid-playthrough.

## References and credits

- [Wasteland of Depravity Mod Setup](https://github.com/iAmMe27/WoD/blob/main/ModSetup.md) by the WoD team.
- [Start Me Up Redux](https://www.nexusmods.com/fallout4/mods/56984) by Dashboarderian and Oddlittleturtle.
- Nuka Ride by JB.
- MSMA and its contributing authors.

No third-party files or private discussions are reproduced in this guide.
