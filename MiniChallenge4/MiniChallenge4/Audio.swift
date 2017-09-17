//
//  SoundManager.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 16/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

struct Audio {
    static var CLICK_IN = "click_in.wav"
    static var CLICK_OUT = "click_out.wav"
    static var FUNCTION_SELECTION = "function_selection.wav"
    static var PAUSE = "pause.wav"
    static var REMOVE_FUNCTION = "remove_function.wav"
    
    static var VICTORY = "victory.wav"
    static var DEATH = "death.wav"
    static var FLOAT = "weewee.mp3"
    
    
    init(named: String, toPlayAt scene: SKScene) {
        let sound = SKAction.playSoundFileNamed(named, waitForCompletion: false)
        scene.run(sound)
    }
    
    static func playSound(named: String) -> AVAudioPlayer {
        var audioPlayer: AVAudioPlayer?
        
        let start = named.index(named.endIndex, offsetBy: -3)
        var end = named.endIndex
        var range = start..<end
        let type = named.substring(with: range)
        end = named.index(start, offsetBy: -1)
        range = named.startIndex..<end
        let fileName = named.substring(with: range)
        
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: type)!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = 0
            audioPlayer!.prepareToPlay()
        } catch {
            print("Cannot play the file")
        }
        return audioPlayer!
    }
}

class MusicHelper {
    
    static let sharedHelper = MusicHelper()
    
    var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "coolsong", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func continueBackgroundMusic() {
        self.audioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        self.audioPlayer?.stop()
    }
}


