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
    
   static let TAG : String = "ProfileViewInfoTabBarController"
    
    var cellTappedCallBack: ((Post)->())?
    
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
        print("\(ProfileViewInfoTabBarController.TAG) ViewDidLoad()")

        
        self.myImagesButton.tintColor = ColorPalette.primary
        self.myInfoButton.tintColor = UIColor.gray
        
        
         petInformationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeTableViewController") as! AboutMeTableViewController
        petInformationViewController?.pet = pet
        
        
        myPostsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPostViewController") as! MyPostViewController
        
        myPostsViewController?.pet = pet
        myPostsViewController?.cellTappedCallback = self.cellTappedCallBack

        
        activeViewController = myPostsViewController
        
        //We should already have the images view controller showing user's posts
        myImagesButton.isSelected = true
        myInfoButton.isSelected = false
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(ProfileViewInfoTabBarController.TAG) ViewWillAppear()")
        
    }
    
    
    
    
    
    
    @IBAction func onMyImagesTapped(_ sender: UIButton) {
        
        self.activeViewController = myPostsViewController
        
        self.myImagesButton.tintColor = ColorPalette.primary
        self.myInfoButton.tintColor = UIColor.gray
        
      
    }
  
    @IBAction func onMyInfoButtonTapped(_ sender: Any) {
        self.activeViewController = petInformationViewController
        
        self.myImagesButton.tintColor = UIColor.gray
        self.myInfoButton.tintColor = ColorPalette.primary
        
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
