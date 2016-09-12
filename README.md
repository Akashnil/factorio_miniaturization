# factorio_miniaturization
A factorio mod that allows assembling items into packages

Adds two types of inserters, and a package item.

The minifying inserter grabs items and assembles them into a package.
The magnifying inserter undoes the process.
Packaging items allow greater denisity and throughput on the belts.
Any items can be assembled, however there is only one package item.
The package contents are remembered internally but cannot be seen until depackaged.
Dissimilar packages do not stack.
The assembling process can be composed in a hierarchy, which has additional tech requirements.
The last tech level allows infinite throughput at great cost.

This mod is highly recommended to use with Factorrissimo Mod for truly infinite scaling factories without clutter.


Changelog:

v1.0.2

Features:
- Smaller item icon to fit better with other icon sizes.
- Animation change of the inserters

Bugfixes:
- No longer removes the regular-inserter stack-size bonuses. (save games with the old version active may still be broken)
- Correctly waiting for tech level 3 before enabling infinite stacking
- Items no longer disappear from the internal cache when picked up by player or robot. May spill on floor if no space.

Credit: Prototype for helping with bugfixing.
