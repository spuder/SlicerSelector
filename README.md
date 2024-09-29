#  🍰 Slicer Selector

Slicer Selector becomes your default app for opening `.stl`, `.3mf` files. 
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

Once complete there will be a new app at `/Applications/SlicerSelector.app`. It should be the default app for `.gcode`,`.stl`, `.3mf`, `.amf`, `.obj` files. 



## ⚙️ How it works

SlicerSelector looks for popular slicers in the  `/Applications`. When a `.3mf` or `.stl` file is opened it redirects to the chosen app.

## ❔ Why would you want this? 

Maybe you have multiple brands of printers that need their own slicers. 
Maybe you have multiple types of printers (resin / fdm / sls) and want to easily switch between them. 

## 💻 Development


The [applescript extension](https://marketplace.visualstudio.com/items?itemName=idleberg.applescript) is highly recomended for VSCode users. 

1. Edit `SlicerSelector.applescript` 
2. Run `make all && make install` 


Pull Requests welcome. 

## Notes

Inspiration for this application comes from the popular browser switcher [Velja](https://sindresorhus.com/velja)
