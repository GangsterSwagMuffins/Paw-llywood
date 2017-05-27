//
//  PostsViewController.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/6/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    //Text color button states
    //Selected state
    let selectedTextColor = UIColor.black
    //Non selected state
    let deselectedTextColor = UIColor.gray
    
    var galleryViewController: UIViewController!
    var photoViewController: UIViewController!
    var videoViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    
    var selectedIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        
        //Identify the view controllers from the storyboard
        galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController")
        photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController")
        videoViewController = storyboard.instantiateViewController(withIdentifier: "VideoViewController")
        
        //Add the view controllers to the list
        viewControllers = [galleryViewController, photoViewController, videoViewController]
        
        buttons[0].isSelected = true
        buttons[1].isSelected = false
        buttons[2].isSelected = false
        
        
        //Set the default button text color
        self.buttons[0].setTitleColor(self.selectedTextColor, for: UIControlState.selected)
        self.buttons[1].setTitleColor(self.selectedTextColor, for: UIControlState.selected)
        self.buttons[2].setTitleColor(self.selectedTextColor, for: UIControlState.selected)
        
        self.buttons[0].setTitleColor(self.deselectedTextColor, for: UIControlState.normal)
        
        self.buttons[1].setTitleColor(self.deselectedTextColor, for: UIControlState.normal)
        
        self.buttons[2].setTitleColor(self.deselectedTextColor, for: UIControlState.normal)
        
        didPressTab(buttons[selectedIndex])
        
        
        
    }
    
    
    
    @IBAction func onSaveMedia(_ sender: Any) {
        
        
        
    }
    @IBOutlet weak var onExitTapped: UIButton!
    
   
    @IBAction func exitTapped(_ sender: Any) {
        
        //Leave this post view and go back home
    }
    @IBAction func didPressTab(_ sender: UIButton) {
        //Save the value of the previous button pressed
        let previousIndex = selectedIndex
        //Get then index of the button pressed
        selectedIndex = sender.tag
        //Deselect the last button pressed
        buttons[previousIndex].isSelected = false
        print("button #\(previousIndex) deselected")
        //Remove the previous view controller
        let previousVC = viewControllers[previousIndex]
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        //Add the new button and set the button state
        sender.isSelected = true
        
        print("button #\(sender.tag) selected")
        //Access the new new view controlller via array and selected index
        let vc = viewControllers[selectedIndex]
        //Add the new view controller
        addChildViewController(vc)
        
        //Adjust the size of the viewcontroller to
        //match the size of the content view of
        //the custom tab bar vc
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        //Trigger the viewDidAppear function
        vc.didMove(toParentViewController: self)
        
        
        
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
