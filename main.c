//
// main.c
// Sean16Compiler
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
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

typedef struct {
    char *modified_str;
    bool had_colon;
    uint8_t offset;
} LABEL;

LABEL labelcheck(const char *input) {
    LABEL result;
    size_t len = strlen(input);

    result.had_colon = false;
    result.modified_str = (char *)malloc(len + 1);

    if (input[len - 1] == ':') {
        strncpy(result.modified_str, input, len - 1);
        result.modified_str[len - 1] = '\0';
        result.had_colon = true;
    } else {
        strcpy(result.modified_str, input);
    }

    return result;
}

uint8_t rval(const char *input) {
    int base_value = 0;
    if (input[0] == 'R') {
        base_value = 0;
        input++;
    } else {
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

    static LABEL symbols[126];
    static uint16_t sym_count = 0;
    static uint16_t roffset = 1;

    printf("[*] compile\n");
    for (int i = 0; i < MAX_LINES; i++) {
        if (raw[i] == NULL || raw[i][0] == NULL) {
            break; 
        }

        symbols[sym_count] = labelcheck(raw[i][0]);
        if(symbols[sym_count].had_colon) {
            symbols[sym_count].offset = roffset;
            printf("[#] %s => %d\n", symbols[sym_count].modified_str, symbols[sym_count].offset);
            sym_count++;
            i++;
        }

        if (strcmp("EXT", raw[i][0]) == 0) {
            array[roffset][0] = EXT;
        } else if (strcmp("STO", raw[i][0]) == 0) {
            array[roffset][0] = STO;
        } else if (strcmp("ADD", raw[i][0]) == 0) {
            array[roffset][0] = ADD;
        } else if (strcmp("SUB", raw[i][0]) == 0) {
            array[roffset][0] = SUB;
        } else if (strcmp("MUL", raw[i][0]) == 0) {
            array[roffset][0] = MUL;
        } else if (strcmp("DIV", raw[i][0]) == 0) {
            array[roffset][0] = DIV;
        } else if (strcmp("DSP", raw[i][0]) == 0) {
            array[roffset][0] = DSP;
        } else if (strcmp("JMP", raw[i][0]) == 0) {
            array[roffset][0] = JMP;
            for(int h = 0; h < 128; h++) {
                if(symbols[h].had_colon) {
                    if(strcmp(raw[i][1], symbols[h].modified_str) == 0) {
                        sprintf(raw[i][1], "%d", symbols[h].offset);
                    }
                }
            }
        } else if (strcmp("IFQ", raw[i][0]) == 0) {
            array[i][0] = IFQ;
            for(int h = 0; h < 128; h++) {
                if(symbols[h].had_colon) {
                    if(strcmp(raw[i][4], symbols[h].modified_str) == 0) {
                        sprintf(raw[i][4], "%d", symbols[h].offset);
                    }
                }
            }
        } else if (strcmp("MUS", raw[i][0]) == 0) {
            array[roffset][0] = MUS;
        } else if (strcmp("SSP", raw[i][0]) == 0) {
            array[roffset][0] = SSP;
        } else if (strcmp("NSP", raw[i][0]) == 0) {
            array[roffset][0] = NSP;
        } else if (strcmp("GPX", raw[i][0]) == 0) {
            array[roffset][0] = GPX;
        } else if (strcmp("GDL", raw[i][0]) == 0) {
            array[roffset][0] = GDL;
        } else if (strcmp("GDC", raw[i][0]) == 0) {
            array[roffset][0] = GDC;
        } else if (strcmp("GCS", raw[i][0]) == 0) {
            array[roffset][0] = GCS;
        } else if (strcmp("GGC", raw[i][0]) == 0) {
            array[roffset][0] = GGC;
        }

        for (int j = 0; j < 5; j++) {
            if (raw[i][j + 1] != NULL) {
                if(strcmp(raw[i][j + 1], ";") != 0) {
                    array[roffset][j + 1] = rval(raw[i][j + 1]);
                } else {
                    break;
                }
            } else {
                array[roffset][j + 1] = 0;
            }
        }

        printf("0x%02X 0x%02X 0x%02X 0x%02X 0x%02X 0x%02X\n", array[roffset][0], array[roffset][1], array[roffset][2], array[roffset][3], array[roffset][4], array[roffset][5]);
        roffset++;
    }
    if(strcmp(symbols[sym_count - 1].modified_str, "MAIN") == 0) {
        printf("[#] \"MAIN\" LABEL found at %d\n", symbols[sym_count - 1].offset);
        array[0][0] = JMP;
        array[0][1] = symbols[sym_count - 1].offset + 65;
    } else {
        printf("[!] \"MAIN\" LABEL not found. Make sure that its the last LABEL!\n");
        return 1;
    }

    printf("[*] bindto output.bin\n");
    
    uint8_t binmap[MAX_LINES * MAX_WORDS];
    for (int i = 0; i < MAX_LINES; i++) {
        for (int j = 0; j < MAX_WORDS; j++) {
            binmap[i * MAX_WORDS + j] = array[i][j];
        }
    }

    storeasm("output.bin", binmap, MAX_LINES * MAX_WORDS);

    printf("[*] done :3\n");

    return 0;
}
