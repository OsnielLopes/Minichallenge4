//
//  MainMenuViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 14/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {
    
    var playSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        MusicHelper.sharedHelper.playBackgroundMusic()
        self.playSound = Audio.playSound(named: Audio.CLICK_IN)
    }

    @IBAction func playSound(_ sender: Any) {
        self.playSound.play()
    }
}
