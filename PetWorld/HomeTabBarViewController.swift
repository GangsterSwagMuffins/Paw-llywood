//
//  HomeTabBarViewController.swift
//  PetWorld
//
//  Created by my mac on 7/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    var cameraViewController: PostsViewController!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = self.viewControllers{
            for vc in viewControllers{
                if vc is PostsViewController{
                    self.cameraViewController = vc as! PostsViewController
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    
    func setCameraSegue(){
       // self.cameraViewController.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        if (viewController is PostsViewController){
          //  viewController.performSegue(withIdentifier: "", sender: <#T##Any?#>)
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
