//
//  T.swift
//  PetWorld
//
//  Created by my mac on 7/11/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PostMediaTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    var exitedCallback: ((Void)->(Void))?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tabBar.tintColor = ColorPalette.primary
        
        self.tabBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
