//
//  MP3Util.c
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#include "MP3Util.h"
#include <stdlib.h>
#include <math.h>

size_t mp3_convertCharsToIngetal(uint8_t *value, size_t size, uint8_t mask)
{
    size_t result = 0;
    for (size_t i = 0; i < size; i++) {
        result += (value[i] & mask) * (pow(16, size - i - 1));
    }

    return result;
}

size_t mp3_powCharsToIngetal(uint8_t *value, size_t size, uint8_t exponent)
{
    size_t result = 0;
    for (size_t i = 0; i < size; i++) {
        result += value[i] * (pow(exponent, size - i - 1));
    }

    return result;
}

char *mp3_uintsToChars(uint8_t *value, size_t size)
{
    char result[size];
    for (size_t i = 0; i < size; i++) {
        result[i] = value[i];
    }

    return result;
}
