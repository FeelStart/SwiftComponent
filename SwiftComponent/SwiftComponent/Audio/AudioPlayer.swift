//
//  AudioPlayer.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/22.
//

import Foundation

public class AudioPlayer: NSObject, AudioPlayerProtocol {

    // MARK: - 

    public func readyForPlay() -> Bool {
        false
    }
    
    public func play() -> Bool {
        false
    }
    
    public func pause() -> Bool {
        false
    }
    
    public func resume() -> Bool {
        false
    }
    
    public func stop() -> Bool {
        false
    }
    
    public func seek(to timeInterval: TimeInterval) -> Bool {
        false
    }
}
