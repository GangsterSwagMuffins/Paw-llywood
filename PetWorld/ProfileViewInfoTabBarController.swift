//
//  ProfileViewInfoTabBarController.swift
//  PetWorld
//
//  Created by my mac on 8/3/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class ProfileViewInfoTabBarController: UIViewController {

    
    @IBOutlet weak var myImagesButton: UIButton!
    
    @IBOutlet weak var myInfoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //We should already have the images view controller showing user's posts
        myImagesButton.isSelected = true
      
    }
    
    
    
    @IBAction func onMyImagesTapped(_ sender: UIButton) {
        
        if myInfoButton.isSelected{
            myInfoButton.isSelected = false
        }
        
        
    }
  
    @IBAction func onMyInfoButtonTapped(_ sender: Any) {
        
        if myImagesButton.isSelected{
            myImagesButton.isSelected = false
        }
        
    }
    
    
    
    
    
    

}
