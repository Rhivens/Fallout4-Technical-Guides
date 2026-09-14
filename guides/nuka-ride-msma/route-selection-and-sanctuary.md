# Nuka Ride Route Selection, Deferred Starts and Sanctuary Activation

> **Tested route notes**
>
> Continue from the stable main-profile save produced by the [controlled Pre-War procedure](controlled-prewar-profile.md). Keep a permanent save before speaking to Duke.

## Duke selects the narrative route

The first substantive route dialogue with Duke is not cosmetic role-play.

Tested choices:

| Duke response | Route |
|---|---|
| Young Vault Dweller | Norita |
| Vanilla mother looking for Shaun | Nora |

The wording may vary with translation and Nuka Ride release. Identify the meaning of the answer, not only its exact localized text.

## Critical Marina warning

Talking to Marina before the route is securely chosen can close the Norita path.

If Norita is intended, do not casually start MSMA's narrative sequence. Keep a save from before any conversation with the Mysterious Scientist, Marina or Duke.

## Norita route

Norita is designed around a young, sexually inexperienced player character. Early MSMA SexFight progression can contradict that premise.

Recommended safe approach:

1. Complete the PreWar and technical initialization procedure.
2. Do not speak to the Mysterious Scientist.
3. Do not speak to Marina.
4. Speak to Duke only when ready to select the Young Vault Dweller response.
5. Keep MSMA's narrative route and SexFight progression unused during the sensitive Norita opening.
6. Consider returning to MSMA only after the relevant Norita route is complete and after checking the current compatibility guidance.

This is narrative and state-management caution, not proof that the plugins cannot technically coexist.

## Nora route — tested chronology

The following chronology was used for Eleanor's Nora playthrough.

### 1. Initialize the main profile

1. Complete the PreWar procedure.
2. Switch to the normal profile.
3. Let MSMA initialize technically.
4. Answer its startup questions.
5. Apply WoD presets and clothing injection.
6. Create a full baseline save.

### 2. Tell Duke to wait

Speak to Duke and select:

1. the response identifying the player as Shaun's vanilla mother;
2. the response meaning “thanks for the offer; I will go later.”

This selects Nora while deferring the actual trip to Nuka-World.

Vault 111 can be visited after this deferred response if required.

### 3. Meet the Mysterious Scientist

Start the MSMA narrative sequence by meeting the Mysterious Scientist near Vault 111.

If only the marker is visible, save and reload or use MSMA's targeted dialogue-forcing option. Avoid the global `ForceStart` when MSMA has already initialized.

### 4. Prepare Marina and SexFight

If the optional Milking Human Kindness detour will be used, speak to Marina before entering the pit so the Bimbo implant is initialized correctly.

Keep MSMA SexFight disabled throughout the complete pit quest. This avoids interference with that quest's scripted progression.

In the tested playthrough, Marina was accidentally skipped before entering the pit. The quest still completed, but the implant did not function until Eleanor visited Marina after leaving.

### 5. Complete the optional pit quest

This section applies only when Milking Human Kindness is installed.

1. Create a dedicated save.
2. Click the chest near Vault 111.
3. Complete the entire breeding-pit quest.
4. Keep SexFight disabled throughout.
5. Return to the Commonwealth.
6. If Marina was skipped, visit her now to initialize the implant.
7. Create another full save.

Marina is therefore important for the implant, but visiting her before the chest was not required for the pit quest itself in the tested game.

### 6. Start the actual trip to Nuka-World

After the optional detour:

1. travel to the robot near Drumlin Diner;
2. use that route to be transported to Nuka-World;
3. begin the Nuka Ride quest sequence;
4. keep a save from before teleportation.

Duke's earlier “go later” response allows this deferred start.

## Alternative Nora path

Players who do not want the Milking Human Kindness detour can skip the chest and proceed toward Nuka Ride through Duke's offered route or the later robot, according to the available dialogue state.

Do not improvise across multiple old saves. Use the route presented by the current quest state and retain rollback saves before every major transition.

## Optional: Sanctuary Lives Again and Bridged

[Sanctuary Lives Again and Bridged](https://www.nexusmods.com/fallout4/mods/62672) version 1.0 by GreekRage rebuilds Sanctuary and includes new precombined geometry, previs, navmesh and scripted location changes.

The author explicitly requires the opening quests to be completed through bringing Preston's group to Sanctuary, followed by leaving the area and saving before installing the mod. The author also warns that **all files**, not merely the ESP, must remain absent until activation.

### Include it in final generated outputs

A prebuilt MO2 setup can still account for the overhaul during final texture and LOD generation:

1. Install the mod normally in MO2.
2. Enable the entire mod and its plugin while generating the final relevant outputs.
3. Complete the generation chain and preserve those outputs.
4. In both the PreWar and normal gameplay profiles, disable the entire mod in the left pane and its plugin in the right pane before starting the new game.

This is a tested MO2 adaptation. The mod must participate in generation, but its runtime assets and plugin must not load during the early Sanctuary state.

Generated LOD may temporarily represent the future Sanctuary state while the overhaul is disabled. Avoid using that temporary startup period as a visual validation of Sanctuary.

### Delayed activation procedure

1. Follow the complete PreWar and MSMA startup process with the Sanctuary mod fully disabled.
2. Continue the vanilla Minutemen opening quest.
3. Let Preston and his entire group reach the old, destroyed Sanctuary.
4. Confirm that all expected NPCs are present.
5. Do not speak to Preston or advance another Sanctuary quest at that point.
6. Leave Sanctuary completely. Red Rocket is a suitable nearby save location if Sanctuary is no longer in view.
7. Create a new full manual save.
8. Exit Fallout 4.
9. In MO2, enable the **entire mod** in the left pane.
10. Enable its plugin in the right pane.
11. Confirm its intended priority after other mods editing Sanctuary, especially precombine-related plugins.
12. Load the save made away from Sanctuary.
13. Return to Sanctuary and inspect the rebuilt location.

Do not activate it while standing in Sanctuary or anywhere with a direct view of the location.

### Validation checklist

Check:

- rebuilt buildings and interiors;
- animated bridge;
- workshop and root-cellar relocation;
- navmesh behavior for Preston's group and settlers;
- precombine/previs stability;
- duplicated or floating objects;
- workshop access;
- save, full exit and reload;
- distant and near LOD transitions.

The tested installation loaded successfully with the expected rebuilt Sanctuary. A minor floating light bulb was considered cosmetic.

### Important restrictions

- Do not compact or ESL-convert `NEWSANCTUARY.esp`. It is a large location overhaul with cells, worldspace data, placed references and optimization records.
- Do not activate only the ESP while leaving mismatched assets loaded.
- Do not activate the mod before Preston's group reaches Sanctuary.
- Do not enable it while the player is in or overlooking Sanctuary.
- Do not redistribute or modify its assets without the author's permission.

## Route safety checklist

Before each irreversible conversation or teleport:

- create a separate full save;
- confirm whether Nora or Norita is intended;
- confirm whether MSMA's narrative route should remain untouched;
- keep SexFight disabled during the Milking Human Kindness pit quest;
- confirm Marina's implant initialization when needed;
- keep location overhauls at their documented activation state.

## Credits and references

- Nuka Ride by JB.
- MSMA and its contributing authors.
- Wasteland of Depravity community setup.
- [Sanctuary Lives Again and Bridged](https://www.nexusmods.com/fallout4/mods/62672) by GreekRage.
- Pepperman35, credited by the Sanctuary mod author for the animated bridge and scavenging station.

This guide documents tested sequencing and does not redistribute third-party mods, assets or private documentation.
