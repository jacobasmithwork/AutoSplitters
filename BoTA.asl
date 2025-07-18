state("Ballest-Win64-Shipping") {
    int levelID : "Ballest-Win64-Shipping.exe", 0x72BD8E8; //maybe works
}

init {
    vars.lastLevel = -1;
    vars.shouldSplit = false;
}

startup {
    settings.Add("splitOnZero", true, "Split when value becomes 0");
}

update {
    int current = current.levelID;

    // Check for 0 to trigger split (only once per 0)
    if (settings["splitOnZero"] && current == 0 && vars.lastLevel != 0) {
        vars.shouldSplit = true;
    }

    vars.lastLevel = current;
}

split {
    if (vars.shouldSplit) {
        vars.shouldSplit = false;
        return true;
    }
    return false;
}

isLoading {
    // Pause timer when value is 0
    return current.levelID == 0;
}
