state("Ballest-Win64-Shipping") {
    int value : "Ballest-Win64-Shipping.exe", 0x72BD8E8;
}

init {
    print("connected");
}

update {
    print("Value at +72BD8E8: " + current.value);
}

split {
    return false;
}
