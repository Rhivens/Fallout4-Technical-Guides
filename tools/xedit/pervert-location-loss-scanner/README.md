# Pervert Location Loss Scanner

[Back to xEdit tools](../README.md)

**Release:** v6  
**Status:** Tested read-only tool  
**Tested with:** FO4Edit 4.1.5  
**Target plugin:** `pervert.esp`  
**Game:** Fallout 4

## Purpose

Pervert Location Loss Scanner is a read-only xEdit script that detects location references defined by `pervert.esp` but lost in the winning override.

A city, settlement, interior, or location overhaul loaded after Pervert may overwrite one of the same records and replace or remove location data required by the mod.

The scanner checks only:

- `XLRL - Location Reference`;
- `XLCN - Location`.

It reports conflicts. It does not modify plugins and does not generate a patch.

## Download

Download [Pervert_Location_Loss_Scanner_v6.pas](Pervert_Location_Loss_Scanner_v6.pas).

Place the file in the xEdit scripts directory, normally:

```text
FO4Edit\Edit Scripts\
```

## Before Running

1. Back up the current load order.
2. Load the complete active Fallout 4 load order in FO4Edit.
3. Allow xEdit to finish loading and checking references.
4. Confirm that `pervert.esp` is active.
5. Do not select the entire load order: the script is intended to process the records from `pervert.esp`.

## Usage

1. Select `pervert.esp` in the left pane.
2. Right-click it and choose **Apply Script**.
3. Select `Pervert_Location_Loss_Scanner_v6`.
4. Run the script.
5. Review the entries under `TRUE LOSSES`.

For each detected loss, the report includes:

- the affected field, `XLRL` or `XLCN`;
- the record signature;
- the source record FormID;
- its EditorID and name when available;
- the location used by Pervert;
- the location used by the winning override, or `<NO LOCATION>`;
- the source and winning plugin names.

A clean result looks like:

```text
XLRL fields lost : 0
XLCN fields lost : 0
TOTAL            : 0
```

This means that the scanner found no loss of an `XLRL` or `XLCN` value defined by the selected Pervert records in the loaded configuration.

It does not prove that the entire load order is conflict-free.

## How v6 Compares References

Earlier versions compared rendered xEdit strings or full context-dependent FormIDs and produced false positives.

Version 6 compares:

```pascal
FormID(linked) and $00FFFFFF
```

This LocalFormID comparison ignores the load-order or file-relative prefix that caused the historical false positives.

## Known Limitation

LocalFormID comparison deliberately discards the source-plugin identity contained in the upper byte.

Two genuinely different records originating from different plugins can theoretically share the same lower 24-bit value. In that situation, v6 could treat them as identical and miss a conflict.

For this reason:

- use the scanner only for its narrow Pervert `XLRL` / `XLCN` audit;
- inspect every positive result manually;
- do not present a zero result as a universal xEdit integrity check;
- revalidate the method if Pervert begins referencing a materially different set of plugins or records.

A newer comparison based on xEdit's load-order FormID is being evaluated privately and will not replace v6 until it reproduces the established positive and negative tests.

## Reference Test

A historical test used `Covenant_Mod_2_3.esp` as a known positive case.

With the Covenant overhaul active, the tested load order produced:

```text
XLRL fields lost : 19
XLCN fields lost : 0
TOTAL            : 19
```

The winning plugin either replaced `CovenantLocation` with `CommonwealthLocation` or removed the `XLRL` field.

After the overhaul was removed, the same load order produced:

```text
XLRL fields lost : 0
XLCN fields lost : 0
TOTAL            : 0
```

These counts validate the script against that specific historical configuration. They are not universal expected results.

## When to Run It

Run the scanner again after adding, removing, updating, or reordering a mod that substantially changes:

- a city;
- a settlement;
- an important interior;
- a large exterior location;
- location or cell records loaded after `pervert.esp`.

It is especially useful before generating final patches, PreVis/PreCombine outputs, or LOD for a stabilized load order.

## Correcting a Confirmed Loss

Do not move `pervert.esp` blindly to the bottom of the load order.

That could make unrelated cell, worldspace, PreVis, or PreCombine data win over the location overhaul.

For a confirmed conflict:

1. start from the current winning override;
2. preserve the location overhaul's intended data;
3. forward only the required `XLRL` and/or `XLCN` value from Pervert;
4. place that change in a dedicated compatibility patch;
5. run **Check for Errors** on the patch;
6. rerun the scanner and test the affected location in game.

The scanner identifies a candidate loss; a human must still decide whether forwarding the field is appropriate.

## Safety and Support

The script is read-only and contains no calls that create, copy, remove, or edit plugin records.

Nevertheless, users remain responsible for backups, conflict analysis, patch validation, and in-game testing. This is independent community tooling and not official xEdit or Pervert support.
