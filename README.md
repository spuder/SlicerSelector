#  🍰 Slicer Selector


Choose which 3d Printer Slicer software to use on-the-fly

![](/img/example2.png)


## 💿 Installation

```bash
brew tap spuder/SlicerSelector
brew install slicer-selector
```

Once complete there will be a new app in `/Applications/SlicerSelector.app`

SlicerSelector will be the default app to open `.stl` and `.3mf` files


## How it works

SlicerSelector looks for popular slicers in the  `/Applications`. When a `.3mf` or `.stl` file is opened it redirects to the chosen app.

## Why would you want this? 

Maybe you have multiple brands of printers that need their own slicers. 
Maybe you have multiple types of printers (resin / fdm / sls) and want to easily switch between them. 

## 💻 Development


1. Edit `SlicerSelector.scpt` using Script Editor application on OSX
2. Run `make all && make install` 

Currently supported slicers are: 

```
set slicerList to {"BambuStudio", "PrusaSlicer", "SuperSlicer", "OrcaSlicer", "UltiMaker Cura", "LycheeSlicer", "Slic3r", "AnkerMake Studio", "IdeaMaker", "MatterControl", "CraftWare", "Simplify3D", "ChiTuBox", "Proton Workshop", "OpenSCAD"}
```

Pull Requests welcome. 


## 🐛 Known Bugs

- Prusa Slicer will not be detected if it is installed to `/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app`. Workaround is to move the PrusaSlicer to `/Applications`

## Notes

Inspiration for this application comes from the popular browser switcher [Velja](https://sindresorhus.com/velja)
