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

extension CGFloat {
    func degreesToRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}

extension Int {
    func toCardinal() -> String {
        switch self {
        case 1:
            return "first"
        case 2:
            return "second"
        default:
            return "not identified"
        }
    }
}

extension UIImage {
    func applyTonalFilter() -> UIImage{
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectTonal")
        currentFilter?.setDefaults()
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter?.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
}

