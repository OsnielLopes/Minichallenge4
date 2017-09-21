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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
                    scene = getLevelInstanceByNumber(index: lastCompletedLevel - 1)
                }
                scene.scaleMode = .aspectFill
                scene.gameViewController = self
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
    
    func winGame() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "winGame") as? WinGameViewController {
            vc.gameViewController = self
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func nextLevel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
            
                var scene: GameScene
                
                let v = self.view as! SKView
                let s = v.scene as! GameScene
                var l = s.levelIndex + 1
                if l == 2 { l = 0 }
                
                scene = self.getLevelInstanceByNumber(index: l)
                scene.gameViewController = self
                if let view = self.view as! SKView? {
                    view.presentScene(scene)
                }
        }, completion: {_ in
            self.view.alpha = 1
        })
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
        level = index
        switch index {
        case 0:
            return LevelOne(size: view.frame.size)
        case 1:
            return LevelTwo(size: view.frame.size)
        default:
            return LevelOne(size: view.frame.size)
        }
    }
}
