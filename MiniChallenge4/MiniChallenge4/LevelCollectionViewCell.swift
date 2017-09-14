//
//  LevelCollectionViewCell.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 14/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var levelNumber: UIButton!
    
    var number: Int!
    
    var collectionView: LevelSelectionCollectionViewController!

    func setLevelNumber(number: Int) {
        self.number = number
        self.levelNumber.setTitle("", for: .normal)
        self.levelNumber.setImage(UIImage(named: "Lvl \(number + 1)"), for: .normal)
        self.levelNumber.setImage(UIImage(named: "Lvl \(number + 1)_"), for: .selected)
        self.levelNumber.setImage(UIImage(named: "Lvl \(number + 1)x"), for: .disabled)
    }
    
    func disable() {
        self.levelNumber.isEnabled = false
    }
    
    @IBAction func didPress(_ sender: Any) {
        collectionView.moveToGame(levelIndex: number)
    }
}
