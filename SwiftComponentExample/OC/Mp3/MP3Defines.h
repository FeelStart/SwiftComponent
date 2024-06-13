//
//  MP3Defines.h
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/6/13.
//

/**
 * https://en.wikipedia.org/wiki/MP3
 * http://www.multiweb.cz/twoinches/mp3inside.htm
 */

#ifndef MP3Defines_h
#define MP3Defines_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/// 128 bit at end of file
typedef struct {
    /// must "TAG"
    uint8_t identifier[3];
    uint8_t songName[30];
    uint8_t artist[30];
    uint8_t album[30];
    uint8_t year[4];
    uint8_t comment[30];
    uint8_t genre;
} MP3TAG1;

/// 10 bit at begin of file
typedef struct {
    /// must "ID3"
    uint8_t identifier[3];
    uint8_t version[2];
    uint8_t flags;
    uint8_t size[4];
} MP3TAG2;

/// NOTE: After header always one byte with value 00 follows and then begins frame body. size has to include this byte.
typedef struct {
    uint8_t identifier[4];
    uint8_t size[4];
    uint8_t flags[2];
} MP3TAG2FrameHeader;

typedef struct {
    uint8_t syncWord[12];
    uint8_t version;
    uint8_t layer[2];
    uint8_t errorProtection;
    uint8_t bitRate[4];
    uint8_t frequency[2];
    uint8_t padBit;
    uint8_t privBit;
    uint8_t mode[2];
    uint8_t modeExtension[2];
    uint8_t copyright;
    uint8_t original;
    uint8_t emghasis[2];
} MP3FrameHeader;

#ifdef __cplusplus
}
#endif

#endif /* MP3Defines_h */
