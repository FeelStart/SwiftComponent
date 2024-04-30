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
        var streamBasicDescription = AudioStreamBasicDescription()
        status = CoreAudio.audioFileProperty(url: url, inData: &streamBasicDescription, inPropertyID: kExtAudioFileProperty_FileDataFormat)
        if status != noErr {
            return false
        }

        status = AudioQueueNewOutput(&streamBasicDescription,
                                     audioQueueNewOutputCallBack,
                                     Unmanaged.passUnretained(self).toOpaque(),
                                     nil,
                                     nil,
                                     0,
                                     &audioQueueRef)
        if status != 0 {
            return false
        }

        return true
    }
}
