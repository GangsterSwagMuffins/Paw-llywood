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

    
  
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "PostMediaTabViewController") as! UITabBarController
        
        performSegue(withIdentifier: "PostMediaSegue", sender: nil)
        
        print("viewDidLoad()")
        
        
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
