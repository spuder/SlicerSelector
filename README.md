#  🍰 Slicer Selector

Slicer Selector becomes your default app for opening `.stl` and `.3mf` files. 
Upon opening a file, it will auto discover all your installed slicers, and prompt you which one to use. 


![](/img/example2.png)

Select prefered slicer while opening file

![](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGtjcXJ2cTR2Z3pxbTA5dHhkdnQzOTcyaGJldW0wd2VsMW1qd2gycyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/t45i9kYxAKKfIhQS4r/giphy.gif)


Select prefered slicer while exporting from CAD

![](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjJwdnZwcXJqOXhibGNxNHoxOGh4cjQ3bHBxY3hkdXozdnQweHptNSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/SZchQgYqvfLa7yySHS/giphy.gif)

## 💿 Installation

The easiest method to install is using [homebrew](https://brew.sh)  

```bash
brew tap spuder/SlicerSelector
brew install slicer-selector
```

Once complete there will be a new app at `/Applications/SlicerSelector.app`

SlicerSelector will be the default app to open `.stl` and `.3mf` files


## ⚙️ How it works

SlicerSelector looks for popular slicers in the  `/Applications`. When a `.3mf` or `.stl` file is opened it redirects to the chosen app.

## ❔ Why would you want this? 

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
