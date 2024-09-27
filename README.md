#  🍰 Slicer Selector


Choose which 3d Printer Slicer software to use on-the-fly

![](/img/example1.png)


## 💿 Installation

1. Download git repo
2. Copy `SlicerSelector.app` to `/Applications` directory


Optionally right click a .stl and .3mf file and chose 'SlicerSelector' as the default application

![](./img/default_app.png)


## How it works

SlicerSelector looks at `/Applications` directory for one of the following slicers. 
Is your prefered slicer not shown? Pull requests welcome. 

```
	set slicerList to {"BambuStudio", "PrusaSlicer", "SuperSlicer", "OrcaSlicer", "Cura"}
```


## 💻 Development

1. Modify [SlicerSelector.app/Contents/Resources/Scripts/main.scpt](./SlicerSelector.app/Contents/Resources/Scripts/main.scpt)


## 🥅 Goals

- Rewrite this as a native OSX Application and include in appstore or homebrew
- Windows support

## 🐛 Known Bugs

- Prusa Slicer will not be detected if it is installed to `/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app`. Move the slicer to `/Applications`

## Notes

Inspiration for this application comes from the popular browser switcher [Velja](https://sindresorhus.com/velja)
