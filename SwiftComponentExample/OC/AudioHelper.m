//
//  AudioHelper.m
//  OC
//
//  Created by Jingfu Li on 2024/6/12.
//

#import "AudioHelper.h"
#import <stdio.h>
#include "MP3Header.h"

/**
 * https://blog.csdn.net/Griza_J/article/details/111063506
 *
 * mp3 file
 * ID3(maybe exist) frame - frame ... frame ID(128bit maybe exist)
 * frame
 * 32 bit header
 */

@implementation AudioHelper

+ (BOOL)covertMP3ToPCM:(NSString *)mp3Path pcmFile:(NSString *)pcmPath
{
    if (mp3Path.length == 0 || pcmPath.length == 0) {
        return NO;
    }

    FILE *m_file = fopen(mp3Path.UTF8String, "rb");

    MP3TAG2 tag2;
    mp3_get_tag2(m_file, &tag2);
    mp3_tag2_dump(m_file, tag2);

    return YES;
}

@end
