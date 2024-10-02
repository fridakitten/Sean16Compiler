//
// main.c
// Sean16Compiler
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libasmfile.h>
#include <code.h>

// CPU
#define EXT   0x00
#define STO   0x01

uint8_t rval(const char *input) {
    int base_value = 0;
    if (input[0] == 'R') {
        printf("R");
        base_value = 0;
        input++;  // Skip the 'R'
    } else {
        printf("B");
        base_value = 64;
    }

    int number = atoi(input);
    return (uint8_t)(number + base_value);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    char *(*raw)[MAX_WORDS] = read_file(argv[1]);
    uint8_t array[MAX_LINES][MAX_WORDS] = {0};

    printf("[*] compile\n");
    for (int i = 0; i < MAX_LINES; i++) {
        if (raw[i] == NULL || raw[i][0] == NULL) {
            break; 
        }

        if (strcmp("EXT", raw[i][0]) == 0) {
            array[i][0] = EXT;
            printf("+");
        }
        if (strcmp("STO", raw[i][0]) == 0) {
            array[i][0] = STO;
            printf("+");
        }

        for (int j = 0; j < 5; j++) {
            if (raw[i][j + 1] != NULL) {
                array[i][j + 1] = rval(raw[i][j + 1]);
            } else {
                array[i][j + 1] = 0;
            }
        }
    }
    printf("\n");
    printf("[*] done :3\n");

    // Store compiled code
    // storeasm("output.bin", array, MAX_LINES * MAX_WORDS);

    return 0;
}
