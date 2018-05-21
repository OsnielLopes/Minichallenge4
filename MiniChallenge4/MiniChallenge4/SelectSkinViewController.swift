//
//  SelectSkinViewController.swift
//  MiniChallenge4
//
//  Created by Osniel Lopes Teixeira on 18/02/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import UIKit
import StoreKit

class SelectSkinViewController: UIViewController {
    
    @IBOutlet weak var luminito: UIImageView!
    @IBOutlet weak var luminitoSelection: UIImageView!
    @IBOutlet weak var sputnik: UIImageView!
    @IBOutlet weak var sputnikSelection: UIImageView!
    var sputnisIsPurchased = false
    @IBOutlet weak var starman: UIImageView!
    @IBOutlet weak var sputnikPurchaseButton: UIButton!
    @IBOutlet weak var starmanPurchaseButton: UIButton!
    @IBOutlet weak var starmanSelection: UIImageView!
    var starmanIsPurchased = false
    
    var products: [SKProduct]!
    
    override func viewWillAppear(_ animated: Bool) {
        luminitoSelection.isHidden = true
        sputnikSelection.isHidden = true
        starmanSelection.isHidden = true
        
        if let skin = UserDefaults.standard.object(forKey: "characterSkin") as? String {
            if skin == "starman" {
                starmanSelection.isHidden = false
            } else if skin == "sputnik" {
                sputnikSelection.isHidden = false
            } else {
                luminitoSelection.isHidden = false
            }
        } else {
            luminitoSelection.isHidden = false
        }
        
        if IAProducts.store.isProductPurchased(IAProducts.sputnik) {
            sputnikPurchaseButton.isHidden = true
            sputnisIsPurchased = true
        } else {
            sputnik.image = sputnik.image?.applyTonalFilter()
        }
        
        if IAProducts.store.isProductPurchased(IAProducts.starman) {
            starmanPurchaseButton.isHidden = true
            starmanIsPurchased = true
        } else {
            starman.image = starman.image?.applyTonalFilter()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.starmanPurchased),
            name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
            object: "br.mackMobile.anarchyCompany.MiniChallenge4.starman")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.sputnikPurchased),
            name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
            object: "br.mackMobile.anarchyCompany.MiniChallenge4.sputnik")
        
        IAProducts.store.requestProducts(completionHandler: {
            (status, productsOptional) in
            if status {
                guard let products = productsOptional else { return }
                self.products = products
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            touchedWith(t)
        }
    }
    
    func touchedWith(_ touch: UITouch){
        if sputnik.frame.contains(touch.location(in: self.view)) {
            
        }
    }
    
    @IBAction func touchSputnikPurchase(_ sender: UIButton) {
        buyProduct("Sputnik Skin")
    }
    
    @IBAction func touchStarmanPurchase(_ sender: UIButton) {
        buyProduct("Starman Skin")
    }
    
    private func buyProduct(_ productTitle: String){
        waiting: repeat {
            if products != nil {
                for product in products {
                    if product.localizedTitle == productTitle {
                        IAProducts.store.buyProduct(product)
                        break waiting
                    }
                }
                break
            }
        }while(true)
    }
    
    @objc func starmanPurchased() {
        self.starmanIsPurchased = true
        self.starmanPurchaseButton.isHidden = true
        self.starman.image = #imageLiteral(resourceName: "starman")
    }
    
    @objc func sputnikPurchased() {
        self.sputnisIsPurchased = true
        self.sputnikPurchaseButton.isHidden = true
        self.sputnik.image = #imageLiteral(resourceName: "sputnik")
    }
    
}
