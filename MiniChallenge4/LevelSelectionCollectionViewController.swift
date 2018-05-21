//
//  LevelSelectionCollectionViewController.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 14/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import AVFoundation

class LevelSelectionCollectionViewController: UICollectionViewController {
    
    var levels: [Bool] = []
    
    var levelSelectionViewController: UIViewController?
    
    var goToGameSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        goToGameSound = Audio.playSound(named: Audio.CLICK_IN)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let colLvls = UserDefaults.standard.array(forKey: "LevelProgression") as? [Bool] {
            levels = colLvls
        }
        let passedLevels = levels.filter({ $0 == true })
        if passedLevels.count < levels.count {
            if passedLevels.count > 0 && passedLevels.count < 2 {
                levels[passedLevels.count] = true
            } else {
                levels[0] = true
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let specialCell = cell as? LevelCollectionViewCell {
            specialCell.setLevelNumber(number: indexPath.row)
            specialCell.collectionView = self
            if levels[indexPath.row] == false {
                specialCell.disable()
            }
        }
        cell.accessibilityLabel = "Nível"+String(indexPath.row)
        return cell
    }
    
    @IBAction func didTouchLevelButton(_ sender: UIButton) {
        if let levelNumber = Int((sender.titleLabel?.text!)!) {
            self.moveToGame(levelIndex: levelNumber)
        }
    }
    
    
    func moveToGame(levelIndex: Int) {
        goToGameSound.play()
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameController") as? GameViewController {
            vc.level = levelIndex
            self.levelSelectionViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        self.levelSelectionViewController = parent
    }

}
