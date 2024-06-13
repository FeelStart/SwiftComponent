//
//  MP3Util.c
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#include "MP3Util.h"
#include <stdlib.h>

size_t mp3_convertCharArrayToIngetal(uint8_t *value, size_t size, size_t mask)
{
    size_t result = 0;
    for (size_t i = 0; i < size; i++) {
        result += value[i] & mask * (16 ^ (size - i - 1));
    }

    return result;
}
