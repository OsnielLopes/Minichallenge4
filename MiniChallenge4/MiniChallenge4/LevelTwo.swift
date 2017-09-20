//
//  LevelTwo.swift
//  MiniChallenge4
//
//  Created by Osniel Lopes Teixeira on 16/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LevelTwo: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.numberOfFunctionsAllowed = 2
        
        super.didMove(to: view)
        self.addPlanets(planets: ["Netuno 2", "Urano 2"])
        
        var meteorsDescription = [
            [self.convert(sketchX: 133, sketchY: 824), 149],
            [self.convert(sketchX: 230, sketchY: 450), 149],
            [self.convert(sketchX: 200, sketchY: 241), 149]]
        meteorsDescription.append([
            [self.convert(sketchX: 286, sketchY: 799), 246],
            [self.convert(sketchX: 380, sketchY: 380), 99],
            [self.convert(sketchX: 488, sketchY: 212), 103]])
        meteorsDescription.append([
            [self.convert(sketchX: 588, sketchY: 791), 149],
            [self.convert(sketchX: 700, sketchY: 666), 149],
            [self.convert(sketchX: 681, sketchY: 278), 63]])
        meteorsDescription.append([
            [self.convert(sketchX: 961, sketchY: 758), 99],
            [self.convert(sketchX: 720, sketchY: 340), 63],
            [self.convert(sketchX: 928, sketchY: 202), 99]])
        meteorsDescription.append([
            [self.convert(sketchX: 1068, sketchY: 605), 215],
            [self.convert(sketchX: 1155, sketchY: 477), 103],
            
            [self.convert(sketchX: 1289, sketchY: 778), 149]])
        meteorsDescription.append([
            [self.convert(sketchX: 1300, sketchY: 400), 246],
            [self.convert(sketchX: 1595, sketchY: 930), 103],
            [self.convert(sketchX: 1559, sketchY: 774), 77]])
        meteorsDescription.append([self.convert(sketchX: 1433, sketchY: 538), 103])
        
        for meteor in meteorsDescription{
            self.createMeteor(meteor[0] as! CGPoint, CGFloat(meteor[1] as! Int))
        }
        
        levelIndex = 1
    }
}
