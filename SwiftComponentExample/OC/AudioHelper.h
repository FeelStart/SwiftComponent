//
//  AudioHelper.h
//  OC
//
//  Created by Jingfu Li on 2024/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioHelper : NSObject

/// 将 MP3 文件转换为 PCM 文件
+ (BOOL)covertMP3ToPCM:(NSString *)mp3Path pcmFile:(NSString *)pcmPath;

@end

NS_ASSUME_NONNULL_END
