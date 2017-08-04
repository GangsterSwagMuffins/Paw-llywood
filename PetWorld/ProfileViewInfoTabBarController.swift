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
    
    private var activeViewController: UIViewController?{
        didSet{
             removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    
        
    }
    
    private var inactiveViewController: UIViewController?
    
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?){
        if let inActiveVC = inactiveViewController{
            inActiveVC.willMove(toParentViewController: nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParentViewController()
        
        }
    
    }
    
    
    private func updateActiveViewController(){
        if isViewLoaded{
            if let activeVC = activeViewController{
                addChildViewController(activeVC)
                activeVC.view.frame = containerView.bounds
                containerView.addSubview(activeVC.view)
                activeVC.didMove(toParentViewController: self)
            }
        }
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         petInformationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeTableViewController") as! AboutMeTableViewController
        petInformationViewController?.pet = pet
        
        
        myPostsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPostViewController") as! MyPostViewController
        
        myPostsViewController?.pet = pet

        
        activeViewController = myPostsViewController

        
        
        
        //We should already have the images view controller showing user's posts
        myImagesButton.isSelected = true
        myInfoButton.isSelected = false
      
    }
    
    
    
    @IBAction func onMyImagesTapped(_ sender: UIButton) {
        
        self.activeViewController = myPostsViewController
        
      
    }
  
    @IBAction func onMyInfoButtonTapped(_ sender: Any) {
        self.activeViewController = petInformationViewController
    }
    
    
    
    func presentImagesVC(){
        if (myPostsViewController == nil){
            myPostsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPostViewController") as! MyPostViewController
        }
        
        
        self.myPostsViewController?.view.frame = self.containerView.bounds
        self.myPostsViewController?.pet = self.pet
        self.containerView.addSubview((self.myPostsViewController?.view)!)
        
        
        myInfoButton.isSelected = false
    
    }
    
    func presentInfoVC(){
        if petInformationViewController == nil{
            petInformationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeTableViewController") as! AboutMeTableViewController
        }
        
        self.petInformationViewController?.pet = self.pet
        
        self.petInformationViewController?.view.frame = self.containerView.bounds
        self.containerView.addSubview((self.petInformationViewController?.view)!)
        
        
        myImagesButton.isSelected = false
    
    }
    
    

}
