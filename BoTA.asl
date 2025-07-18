state("Ballest-Win64-Shipping") {
    int levelState : 0x72BD8E8;
}

init {
    vars.was48 = false;
    print("Connected to Ballest.");
}

update {
    if (current.levelState == 48 && !vars.was48) {
        vars.shouldSplit = true;
        vars.shouldPause = true;
    } else if (current.levelState != 48 && vars.was48) {
        vars.shouldPause = false;
    } else {
        vars.shouldSplit = false;
    }

    vars.was48 = current.levelState == 48;
}

split {
    return vars.shouldSplit;
}

isGameTimePaused {
    return vars.shouldPause;
}
