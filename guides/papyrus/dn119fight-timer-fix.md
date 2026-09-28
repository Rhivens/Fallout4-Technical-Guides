# DN119Fight Timer Fix — Preventing Repeated `IsDead(None)` Papyrus Errors

[Back to Papyrus and troubleshooting guides](README.md)

**Document type:** Tested troubleshooting guide  
**Last revised:** September 28, 2026  
**Tested runtime:** Fallout 4 1.10.163 / F4SE 0.6.23  
**Mod manager:** Mod Organizer 2  
**Tools used:** xEdit 4.1.5, B.A.E., Champollion, Creation Kit Papyrus Compiler 2.8.0.4, ReSaver  
**Quest:** `DN119Fight [QUST:000BACBC]` — Rotten Landfill Fight Controller  
**Script:** `DN119FightController.pex`

> [!WARNING]
> This guide documents a **specific, reproduced save-state problem** and the script-level fix that was tested successfully on that setup. It is not a recommendation to replace vanilla scripts blindly. Confirm that your Papyrus log shows the same quest, script and failure pattern before applying anything.

## Symptom

The Papyrus log repeatedly reports:

```text
Cannot call IsDead() on a None object
[DN119Fight (000BACBC)].dn119fightcontroller.OnTimer()
```

In the tested save, this occurred continuously even though the quest was already stopped.

The important characteristics were:

- quest: `DN119Fight [000BACBC]`;
- quest state: **Stopped**;
- current stage: **255**;
- aliases `Molerat01` through `Molerat04`: **NONE**;
- the controller script instance was still attached to the quest;
- no persistent active thread or suspended stack was visible in ReSaver;
- the same error reappeared in Papyrus logs across sessions.

## What the Script Was Doing

The vanilla `DN119FightController` starts a one-second timer after the respawn death counter reaches its limit.

The original `OnTimer()` logic is effectively:

```papyrus
Event OnTimer(Int timer)
  If Enemy01.GetActorRef().IsDead() && Enemy02.GetActorRef().IsDead() && Enemy03.GetActorRef().IsDead() && Enemy04.GetActorRef().IsDead()
    Self.SetStage(EndFightStageToSet)
  Else
    Self.StartTimer(1.0, 0)
  EndIf
EndEvent
```

The problem is straightforward: if one or more aliases have already been cleared, `GetActorRef()` returns `None`.

The script then attempts:

```papyrus
None.IsDead()
```

which produces the Papyrus error.

Because the monitor is based on a one-second timer, the error can become persistent log spam.

## Verification Before Patching

### 1. Confirm the quest record in xEdit

Search for:

```text
000BACBC
```

The tested record was:

```text
DN119Fight [QUST:000BACBC]
[Rotten Landfill Fight Controller]
```

Only `Fallout4.esm` and the Unofficial Fallout 4 Patch touched the quest record in the tested load order. No unrelated gameplay mod overrode the quest.

### 2. Check the live quest state

In the Fallout 4 console:

```text
sqv DN119Fight
```

In the reproduced case, the output showed:

```text
Enabled?       No
State:         Stopped
Current stage: 255

Scavenger01 -> NONE
Scavenger02 -> NONE
Molerat01   -> NONE
Molerat02   -> NONE
Molerat03   -> NONE
Molerat04   -> NONE
```

This matters because it proves that the quest and aliases had already been cleaned up while the timer callback was still capable of firing.

### 3. Check ReSaver before deleting anything

Search for:

```text
dn119fightcontroller
```

In the tested save, ReSaver showed one script instance attached to:

```text
Fallout4.esm:000BACBC
```

and explicitly reported that the instance was attached to an object from `Fallout4.esm`.

It also showed zero threads attached to that instance at the moment the save was inspected.

> [!IMPORTANT]
> Do **not** assume that a generic ReSaver warning about an unattached script instance is this controller. In the tested save, the recurring generic unattached-instance warning was unrelated to `DN119FightController`.

The controller itself was still correctly attached, so deleting the script instance from the save would have been unnecessarily aggressive.

## Extracting the Vanilla Script

The tested OldGen installation used a Stock Game copy.

Open:

```text
Fallout4 - Misc.ba2
```

and extract only:

```text
Scripts\DN119FightController.pex
```

Do not overwrite the game archive.

## Decompiling with Champollion

Place the PEX next to `Champollion.exe` and run PowerShell from that folder:

```powershell
.\Champollion.exe DN119FightController.pex
```

This produces:

```text
DN119FightController.psc
```

## The Targeted Fix

Replace only the `OnTimer()` event with a guarded version:

