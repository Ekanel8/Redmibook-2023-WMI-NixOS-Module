# WMI Driver for Redmi Book Pro

NixOS module for the WMI driver from [vrolife/modern_laptop](https://github.com/vrolife/modern_laptop), enabling top buttons support for:

- **Redmi Book Pro 15 2023** (TESTED)
- **Redmi Book Pro 14 2022** 
- **Redmi Book Pro 15 2022** 
- **Redmi Book Pro 15 2021** 

## What is it? 

Self-sufficient .nix module for wmi driver

## Installation

Add this module to your NixOS configuration:

```nix
# configuration.nix 
{
  imports = [
    ./wmi.nix  # path to this file
  ];

  # P.S The driver is enabled by default. 
  # You can change this either in the wmi.nix file itself or use 'services.redmibook.wmi.enable = false;'
}
```

## Function Key Mappings

| Key Combination | WMI Command | Parameters/Notes |
|-----------------|-------------|------------------|
| **Fn + ESC** | `{ 0x01, 0x07, Lock/Unlock }` | `Locked = 0` (F1 = Mute)<br>`Unlocked = 1` |
| **Fn + F6** | `{ 0x01, 0x01 }` | |
| **Fn + F7** | `{ 0x01, 0x02 }` | |
| **Fn + F8** | `{ 0x01, 0x03 }` | |
| **Fn + F9** | `{ 0x01, 0x1B }` | |
| **Fn + F10** | `{ 0x01, 0x05, Level }` | **Keyboard Backlight**<br>`Level = 0x00, 0x80, 0x05, 0x0A` |
| **Xiao Ai - DOWN** | `{ 0x01, 0x18, 0x01 }` | Also generates scancode `72` |
| **Xiao Ai - UP** | `{ 0x01, 0x19, 0x01 }` | Also generates scancode `72` |
| **Caps Lock** | `{ 0x01, 0x09, CPLK }` | `\\_SB.PCI0.LPC0.EC0.FUNR (0x19)` |

## Usage Example

> Now you can correctly recognize the calls made by extra buttons (for example, using the [wev](https://github.com/jwrdegoede/wev) utility) and use them for binds in your environment

## Source
Based on [vrolife/modern_laptop](https://github.com/vrolife/modern_laptop) WMI driver (`.c`).

TODO: flake
