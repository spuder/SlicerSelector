ObjC.import('AppKit');
ObjC.import('Foundation');

function run() {
    handleSlicerSelection(null);
}

function open(files) {
    var f = files[0];
    handleSlicerSelection(typeof f === "string" ? f : f.toString());
}

function showPicker(items, prompt, defaultItem) {
    $.NSApplication.sharedApplication.activateIgnoringOtherApps(true);

    var alert = $.NSAlert.alloc.init;
    alert.messageText = $(prompt);
    alert.addButtonWithTitle($('OK'));
    alert.addButtonWithTitle($('Cancel'));

    var popup = $.NSPopUpButton.alloc.initWithFramePullsDown($.NSMakeRect(0, 0, 300, 26), false);
    items.forEach(function(item) { popup.addItemWithTitle($(item)); });
    if (defaultItem) popup.selectItemWithTitle($(defaultItem));
    alert.accessoryView = popup;

    if (alert.runModal === $.NSAlertFirstButtonReturn) {
        return ObjC.unwrap(popup.titleOfSelectedItem);
    }
    return null;
}

function showAlert(message) {
    $.NSApplication.sharedApplication.activateIgnoringOtherApps(true);
    var alert = $.NSAlert.alloc.init;
    alert.messageText = $(message);
    alert.addButtonWithTitle($('OK'));
    alert.runModal;
}

function fileExists(path) {
    return $.NSFileManager.defaultManager.fileExistsAtPath($(path));
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

    var installedSlicers = slicerList.filter(function(s) {
        return fileExists(getAppPath(s));
    });

    if (installedSlicers.length === 0) {
        showAlert("No supported slicers found in the Applications folder.");
        return;
    }

    var defaultSlicer = installedSlicers.indexOf("BambuStudio") !== -1 ? "BambuStudio" : installedSlicers[0];
    var chosenSlicer = showPicker(installedSlicers, "Select a slicer to open:", defaultSlicer);
    if (!chosenSlicer) return;

    var shell = Application.currentApplication();
    shell.includeStandardAdditions = true;

    var slicerProcesses;
    try {
        slicerProcesses = shell.doShellScript(
            "ps -ax -o pid,command | grep -i " + quotedForm(chosenSlicer) + " | grep -v grep"
        );
    } catch(e) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var processMapping = [];
    slicerProcesses.split("\n").forEach(function(line) {
        var m = line.trim().match(/^(\d+)\s+(.+)$/);
        if (m) processMapping.push([m[1], m[2]]);
    });

    if (processMapping.length === 0) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var choiceList = [chosenSlicer + " - (New)"];
    processMapping.forEach(function(p) { choiceList.push(p[0] + " - " + p[1]); });

    var chosenProcess = showPicker(choiceList, "Select a process or start a new one:", choiceList[0]);
    if (!chosenProcess) return;

    if (chosenProcess.endsWith(" - (New)")) {
        startNewSlicerInstance(chosenSlicer, theFilePath);
        return;
    }

    var chosenPID = parseInt(chosenProcess.split(" ")[0], 10);
    try {
        var sysEvents = Application("System Events");
        var procs = sysEvents.processes();
        for (var i = 0; i < procs.length; i++) {
            if (procs[i].unixId() === chosenPID) {
                procs[i].frontmost = true;
                break;
            }
        }
        if (theFilePath) {
            shell.doShellScript("open -a " + quotedForm(chosenSlicer) + " --args " + quotedForm(theFilePath));
        }
    } catch(e) {
        showAlert("Error: " + e.message);
    }
}

function startNewSlicerInstance(chosenSlicer, theFilePath) {
    var shell = Application.currentApplication();
    shell.includeStandardAdditions = true;
    var slicerPath = getAppPath(chosenSlicer);
    try {
        if (theFilePath) {
            shell.doShellScript("open -n -a " + quotedForm(slicerPath) + " " + quotedForm(theFilePath));
        } else {
            shell.doShellScript("open -n -a " + quotedForm(slicerPath));
        }
    } catch(e) {
        showAlert("Error: " + e.message);
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
