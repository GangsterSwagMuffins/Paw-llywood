//
//  AppDelegate.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    static var pets: [Pet] = []
    
 
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Register the Pet class first
          Pet.registerSubclass()
        
        
        // Override point for customization after application launch.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "asdfghjk;lkj;l"
                configuration.clientKey = "myMasterKey"  // set to nil assuming you have not set clientKey
                configuration.server = "https://petsagram.herokuapp.com/parse"
            })
        )
       // /* // UNCOMMENT TO DIRECTLY ACCESS LOGIN/SIGNUP
            
        
        
        if (User.current() != nil){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            vc.tabBar.barTintColor = TextManipulation.themeColor()
            vc.tabBar.tintColor = TextManipulation.secondaryColor()
            
            window?.rootViewController = vc
            
            Pet.loadPets(finishedDownloading: { (pets: [Pet]) in
                if (pets.count > 0){
                    //Save all the pets here!
                    AppDelegate.pets = pets
                }
            })
            
           
        
        }
        
        
        // */ // UNCOMMENT TO DIRECTLY ACCESS LOGIN/SIGNUP
        
        return true
    }
    
    class func getPets() -> [Pet]{

        
        return AppDelegate.pets
    }
    
    


}

