//
//  ViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 13/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class PauseMenuViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var popUpView: UIView!
    
    var effect: UIVisualEffect!
    
    var gameViewController: GameViewController!
    
    var backToGameSound: AVAudioPlayer!
    
    var backToMainMenuSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = blurView.effect
        blurView.effect = nil
        popUpView.alpha = 0
        backToGameSound = Audio.playSound(named: Audio.PAUSE)
        backToMainMenuSound = Audio.playSound(named: Audio.CLICK_OUT)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = self.effect
            self.popUpView.alpha = 1
        })
    }
    
    @IBAction func mainMenu(_ sender: Any) {
        backToMainMenuSound.play()
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {_ in
                self.gameViewController.returnToMainMenu()
            })
        })
    }
    
    @IBAction func backToGame(_ sender: Any) {
        backToGameSound.play()
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {_ in
                if let s = self.gameViewController.view as? SKView {
                    s.isPaused = false
                }
            })
        })
    }
}
