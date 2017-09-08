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
    
    override func didMove(to view: SKView) {
        
        sceneSize = (self.view?.bounds.size)!
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
        
        lastCenterPoint = CGPoint(x: (self.view?.frame.width)! * 0.15, y: (self.view?.frame.height)! * 0.5)
        
        //Add a sin function
        functions.append(SinFunction(scale: Double((self.view?.frame.width)!) / 2))
        initializeFuntion(function: functions[0])
        
        //Add a linear function
        functions.append(LinearFunction(scale: Double((self.view?.frame.width)!) / 2))
        initializeFuntion(function: functions[1])
        
        join()
        
        let deleteButton = SKButton(pressed: "ApagarButton_", neinPressed: "ApagarButton")
        deleteButton.position = CGPoint(x: sceneSize.width*0.85, y: sceneSize.height*0.1)
        self.addChild(deleteButton)
        
        let addFuntionButton = SKButton(pressed: "BlackHole", neinPressed: "BlackHole")
        addFuntionButton.name = "addNewFuntionButton"
        addFuntionButton.position = CGPoint(x: sceneSize.width*0.95, y: sceneSize.height*0.1)
        self.addChild(addFuntionButton)
    }
    
    func updatePinch() {
        functions.last?.pinchUpdate(factor: pinchGesture.velocity * pinchGesture.scale)
        calculate(function: functions.last!)
    }
    
    func initializeFuntion(function: Function) {
        calculate(function: function)
    }
    
    func calculate(function: Function) {
        functions.last?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        functions.last?.node?.position = lastCenterPoint!
        self.addChild((functions.last?.node!)!)
        let point = CGPoint(x: (functions.last?.functionPoints.last!.x)! + lastCenterPoint!.x + Values.DELTA_X,
                            y: (functions.last?.functionPoints.last!.y)! + lastCenterPoint!.y)
        
        lastCenterPoint = point
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for n in self.children{
            if n.contains(pos), let button = n as? SKButton {
                if button.name != "addNewFuntionButton"{
                    button.press()
                    break
                }else{
                    addRandomFunction()
                    break
                }
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
            join()
        }
    }
    
    func join(){
        
        let deltaY = (functions[functions.count-2].node?.convert((functions[functions.count-2].functionPoints.last)!, to: self).y)! - (functions.last?.node?.convert((functions.last?.functionPoints.first)!, to: self).y)!
        
        //Reposiciona o node recem-adicionado
        let action = SKAction.moveBy(x: 0, y: deltaY, duration: 1)
        functions.last?.node?.run(action)
    }
}
