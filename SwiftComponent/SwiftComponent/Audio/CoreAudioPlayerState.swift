//
//  CoreAudioPlayerState.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/30.
//

import AudioToolbox

extension CoreAudio.Player {
    struct State {
        let bufferSize: UInt32
        /// 已完成，正在处理，已加载
        var buffers: [AudioQueueBuffer]
        var currentBufferIndex: UInt32 = 0
        var currentPacketIndex: UInt32 = 0
    }
}
