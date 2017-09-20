//
//  WinGameViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 15/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation

class WinGameViewController: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!

    @IBOutlet weak var popUpView: UIView!
    
    var effect: UIVisualEffect!
    
    var gameViewController: GameViewController!
    
    var nextLevelSound: AVAudioPlayer!
    
    var backToMainMenu: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = blurView.effect
        blurView.effect = nil
        popUpView.alpha = 0
        nextLevelSound = Audio.playSound(named: Audio.CLICK_IN)
        backToMainMenu = Audio.playSound(named: Audio.CLICK_OUT)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = self.effect
            self.popUpView.alpha = 1
        })
    }
    @IBAction func nextLevel(_ sender: Any) {
        nextLevelSound.play()
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: { () -> Void in
                self.gameViewController.nextLevel()
            })
        })
    }
    
    @IBAction func backToMainMenu(_ sender: Any) {
        backToMainMenu.play()
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {() -> Void in
                self.gameViewController.returnToMainMenu()
            })
        })
    }
}
