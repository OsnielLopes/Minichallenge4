//
//  SoundManager.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 16/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit

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
}


