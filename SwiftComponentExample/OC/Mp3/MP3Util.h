//
//  MP3Util.h
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#ifndef MP3Util_h
#define MP3Util_h

#include <stdio.h>

/// eg: mask = 0b11111111
size_t mp3_convertCharsToIngetal(uint8_t *value, size_t size, uint8_t exponent);

size_t mp3_powCharsToIngetal(uint8_t *value, size_t size, uint8_t exponent);

void mp3_uintsToChars(uint8_t *value, char *result);

void mp3_print(uint8_t *value);

#endif /* MP3Util_h */
