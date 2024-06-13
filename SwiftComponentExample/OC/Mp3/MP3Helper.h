//
//  MP3Helper.h
//  OC
//
//  Created by Jingfu Li on 2024/6/13.
//

#ifndef MP3Helper_h
#define MP3Helper_h

#ifdef __cplusplus
extern "C" {
#endif

#include "MP3Defines.h"
#include <stdio.h>

int mp3_get_tag2(FILE *file, MP3TAG2 *tag);
size_t mp3_get_tag2_size(MP3TAG2 tag);
size_t mp3_get_tag2_header_size(MP3TAG2 tag);
void mp3_tag2_dump(FILE *file, MP3TAG2 tag);
void mp3_tag3_identifier_detail(MP3TAG2FrameHeader header, char *identifier);

#ifdef __cplusplus
}
#endif

#endif /* MP3Helper_h */
