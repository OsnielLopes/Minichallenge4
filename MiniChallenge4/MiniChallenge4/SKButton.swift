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
    
    init(pressed: String, neinPressed: String){
        let neinPressedTexture = SKTexture(imageNamed: neinPressed)
        super.init(texture: neinPressedTexture, color: UIColor.white, size: CGSize(width: 50, height: 50))
        pressedImageName = pressed
        neinPressedImageName = neinPressed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func press(){
        if pressed {
            self.pressed = false
            self.texture = SKTexture(imageNamed: neinPressedImageName!)
        }else{
            if let scene = self.scene as? GameScene{
                //Remove the active function from the scene
                scene.removeActiveFunction()
            }
            self.pressed = true
            self.texture = SKTexture(imageNamed: pressedImageName!)
            timer = .scheduledTimer(withTimeInterval: 0.12, repeats: false, block: {_ in
                self.press()
            })
        }
    }
}
