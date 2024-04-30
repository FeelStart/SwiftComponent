//
//  CoreAudioPlayer.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/30.
//

import AudioToolbox

fileprivate func audioQueueNewOutputCallBack(customData: UnsafeMutableRawPointer?, audioQueueRef: AudioQueueRef, bufferRef: AudioQueueBufferRef) {
    guard let customData else {
        return
    }

    let player = Unmanaged<CoreAudio.Player>.fromOpaque(customData).takeUnretainedValue()
}

extension CoreAudio {
    public class Player {
        var status = OSStatus()
        var audioQueueRef: AudioQueueRef?

        public init() {
        }
    }
}

extension CoreAudio.Player {

    @discardableResult
    public func play(url: URL) -> Bool {
        // file format
        var streamBasicDescription = AudioStreamBasicDescription()
        status = CoreAudio.audioFileProperty(url: url, inData: &streamBasicDescription, inPropertyID: kExtAudioFileProperty_FileDataFormat)
        if status != noErr {
            return false
        }

        // AudioQueue
        status = AudioQueueNewOutput(&streamBasicDescription,
                                     audioQueueNewOutputCallBack,
                                     Unmanaged.passUnretained(self).toOpaque(),
                                     nil,
                                     nil,
                                     0,
                                     &audioQueueRef)
        if status != noErr {
            return false
        }

        // Max packet size
        var maxPacketSize = UInt32()
        status = CoreAudio.audioFileProperty(url: url, inData: &maxPacketSize, inPropertyID: kAudioFilePropertyPacketSizeUpperBound)

        // MP4格式等部分音频数据，需要设置 magic、gain 头。
        // kAudioFilePropertyMagicCookieData
        // AudioQueueSetProperty
        //
        // kAudioQueueParam_Volume
        // AudioQueueSetParameter

        // AudioQueueAllocateBuffer

        // AudioFileReadPacketData

        // AudioQueueEnqueueBuffer

        return true
    }
}
