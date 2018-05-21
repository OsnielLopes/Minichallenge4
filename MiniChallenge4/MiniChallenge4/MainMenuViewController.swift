//
//  MainMenuViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 14/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit

class MainMenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    var playSound: AVAudioPlayer!
    @IBOutlet weak var skinsButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        var skin = #imageLiteral(resourceName: "Character Wow")
        if let luminitoIcon = UserDefaults.standard.object(forKey: "characterSkin") as? String {
            if let image = Skin.getImage(luminitoIcon) {
                skin = image
            }
        }
        self.skinsButton.setImage(skin, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let music = MusicHelper.sharedHelper.audioPlayer {
            if !music.isPlaying {
                MusicHelper.sharedHelper.playBackgroundMusic()
                
            }
        } else {
            MusicHelper.sharedHelper.playBackgroundMusic()
        }
        self.playSound = Audio.playSound(named: Audio.CLICK_IN)
        
        GKLocalPlayer.localPlayer().authenticateHandler = {
            (vc, error) in
            
            if let vc = vc {
                self.view?.window?.rootViewController?.present(vc, animated: true, completion: nil)
            } else if let error = error  {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        self.playSound.play()
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
    @IBAction func touchGameCenter(_ sender: UIButton) {
        
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        
        self.view.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
}
