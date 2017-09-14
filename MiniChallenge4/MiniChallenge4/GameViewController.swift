//
//  GameViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = LevelOne(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pauseGame()
    }
    
    func pauseGame() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "pauseMenu") as? PauseMenuViewController {
            vc.gameViewController = self
            self.present(vc, animated: false, completion: nil)
        }
    }
    func returnToMainMenu() {
        self.dismiss(animated: true, completion: nil)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
