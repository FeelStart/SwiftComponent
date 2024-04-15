//
//  AudioPlayerProtocol.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/1.
//

import Foundation

public protocol AudioPlayerProtocol {
    func readyForPlay() -> Bool
    func play() -> Bool
    func pause() -> Bool
    func resume() -> Bool
    func stop() -> Bool
    func seek(to timeInterval: TimeInterval) -> Bool
}
