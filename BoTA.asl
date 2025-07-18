state("Ballest-Win64-Shipping") {
    int value : "Ballest-Win64-Shipping.exe", 0x72BD8E8;
    float levelTime : 0;
}

init {
    vars.addr = 0;
    vars.lastTime = 0.0f;
    vars.framesUnchanged = 0;
    vars.splitTriggered = false;
    print("Connected to Ballest.");
}

update {
    if (vars.addr == 0) {
        // Scan memory to find the dynamic address [rcx + 0x0C] written by the movss instruction
        var results = memory.GetAddresses("Ballest-Win64-Shipping.exe+34ED512", 64);
        foreach (var result in results) {
            vars.addr = memory.ReadPointer(result + 1); // Get RCX value
            if (vars.addr != 0) {
                vars.addr += 0x0C; // Apply the +0x0C offset from instruction
                print("Found dynamic time address: 0x" + vars.addr.ToString("X"));
                break;
            }
        }
    }

    if (vars.addr != 0) {
        current.levelTime = memory.ReadFloat(vars.addr);

        // Compare with last frame's time
        if (current.levelTime == vars.lastTime) {
            vars.framesUnchanged += 1;
        } else {
            vars.framesUnchanged = 0;
            vars.splitTriggered = false;
        }

        vars.lastTime = current.levelTime;

        // Debug output
        print("Time: " + current.levelTime + " | Unchanged: " + vars.framesUnchanged);
    }
}

split {
    if (!vars.splitTriggered && current.levelTime > 0.0 && vars.framesUnchanged >= 30) {
        vars.splitTriggered = true;
        return true;
    }
    return false;
}

isLoading {
    return false;
}