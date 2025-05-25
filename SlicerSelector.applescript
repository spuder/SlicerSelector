on run
    handleSlicerSelection(missing value)
end run

on open theFile
    handleSlicerSelection(theFile)
end open

on handleSlicerSelection(theFile)
    set slicerList to {"AnkerMake Studio", "BambuStudio", "Blender", "ChiTuBox", "IdeaMaker", "LycheeSlicer", "MatterControl", "OpenSCAD", "OrcaSlicer", "Proton Workshop", "PrusaSlicer", "Simplify3D", "Slic3r", "Slicer", "SuperSlicer", "ThumbHost3mf", "UltiMaker Cura", "JusPrin"}
    set installedSlicers to {}

    -- Check for installed slicers
    repeat with slicerName in slicerList
        set appPath to "/Applications/" & slicerName & ".app"
        try
            do shell script "ls " & quoted form of appPath
            set end of installedSlicers to slicerName
        on error
            -- Slicer not found, skip
        end try
    end repeat

    if (count of installedSlicers) is 0 then
        display dialog "No supported slicers found in the Applications folder." buttons {"OK"} default button "OK"
    else
        -- Prompt user to select a slicer
        set defaultSlicer to "BambuStudio"
        if defaultSlicer is in installedSlicers then
            set defaultItems to {defaultSlicer}
        else
            set defaultItems to (item 1 of installedSlicers)
        end if
        set selectedSlicer to choose from list installedSlicers with prompt "Select a slicer to open:" default items defaultItems

        if selectedSlicer is not false then
            set chosenSlicer to item 1 of selectedSlicer

            -- Search for running processes
            try
                set slicerProcesses to do shell script "ps -ax -o pid,command | grep -i " & quoted form of chosenSlicer & " | grep -v grep"
            on error
                startNewSlicerInstance(chosenSlicer, theFile)
                return
            end try

            -- Parse process lines
            set processLines to paragraphs of slicerProcesses
            set processMapping to {}
            repeat with processLine in processLines
                set pid to first word of processLine
                set appPath to text ((offset of pid in processLine) + (length of pid) + 1) thru -1 of processLine
                set end of processMapping to {pid, appPath}
            end repeat

            -- Show process selection dialog
            if (count of processMapping) > 0 then
                set choiceList to {chosenSlicer & " - (New)"}
                repeat with processInfo in processMapping
                    set end of choiceList to (item 1 of processInfo) & " - " & (item 2 of processInfo)
                end repeat

                set userChoice to choose from list choiceList with prompt "Select a process or start a new one:" default items (item 1 of choiceList)

                if userChoice is not false then
                    set chosenProcess to item 1 of userChoice
                    if chosenProcess ends with " - (New)" then
                        startNewSlicerInstance(chosenSlicer, theFile)
                    else
					set chosenPID to first word of chosenProcess
					if theFile is not missing value then
						try
							tell application "System Events"
								set targetProcess to the first process whose unix id is (chosenPID as integer)
								set frontmost of targetProcess to true
								repeat until frontmost of targetProcess is true
									delay 0.1
								end repeat
							end tell

							-- Open the file in the existing process
							set theFilePath to POSIX path of theFile
							do shell script "open -a " & quoted form of chosenSlicer & " --args " & quoted form of theFilePath
                            on error errMsg
                                display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
                            end try
                        else
                            try
                                tell application "System Events"
                                    set frontmost of the first process whose unix id is chosenPID to true
                                end tell
                            on error errMsg
                                display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
                            end try
                        end if
                    end if
                end if
            else
                startNewSlicerInstance(chosenSlicer, theFile)
            end if
        end if
    end if
end handleSlicerSelection

on startNewSlicerInstance(chosenSlicer, theFile)
    set slicerPath to "/Applications/" & chosenSlicer & ".app"
    if theFile is not missing value then
        try
            do shell script "open -n -a " & quoted form of slicerPath & " " & quoted form of (POSIX path of theFile)
        on error errMsg
            display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
        end try
    else
        try
            do shell script "open -n -a " & quoted form of slicerPath
        on error errMsg
            display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
        end try
    end if
end startNewSlicerInstance