//
//  WinGameViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 15/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class WinGameViewController: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!

    @IBOutlet weak var popUpView: UIView!
    
    var effect: UIVisualEffect!
    
    var gameViewController: GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = blurView.effect
        blurView.effect = nil
        popUpView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = self.effect
            self.popUpView.alpha = 1
        })
    }
    @IBAction func nextLevel(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {_ in
                self.gameViewController.nextLevel()
            })
        })
    }
    
    @IBAction func backToMainMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {_ in
                self.gameViewController.returnToMainMenu()
            })
        })
    }
}
