//
//  AudioUtils.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/30.
//

import AudioToolbox

// MARK: - 文件属性

extension CoreAudio {
    /// 获取音频文件属性
    /// - Parameters:
    /// - url: 文件链接
    /// - inData: 属性类型
    /// - inPropertyID: 属性 ID
    /// - Returns: 返回状态码
    @discardableResult
    static func audioFileProperty<T>(url: URL, inData: UnsafeMutablePointer<T>, inPropertyID: ExtAudioFilePropertyID) -> OSStatus {
        var status = noErr

        // 打开文件
        var fileRef: ExtAudioFileRef?
        status = ExtAudioFileOpenURL(url as CFURL, &fileRef)
        guard status == 0, let fileRef else {
            return status
        }
        defer {
            ExtAudioFileDispose(fileRef)
        }

        return audioFileProperty(fileRef: fileRef, inData: inData, inPropertyID: inPropertyID)
    }

    /// 获取音频文件属性
    /// - Parameters:
    /// - fileRef: 打开的文件
    /// - inData: 属性类型
    /// - inPropertyID: 属性 ID
    /// - Returns: 返回状态码
    @discardableResult
    static func audioFileProperty<T>(fileRef: ExtAudioFileRef, inData: UnsafeMutablePointer<T>, inPropertyID: ExtAudioFilePropertyID) -> OSStatus {
        var status = noErr

        // 获取属性长度
        var propertySize: UInt32 = 0
        var writable: DarwinBoolean = false
        status = ExtAudioFileGetPropertyInfo(fileRef,
                                             inPropertyID,
                                             &propertySize,
                                             &writable)
        guard status == 0 else {
            return status
        }

        // 获取属性
        status = ExtAudioFileGetProperty(fileRef,
                                         inPropertyID,
                                         &propertySize,
                                         inData)

        return status
    }
}

