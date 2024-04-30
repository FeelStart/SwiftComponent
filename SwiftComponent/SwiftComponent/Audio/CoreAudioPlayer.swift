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
        var state: State?

        public init() {
        }
    }
}

extension CoreAudio.Player {

    @discardableResult
    public func play(url: URL) -> Bool {
        // Open file
        var audioFileID: AudioFileID?
        status = AudioFileOpenURL(url as CFURL,
                                  .readPermission,
                                  0,
                                  &audioFileID)
        guard status == noErr, let audioFileID else {
            return false
        }

        // file format
        var streamBasicDescription = AudioStreamBasicDescription()
        status = CoreAudio.extAudioFileProperty(url: url, inData: &streamBasicDescription, inPropertyID: kExtAudioFileProperty_FileDataFormat)
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
        guard status == noErr, let audioQueueRef else {
            return false
        }



        // Max packet size
        var maxPacketSize: UInt32 = 0
        status = CoreAudio.audioFileProperty(fileID: audioFileID, inData: &maxPacketSize, inPropertyID: kAudioFilePropertyPacketSizeUpperBound)

        // MP4格式等部分音频数据，需要设置 magic、gain 头。
        // kAudioFilePropertyMagicCookieData
        // AudioQueueSetProperty
        //
        // kAudioQueueParam_Volume
        // AudioQueueSetParameter

        // AudioQueueAllocateBuffer
        let bufferSize: UInt32 = 4096
        var buffers = [AudioQueueBufferRef]()
        for i in 0...2 {
            var buffer: AudioQueueBufferRef?
            status = AudioQueueAllocateBuffer(audioQueueRef, bufferSize, &buffer)
            if status != noErr {
                return false
            }

            if let buffer {
                buffers.append(buffer)
            }
        }

        // AudioFileReadPacketData
        var currentBufferSize = bufferSize
        var currentPacketsIndex: UInt32 = 0
        var buffer = buffers.first
        status = AudioFileReadPacketData(audioFileID,
                                         false,
                                         &currentBufferSize,
                                         nil,
                                         0,
                                         &currentPacketsIndex,
                                         &buffer)

        // AudioQueueEnqueueBuffer

        return true
    }
}
