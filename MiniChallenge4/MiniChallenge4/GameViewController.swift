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
    
    var level: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let levels = UserDefaults.standard.array(forKey: "LevelProgression") as? [Bool] {
                
                var scene: GameScene
                
                if level != nil {
                    scene = getLevelInstanceByNumber(index: level!)
                } else {
                    var lastCompletedLevel = 0
                    for i in 0...levels.count {
                        if levels[i] == false {
                            lastCompletedLevel = i
                            break
                        }
                    }
                    scene = getLevelInstanceByNumber(index: lastCompletedLevel)
                }
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }
    }
    
    func showScene(level: GameScene) {
        if let view = self.view as? SKView {
            view.presentScene(level)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
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
    
    func getLevelInstanceByNumber(index: Int) -> GameScene {
        switch index {
        case 0:
            return LevelOne(size: view.frame.size)
        default:
            return GameScene()
        }
    }
}
