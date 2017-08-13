    //
//  PostsViewController.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/6/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PostsViewController: UIViewController {

    
  
    var exitedCallback: ((Void) -> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("POSTVIEWCONTROLLER VIEWDIDLOAD")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "PostMediaTabViewController") as! UITabBarController
      
        
        print("viewDidLoad()")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("POSTVIEWCONTROLLER VIEWWILLAPPEAR")

        performSegue(withIdentifier: "PostMediaSegue", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        
        print("POSTVIEWCONTROLLER PREPAREFORSEGUE")

        if let viewControllers = tabBarController.viewControllers{
            let galleryVC = viewControllers[0] as! GalleryViewController
            
            galleryVC.finishedCallback = exitedCallback
            
            
            }
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
