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
        let buffers: [AudioQueueBuffer]
    }
}
