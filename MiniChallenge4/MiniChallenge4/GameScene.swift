//
//  GameScene.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli & Osniel Teixeira on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    var functions = Array<Function>()
    
    var pinchGesture: UIPinchGestureRecognizer!
    
    var lastCenterPoint: CGPoint?
    
    var sceneSize: CGSize = CGSize(width: 0, height: 0)
    
    var functionLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        sceneSize = (self.view?.bounds.size)!
        
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "Ceu"), color: UIColor.white, size: sceneSize)
        bg.position = (self.view?.center)!
        bg.zPosition = -1
        self.addChild(bg)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
        
        functionLabel = SKLabelNode(fontNamed: "Cochin")
        functionLabel.fontSize = 20
        functionLabel.fontColor = SKColor.white
        functionLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(functionLabel)
        
        lastCenterPoint = CGPoint(x: (self.view?.frame.width)! * 0.15, y: (self.view?.frame.height)! * 0.5)
        
        let deleteButton = SKButton(pressed: "ApagarButton_", neinPressed: "ApagarButton", target: self,
                                    action: #selector(removeActiveFunction))
        deleteButton.position = CGPoint(x: sceneSize.width*0.85, y: sceneSize.height*0.1)
        self.addChild(deleteButton)
        
        let addFuntionButton = SKButton(pressed: "plus_placeholder", neinPressed: "plus_placeholder", target: self,
                                        action: #selector(addRandomFunction))
        addFuntionButton.position = CGPoint(x: sceneSize.width*0.95, y: sceneSize.height*0.1)
        self.addChild(addFuntionButton)
        
        let playButton = SKButton(pressed: "play_placeholder", neinPressed: "play_placeholder", target: self,
                                  action: #selector(play))
        playButton.position = CGPoint(x: sceneSize.width*0.95, y: sceneSize.height*0.3)
        self.addChild(playButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        functionLabel.text = functions.last?.toString()
    }
    
    func updatePinch() {
        functions.last?.pinchUpdate(factor: /*pinchGesture.velocity **/pinchGesture.scale)
        //calculate(function: functions.last!)
        updateAFunction()
    }
    
    func initializeFuntion(function: Function) {
        calculate(function: function)
    }
    
    func calculate(function: Function) {
        functions.last?.node?.removeFromParent()
        functions.last?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        functions.last?.node?.position = lastCenterPoint!
        self.addChild((functions.last?.node!)!)
        let point = CGPoint(x: (functions.last?.functionPoints.last!.x)! + lastCenterPoint!.x + Values.DELTA_X,
                            y: (functions.last?.functionPoints.last!.y)! + lastCenterPoint!.y)
        
        lastCenterPoint = point
    }
    
    func updateAFunction(){
        let point = functions.last?.node?.position
        functions.last?.node?.removeFromParent()
        functions.last?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        functions.last?.node?.position = point!
        self.addChild((functions.last?.node!)!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for n in self.children{
            if n.contains(pos), let button = n as? SKButton {
                button.press()
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func removeActiveFunction(){
        if functions.count > 0 {
            functions.last?.node?.removeFromParent()
            functions.remove(at: functions.count-1)
            if functions.count >= 1{
                let point = CGPoint(x: (functions.last?.functionPoints.last!.x)! + (functions.last?.node?.position.x)! + Values.DELTA_X,
                                    y: (functions.last?.functionPoints.last!.y)! + (functions.last?.node?.position.y)!)
                lastCenterPoint = point
            }else{
                lastCenterPoint = CGPoint(x: (self.view?.frame.width)! * 0.15, y: (self.view?.frame.height)! * 0.5)
            }
        }
    }
    
    func addRandomFunction(){
        let funcs = ["Linear","Sin","Quadratic"]
        let index = Int(arc4random_uniform(UInt32(funcs.count)))
        let choosed = funcs[index]
        if choosed == "Linear" {
            functions.append(SinFunction(scale: Double((self.view?.frame.width)!) / 2))
            initializeFuntion(function: functions.last!)
        } else if choosed == "Sin"{
            functions.append(LinearFunction(scale: Double((self.view?.frame.width)!) / 2))
            initializeFuntion(function: functions.last!)
        } else if choosed == "Quadratic"{
            functions.append(QuadraticFunction(scale: Double((self.view?.frame.width)!) / 2))
            initializeFuntion(function: functions.last!)
        }
        if functions.count > 1{
            join(functions[functions.count-2],functions.last!)
        }
    }
    
    /// Joins the last two functions
    func join(_ funcA: Function, _ funcB: Function){
        //Find the variation between the value of y of the last point of a function and the first of the next one
        let deltaY = (funcA.node?.convert((funcA.functionPoints.last)!, to: self).y)! - (funcB.node?.convert((funcB.functionPoints.first)!, to: self).y)!
        
        //Repositions a node
        let action = SKAction.moveBy(x: 0, y: deltaY, duration: 1)
        functions.last?.node?.run(action)
    }
    
    func deltaY(_ funcA: Function, _ funcB: Function) -> CGFloat{
        //return (funcA.node?.convert((funcA.functionPoints.last)!, to: self).y)! - (funcB.node?.convert((funcB.functionPoints.first)!, to: self).y)!
        return (funcA.functionPoints.last?.y)! - (funcB.functionPoints.first?.y)!
    }
    /// Creates the path formed by the union of all functions.
    func createThePath() -> CGMutablePath{
        let path = CGMutablePath()
        var deltaYBefore:CGFloat = 0
        for i in 0..<functions.count {
            if i>0{
                deltaYBefore = deltaYBefore + deltaY(functions[i-1], functions[i])
            }
            var newPoints = functions[i].functionPoints
            for j in 0..<newPoints.count{
                newPoints[j].x = newPoints[j].x + (CGFloat(i) * ((functions[i].functionPoints.last?.x)! - (functions[i].functionPoints.first?.x)!))
                if i > 0 {
                    newPoints[j].y = newPoints[j].y + deltaYBefore
                }
                if i == 0 && j == 0{
                    path.move(to: newPoints[j])
                }else{
                    path.addLine(to: newPoints[j])
                }
            }
        }
        return path
    }
    
    /// Makes the neutrino run
    func play(){
        if !functions.isEmpty{
            let neutrino = SKSpriteNode(imageNamed: "neutrino")
            neutrino.scale(to: CGSize(width: 60, height: 60))
            neutrino.position = CGPoint(x: (self.view?.frame.width)! * 0.15, y: (self.view?.frame.height)! * 0.5)
            self.addChild(neutrino)
            let action = SKAction.follow(createThePath(), speed: 60)
            neutrino.run(action) {
                neutrino.removeFromParent()
            }
        }
    }
}