```papyrus
Event OnTimer(Int timer)
  Actor Enemy01Act = Enemy01.GetActorRef()
  Actor Enemy02Act = Enemy02.GetActorRef()
  Actor Enemy03Act = Enemy03.GetActorRef()
  Actor Enemy04Act = Enemy04.GetActorRef()

  If Enemy01Act == None || Enemy02Act == None || Enemy03Act == None || Enemy04Act == None
    Return
  EndIf

  If Enemy01Act.IsDead() && Enemy02Act.IsDead() && Enemy03Act.IsDead() && Enemy04Act.IsDead()
    Self.SetStage(EndFightStageToSet)
  Else
    Self.StartTimer(1.0, 0)
  EndIf
EndEvent
```

### Why this works

If all four aliases still resolve to actors, the original fight-monitor behavior remains unchanged.

If any alias has already been cleared:

- the event exits immediately;
- `IsDead()` is never called on `None`;
- most importantly, the one-second timer is **not restarted**.

This lets the stale timer die naturally after its next callback.

## Champollion Decompilation Caveat

The tested decompiled source contained lines like:

```papyrus
Self.RegisterForRemoteEvent(Enemy01 as ScriptObject, "OnDeath")
```

The Fallout 4 Papyrus compiler rejected them with:

```text
OnDeath is not an event on scriptobject or one if its parents
```

Removing the explicit `as ScriptObject` cast fixed compilation:

```papyrus
Self.RegisterForRemoteEvent(Enemy01, "OnDeath")
Self.RegisterForRemoteEvent(Enemy02, "OnDeath")
Self.RegisterForRemoteEvent(Enemy03, "OnDeath")
Self.RegisterForRemoteEvent(Enemy04, "OnDeath")
```

This was a decompilation/recompilation issue, not part of the timer bug itself.

## Compiling

Place the corrected source where the Creation Kit compiler can see it, for example:

```text
Scripts\Source\User\DN119FightController.psc
```

Compile it with the Fallout 4 Papyrus compiler.

The output must be:

```text
Scripts\DN119FightController.pex
```

## MO2 Packaging

A minimal MO2 mod is enough:

```text
DN119Fight Controller Timer Fix
└─ Scripts
   └─ DN119FightController.pex
```

The source can optionally be kept for reference:

```text
Scripts\Source\User\DN119FightController.psc
```

No ESP or ESL is required.

The loose PEX overrides the copy inside the vanilla BA2 at runtime.

Use MO2's **Data** tab to confirm that the winning `Scripts\DN119FightController.pex` comes from the fix mod.

## Validation

Use a dedicated test save.

1. Enable the script-fix mod.
2. Launch Fallout 4 through MO2.
3. Load the affected save.
4. Stay in game for at least one to two minutes.
5. Save once if desired.
6. Exit Fallout 4 completely.
7. Inspect the newly generated `Papyrus.0.log`.

The fix is validated if there are no new occurrences of:

```text
DN119Fight
dn119fightcontroller
Cannot call IsDead() on a None object
```

In the tested case, the error disappeared completely after installing the patched PEX.

## What Was Deliberately Not Done

The successful procedure did **not** require:

- `resetquest DN119Fight`;
- `stopquest DN119Fight`;
- deleting the controller instance in ReSaver;
- running a global unattached-instance cleanup;
- editing `Fallout4.esm`;
- creating an ESP/ESL;
- modifying the Unofficial Fallout 4 Patch.

This was intentional. The quest itself was already in a coherent stopped/cleaned state. The fault was the stale timer callback dereferencing aliases that no longer contained actors.

## Rollback

To revert:

1. exit Fallout 4;
2. disable or remove the MO2 script-fix mod;
3. relaunch the game.

The vanilla PEX inside `Fallout4 - Misc.ba2` will become active again.

Keep the pre-fix save until the replacement script has been validated over multiple normal gameplay sessions.

## Scope and Limitations

This fix addresses the reproduced `DN119FightController.OnTimer()` / `IsDead(None)` failure only.

Do not use it as a generic cure for Papyrus errors involving:

- other quests;
- unrelated `None` references;
- missing scripts;
- broken properties;
- suspended stacks;
- save corruption.

A Papyrus log can contain many unrelated warnings and errors. The disappearance of this specific error proves only that this specific timer problem was resolved.

## Sharing and Support Notice

This is independent community documentation based on a reproduced Fallout 4 troubleshooting session.

No Bethesda, Unofficial Fallout 4 Patch, Champollion, ReSaver, xEdit, Creation Kit, or third-party binaries are redistributed here.

Users remain responsible for backups, version checks, testing, and rollback preparation.
