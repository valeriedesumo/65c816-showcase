## Background
[Super Mario World](https://en.wikipedia.org/wiki/Super_Mario_World) is a video game released by Nintendo in 1990. Back then, video games were released on cartridges, and the game data was stored on ROM chips. The data on these cartridges have been dumped into ROM files, which can then be played on computers by [emulating the original console with software](https://en.wikipedia.org/wiki/Video_game_console_emulator).

In addition to simply playing these ROMs, one can also "hack" them, that is, edit the game and level data, in order to create your own levels or game. For Super Mario World, there is an online community called [Super Mario World Central](https://www.smwcentral.net/?p=main), where people can share their works, tools, or levels. The community has made GUI level editors and command-line tools to facilitate the hacking of this game.

Coding custom sprites, blocks, or functions into SMW requires writing in low-level assembly code for the [65c816 processor](https://en.wikipedia.org/wiki/WDC_65C816) in the Super Nintendo. (The 65c816 is an enhanced 16-bit version of the 8-bit 65c02 used in the original NES, and Apple II computers.)

## Repository
The files here are things I've created from 2009 to 2012 for either my own SMW levels, or just to make something fun without any practical in-game uses.

These are all written for the [xkas v0.06 assembler](https://bin.smwcentral.net/u/6138/xkas.html).

## Demonstration
[In this video](https://youtu.be/_U66QgN4jDk), I demonstrate the [Guardian block](guardian.asm), the [On/Off Coin Drain effect](on_off_coin_drain.asm), the [On/Off P-Switches](on_off_p-switch.asm), and some [levelASM code](levelcode.asm) (which toggles the spotlight sprite).
