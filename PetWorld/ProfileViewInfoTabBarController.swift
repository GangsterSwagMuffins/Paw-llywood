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
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    var pet: Pet?
    
    var myPostsViewController: MyPostViewController?
    
     var petInformationViewController: AboutMeTableViewController?
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //We should already have the images view controller showing user's posts
        myImagesButton.isSelected = true
      
    }
    
    
    
    @IBAction func onMyImagesTapped(_ sender: UIButton) {
        if (myPostsViewController == nil){
            myPostsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPostViewController") as! MyPostViewController
        }
        
        
        self.myPostsViewController?.view.frame = self.containerView.bounds
        self.myPostsViewController?.pet = self.pet
        self.containerView.addSubview((self.myPostsViewController?.view)!)
        
        if myInfoButton.isSelected{
            myInfoButton.isSelected = false
        }
        
        
    }
  
    @IBAction func onMyInfoButtonTapped(_ sender: Any) {
        if petInformationViewController == nil{
            petInformationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeTableViewController") as! AboutMeTableViewController
        }
        
        self.petInformationViewController?.pet = self.pet
       
        self.petInformationViewController?.view.frame = self.containerView.bounds
        self.containerView.addSubview((self.petInformationViewController?.view)!)
        
        
        if myImagesButton.isSelected{
            myImagesButton.isSelected = false
        }
        
    }
    
    
    
    
    
    

}
