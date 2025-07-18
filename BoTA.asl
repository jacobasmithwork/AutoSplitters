state("Ballest-Win64-Shipping") {
    int levelState : 0x72BD8E8;
}

init {
    vars.was48 = false;
}

update {
    vars.shouldSplit = false;

    if (current.levelState == 48 && !vars.was48) {
        vars.shouldSplit = true;
    }

    vars.was48 = current.levelState == 48;
}

split {
    return vars.shouldSplit;
}

isLoading {
    return current.levelState == 48 || current.levelState == 0;
}
