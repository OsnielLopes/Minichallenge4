//
//  Variables.swift
//  MiniChallenge4
//
//  Created by Osniel Lopes Teixeira on 08/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import UIKit

struct Values {
    static var START = Double(-30)
    static var END = Double(30)
    static var DELTA_X = CGFloat(60)
    static var NEUTRINO_SIZE = CGFloat(70)
}

struct Skin {

    static let skins: [String:UIImage] = ["luminito": #imageLiteral(resourceName: "Character Wow"),
                                   "starman": #imageLiteral(resourceName: "starman"),
                                   "sputnik":#imageLiteral(resourceName: "sputnik")]
    
    static public func getImage(_ skinName: String) -> UIImage?{
        return skins[skinName]
    }
    
}
