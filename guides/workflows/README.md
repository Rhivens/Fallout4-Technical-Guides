# Generation Workflows

Procedures for rebuilding generated Fallout 4 outputs safely and in dependency order.

- [Complete output generation workflow](complete-output-generation-workflow.md) — BodySlide, NAFicator, Synthesis, Complex Item Sorter, FOLIP 8.x, TexGen and xLODGen.

## Core rule

Always isolate previous generated outputs before rebuilding. An old generated patch must not quietly become an input to its own replacement.
