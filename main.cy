//
// main.c
// Sean16Compiler
//

#include <stdio.h>
#include <libasmfile.h>

int main() {
    uint8_t array[6000] = { 0x44, 0x32, 0xF0, 0x23, 0x00, 0x00};

    storeasm("output.bin", array, 6000);

    uint8_t **binmap = readasm("output.bin");

    for(int i = 0; i < 6; i++) {
        printf("%d\n", binmap[i]);
    }

    return 0;
}
