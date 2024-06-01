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
    player.fillBuffer(bufferRef)
}

extension CoreAudio {
    public class Player {
        var status = OSStatus()
        var audioQueueRef: AudioQueueRef?
        var state: State?
        var audioFileID: AudioFileID?

        public init() {
        }
    }
}

extension CoreAudio.Player {

    @discardableResult
    public func play(url: URL) -> Bool {
        // Open file
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
                                     nil, // Unmanaged.passUnretained(self).toOpaque(),
                                     CFRunLoopGetMain(),
                                     CFRunLoopMode.commonModes.rawValue,
                                     0,
                                     &audioQueueRef)
        guard status == noErr, let audioQueueRef else {
            return false
        }

        // Max packet size
        var maxPacketSize: UInt32 = 0
        status = CoreAudio.audioFileProperty(fileID: audioFileID, inData: &maxPacketSize, inPropertyID: kAudioFilePropertyPacketSizeUpperBound)

        state = State(bufferSize: 1024,
                      numBuffer: 3,
                      buffers: [AudioQueueBufferRef](),
                      maxPacketSize: maxPacketSize,
                      numPacket: 1024 / maxPacketSize)
        guard var state else { return false }

        // MP4格式等部分音频数据，需要设置 magic、gain 头。
        // kAudioFilePropertyMagicCookieData
        // AudioQueueSetProperty
        //
        // kAudioQueueParam_Volume
        // AudioQueueSetParameter

        for _ in 0..<state.numBuffer {
            var buffer: AudioQueueBufferRef?
            status = AudioQueueAllocateBuffer(audioQueueRef, state.bufferSize, &buffer)
            if status != noErr {
                return false
            }

            if let buffer {
                state.buffers.append(buffer)
            }
        }

        for idx in 0..<state.numBuffer {
            let buffer = state.buffers[Int(idx)]
            fillBuffer(buffer)
            status = AudioQueueEnqueueBuffer(audioQueueRef,
                                             buffer,
                                             0,
                                             nil)
        }

        AudioQueueStart(audioQueueRef, nil)

        return true
    }

    /// Note: 只能读取 PCM、WAC 等格式的文件
    /// TODO：VBR（Variable Bit Rate，可变比特率），要在这里获取 desc，并在 enqueue 时赋值。
    @discardableResult
    func fillBuffer(_ bufferRef: AudioQueueBufferRef) -> OSStatus {
        guard var state, let audioFileID else { return noErr }

        //var buffer = bufferRef.pointee
        //memset(buffer.mAudioData, 0, Int(state.bufferSize))
        //buffer.mAudioDataByteSize = state.bufferSize

        // TODO: Lock

        // AudioFileReadPacketData
        var bufferSize: UInt32 = state.bufferSize
        let packetIndex = state.packetIndex
        var numPacket = state.numPacket
        var descriptions = Array(repeating: AudioStreamPacketDescription(), count: Int(numPacket))
        status = AudioFileReadPacketData(audioFileID,
                                         false,
                                         &bufferSize,
                                         &descriptions,
                                         Int64(packetIndex),
                                         &numPacket,
                                         bufferRef)
        state.packetIndex += numPacket

        return status
    }
}
