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
        let numBuffer: UInt32
        var buffers: [AudioQueueBufferRef]
        let maxPacketSize: UInt32
        let numPacket: UInt32
        var packetIndex: UInt32 = 0
    }
}
