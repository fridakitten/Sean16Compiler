//
// libasmfile.h
// Sean16Compiler
//

#include <stdio.h>
#include <stdint.h>

uint8_t** readasm(const char *filename);
void storeasm(const char *filename, uint8_t *values, size_t size);
