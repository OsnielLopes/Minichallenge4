//
//  SKButton.swift
//  MiniChallenge4
//
//  Created by Osniel Lopes Teixeira on 06/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//
import SpriteKit
import Foundation

class SKButton: SKSpriteNode{
    
    var pressed = false
    var pressedImageName: String?
    var neinPressedImageName: String?
    var timer = Timer()
    var target: GameScene!
    var action: Selector!
    
    init(pressed: String, neinPressed: String, target: Any, action: Selector){
        let neinPressedTexture = SKTexture(imageNamed: neinPressed)
        super.init(texture: neinPressedTexture, color: UIColor.white, size: CGSize(width: 50, height: 50))
        pressedImageName = pressed
        neinPressedImageName = neinPressed
        self.action = action
        if let aScene = target as? GameScene{
            self.target = aScene
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Animate the button and perform the action related
    func press(){
        if pressed {
            self.pressed = false
            self.texture = SKTexture(imageNamed: neinPressedImageName!)
        }else{
            target.perform(action)
            self.pressed = true
            self.texture = SKTexture(imageNamed: pressedImageName!)
            timer = .scheduledTimer(withTimeInterval: 0.12, repeats: false, block: {_ in
                self.press()
            })
        }
    }
}
