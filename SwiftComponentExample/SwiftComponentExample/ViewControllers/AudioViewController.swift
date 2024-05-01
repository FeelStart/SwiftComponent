//
//  AudioViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/4/29.
//

import UIKit
import SwiftComponent
import AVFoundation

/*
 * https://cloud.tencent.com/developer/article/1438299
 * https://www.osstatus.com/
 */

class AudioViewController: UIViewController {

    let player = CoreAudio.Player()

    var avPlayer: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Audio"

        play()
    }

    func play() {
        guard let url = Bundle.resource.url(forResource: "Chasing-Dreams", withExtension: "wav", subdirectory: "Audio") else {
            return
        }

        //avPlayer = AVPlayer(url: url)
        //avPlayer.play()

        player.play(url: url)
    }
}
