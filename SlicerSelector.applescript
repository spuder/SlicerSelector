var app = Application.currentApplication();
app.includeStandardAdditions = true;

function run() {
    handleSlicerSelection(null);
}

function open(files) {
    var f = files[0];
    handleSlicerSelection(typeof f === "string" ? f : f.toString());
}

function handleSlicerSelection(theFilePath) {
    var slicerList = [
        "AnkerMake Studio", "AnyCubic Slicer", "AnyCubic Slicer Next",
        "BambuStudio", "Blender", "ChiTuBox", "Creality Print",
        "ElegooSlicer", "eufyMake Studio", "IdeaMaker", "LycheeSlicer",
        "MatterControl", "OpenSCAD", "Orca-Flashforge", "OrcaSlicer",
        "Proton Workshop", "PrusaSlicer", "Simplify3D", "Slic3r", "Slicer",
        "Snapmaker Luban", "Snapmaker Orca", "SuperSlicer", "ThumbHost3mf",
        "UltiMaker Cura", "JusPrin"
    ];

    var installedSlicers = [];
    for (var i = 0; i < slicerList.length; i++) {
        try {
            app.doShellScript("ls " + quotedForm(getAppPath(slicerList[i])));
            installedSlicers.push(slicerList[i]);
        } catch(e) {}
    }

    if (installedSlicers.length === 0) {
        app.displayDialog("No supported slicers found in the Applications folder.", {
            buttons: ["OK"], defaultButton: "OK"
        });
        return;
    }

    var defaultSlicer = "BambuStudio";
    var defaultItems = installedSlicers.indexOf(defaultSlicer) !== -1
        ? [defaultSlicer]
        : [installedSlicers[0]];

    var selectedSlicer = app.chooseFromList(installedSlicers, {
        withPrompt: "Select a slicer to open:",
        defaultItems: defaultItems
    });
    if (!selectedSlicer) return;

    var chosenSlicer = selectedSlicer[0];

    var slicerProcesses;
    try {
        slicerProcesses = app.doShellScript(
            "ps -ax -o pid,command | grep -i " + quotedForm(chosenSlicer) + " | grep -v grep"
        );
    } catch(e) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var processMapping = [];
    var lines = slicerProcesses.split("\n");
    for (var j = 0; j < lines.length; j++) {
        var m = lines[j].trim().match(/^(\d+)\s+(.+)$/);
        if (m) processMapping.push([m[1], m[2]]);
    }

    if (processMapping.length === 0) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var choiceList = [chosenSlicer + " - (New)"];
    for (var k = 0; k < processMapping.length; k++) {
        choiceList.push(processMapping[k][0] + " - " + processMapping[k][1]);
    }

    var userChoice = app.chooseFromList(choiceList, {
        withPrompt: "Select a process or start a new one:",
        defaultItems: [choiceList[0]]
    });
    if (!userChoice) return;

    var chosenProcess = userChoice[0];
    if (chosenProcess.endsWith(" - (New)")) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var chosenPID = parseInt(chosenProcess.split(" ")[0], 10);
    try {
        var sysEvents = Application("System Events");
        var procs = sysEvents.processes();
        for (var p = 0; p < procs.length; p++) {
            if (procs[p].unixId() === chosenPID) {
                procs[p].frontmost = true;
                break;
            }
        }
        if (theFilePath) {
            app.doShellScript("open -a " + quotedForm(chosenSlicer) + " --args " + quotedForm(theFilePath));
        }
    } catch(e) {
        app.displayDialog("Error: " + e.message, { buttons: ["OK"], defaultButton: "OK" });
    }
}

function startNewSlicerInstance(chosenSlicer, theFilePath) {
    var slicerPath = getAppPath(chosenSlicer);
    try {
        if (theFilePath) {
            app.doShellScript("open -n -a " + quotedForm(slicerPath) + " " + quotedForm(theFilePath));
        } else {
            app.doShellScript("open -n -a " + quotedForm(slicerPath));
        }
    } catch(e) {
        app.displayDialog("Error: " + e.message, { buttons: ["OK"], defaultButton: "OK" });
    }
}

function getAppPath(slicerName) {
    if (slicerName === "AnyCubic Slicer")      return "/Applications/AnycubicSlicer.app";
    if (slicerName === "AnyCubic Slicer Next") return "/Applications/AnycubicSlicerNext.app";
    if (slicerName === "Creality Print")       return "/Applications/Creality Print.app";
    if (slicerName === "Snapmaker Luban")      return "/Applications/Snapmaker Luban.app";
    if (slicerName === "Snapmaker Orca")       return "/Applications/Snapmaker Orca.app";
    return "/Applications/" + slicerName + ".app";
}

function quotedForm(str) {
    return "'" + str.replace(/'/g, "'\\''") + "'";
}
