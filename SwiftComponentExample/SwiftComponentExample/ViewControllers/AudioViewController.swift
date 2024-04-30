//
//  AudioViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/4/29.
//

import UIKit
import AudioToolbox
import SwiftComponent

/*
 * https://cloud.tencent.com/developer/article/1438299
 * https://www.osstatus.com/
 */

class AudioViewController: UIViewController {

    let player = CoreAudio.Player()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Audio"

        play()
    }

    func play() {
        guard let url = Bundle.resource.url(forResource: "Chasing Dreams", withExtension: "mp3", subdirectory: "Audio") else {
            return
        }

        player.play(url: url)
    }
}
