//
//  AboutViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 17/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation

class AboutViewController: UIViewController {
    
    var backToMainMenu: AVAudioPlayer!

    @IBOutlet weak var chevisImage: UIImageView!
    @IBOutlet weak var paciulliImage: UIImageView!
    @IBOutlet weak var osnielImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMainMenu = Audio.playSound(named: Audio.CLICK_OUT)
        
        chevisImage.layer.cornerRadius = 8.0
        chevisImage.clipsToBounds = true
        paciulliImage.layer.cornerRadius = 8.0
        paciulliImage.clipsToBounds = true
        osnielImage.layer.cornerRadius = 8.0
        osnielImage.clipsToBounds = true
    }

    @IBAction func back(_ sender: Any) {
        backToMainMenu.play()
    }

}
