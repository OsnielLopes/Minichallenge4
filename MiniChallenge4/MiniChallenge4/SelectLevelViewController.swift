//
//  SelectLevelViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 17/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation

class SelectLevelViewController: UIViewController {
    
    var backToMainMenu: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        backToMainMenu = Audio.playSound(named: Audio.CLICK_OUT)
    }

    @IBAction func back(_ sender: Any) {
        backToMainMenu.play()
    }
}
