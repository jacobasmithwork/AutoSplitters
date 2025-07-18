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
        vars.isPaused = true;
    } else if (current.levelState != 48 && vars.was48) {
        vars.isPaused = false;
    } else {
        vars.shouldSplit = false;
    }

    vars.was48 = current.levelState == 48;
}

split {
    return vars.shouldSplit;
}

gameTime {
    if (vars.isPaused) {
        return TimeSpan.Zero; // this tells LiveSplit to pause the timer
    }
    return null; // resume game time tracking
}
