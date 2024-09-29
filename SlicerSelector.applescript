on run
    handleSlicerSelection(null)
end run

on open theFile
    handleSlicerSelection(theFile)
end open

on handleSlicerSelection(theFile)
    set slicerList to {"AnkerMake Studio", "BambuStudio", "Blender", "ChiTuBox", "IdeaMaker", "LycheeSlicer", "MatterControl", "OpenSCAD", "OrcaSlicer", "Proton Workshop", "PrusaSlicer", "Simplify3D", "Slic3r", "Slicer", "SuperSlicer", "UltiMaker Cura"}
    set installedSlicers to {}
    
    tell application "Finder"
        repeat with slicerName in slicerList
            if exists application file slicerName of folder "Applications" of startup disk then
                set end of installedSlicers to slicerName
            end if
        end repeat
    end tell
    
    if (count of installedSlicers) is 0 then
        display dialog "No supported slicers found in the Applications folder." buttons {"OK"} default button "OK"
    else
        set selectedSlicer to choose from list installedSlicers with prompt "Select a slicer to open:" default items (item 1 of installedSlicers)
        if selectedSlicer is not false then
            set chosenSlicer to item 1 of selectedSlicer
            if theFile is not null then
                tell application "Finder"
                    open theFile using application file chosenSlicer of folder "Applications" of startup disk
                end tell
            else
                tell application chosenSlicer
                    activate
                end tell
            end if
        end if
    end if
end handleSlicerSelection
