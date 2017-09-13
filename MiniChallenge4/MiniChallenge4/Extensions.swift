//
//  Extensions.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 12/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import UIKit

extension UIPanGestureRecognizer {
    
    func isLeft(theViewYouArePassing: UIView) -> Bool {
        let velocity : CGPoint = self.velocity(in: theViewYouArePassing)
        if velocity.x > 0 {
            return false
        } else {
            return true
        }
    }
}
