//
// main.c
// Sean16Compiler
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libasmfile.h>
#include <code.h>

// CPU - Main
#define EXT   0x00
#define STO   0x01
#define ADD   0x02
#define SUB   0x03
#define MUL   0x04
#define DIV   0x05
#define DSP   0x06     //DEBUG INSTRUCTION
#define JMP   0x07
#define IFQ   0x08

// CPU - Peripherals
#define MUS   0x09

// CPU - Clocl
#define SSP   0xB0
#define NSP   0xB1  

// GPU - Main
#define GPX   0xA0
#define GDL   0xA1
#define GDC   0xA2
#define GCS   0xA3
#define GGC   0xA4

uint8_t rval(const char *input) {
    int base_value = 0;
    if (input[0] == 'R') {
        //printf("R");
        base_value = 0;
        input++;  // Skip the 'R'
    } else {
        //printf("B");
        base_value = 65;
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
            //printf("+");
        } else if (strcmp("STO", raw[i][0]) == 0) {
            array[i][0] = STO;
            //printf("+");
        } else if (strcmp("ADD", raw[i][0]) == 0) {
            array[i][0] = ADD;
            //printf("+");
        } else if (strcmp("SUB", raw[i][0]) == 0) {
            array[i][0] = SUB;
            //printf("+");
        } else if (strcmp("MUL", raw[i][0]) == 0) {
            array[i][0] = MUL;
            //printf("+");
        } else if (strcmp("DIV", raw[i][0]) == 0) {
            array[i][0] = DIV;
            //printf("+");
        } else if (strcmp("DSP", raw[i][0]) == 0) {
            array[i][0] = DSP;
            //printf("+");
        } else if (strcmp("JMP", raw[i][0]) == 0) {
            array[i][0] = JMP;
            //printf("+");
        } else if (strcmp("IFQ", raw[i][0]) == 0) {
            array[i][0] = IFQ;
            //printf("+");
        } else if (strcmp("MUS", raw[i][0]) == 0) {
            array[i][0] = MUS;
            //printf("+");
        } else if (strcmp("SSP", raw[i][0]) == 0) {
            array[i][0] = SSP;
            //printf("+");
        } else if (strcmp("NSP", raw[i][0]) == 0) {
            array[i][0] = NSP;
            //printf("+");
        } else if (strcmp("GPX", raw[i][0]) == 0) {
            array[i][0] = GPX;
            //printf("+");
        } else if (strcmp("GDL", raw[i][0]) == 0) {
            array[i][0] = GDL;
            //printf("+");
        } else if (strcmp("GDC", raw[i][0]) == 0) {
            array[i][0] = GDC;
            //printf("+");
        } else if (strcmp("GCS", raw[i][0]) == 0) {
            array[i][0] = GCS;
            //printf("+");
        } else if (strcmp("GGC", raw[i][0]) == 0) {
            array[i][0] = GGC;
            //printf("+");
        }

        for (int j = 0; j < 5; j++) {
            if (raw[i][j + 1] != NULL) {
                array[i][j + 1] = rval(raw[i][j + 1]);
            } else {
                array[i][j + 1] = 0;
            }
        }

        printf("0x%02X 0x%02X 0x%02X 0x%02X 0x%02X 0x%02X\n", array[i][0], array[i][1], array[i][2], array[i][3], array[i][4], array[i][5]);
    }
    printf("[*] bindto output.bin\n");
    
    uint8_t binmap[MAX_LINES * MAX_WORDS];
    for (int i = 0; i < MAX_LINES; i++) {
        for (int j = 0; j < MAX_WORDS; j++) {
            binmap[i * MAX_WORDS + j] = array[i][j];  // Correct index mapping
        }
    }

    // Store compiled code
    storeasm("output.bin", binmap, MAX_LINES * MAX_WORDS);

    printf("[*] done :3\n");

    return 0;
}
