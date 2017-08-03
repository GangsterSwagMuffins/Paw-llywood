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
    
   
    
 
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Register subclases
          Pet.registerSubclass()
          Post.registerSubclass()
        Comment.registerSubclass()
        
        
        // Override point for customization after application launch.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "petworldy"
                configuration.clientKey = "goldenchain"  // set to nil assuming you have not set clientKey
                configuration.server = "https://petworldy.herokuapp.com/parse"
            })
        )
        
    //    PFUser.logOut()
        
      //  mockData()
        
       // /* // UNCOMMENT TO DIRECTLY ACCESS LOGIN/SIGNUP
            
        
        
        if (User.current() != nil){
            
            
          let storyboard = UIStoryboard(name: "Main", bundle: nil)/*
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            vc.tabBar.barTintColor = TextManipulation.themeColor()
            vc.tabBar.tintColor = TextManipulation.secondaryColor()
            
            window?.rootViewController = vc*/
            
           /* let loadingViewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
            
            window?.rootViewController = loadingViewController*/
            
            let homeTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
      
            
            NetworkAPI.loadPets(finishedDownloading: { (pets: [Pet]) in
                if (pets.count > 0){
                    //Save all the pets here!
                    Pet.pets = pets
                    self.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    
                    self.window?.rootViewController = homeTabBarController
                    
                    
                }else{
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
                    
                    self.window?.rootViewController = loginViewController
                }
            })
            
        }else{
          let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            
            window?.rootViewController = loginViewController
            
        }
        
        
        // */ // UNCOMMENT TO DIRECTLY ACCESS LOGIN/SIGNUP
        
        return true
    }
    
    func mockData(){
   /*      let user1 = User()
        user1.username = "user1"
        user1.password = "password"
        user1.signUpInBackground()
      //  user1.saveInBackground()
        let user2 = User()
        user2.username = "user2"
        user2.password = "password"
        //user2.saveInBackground()
        user2.signUpInBackground()
        
        let user3  = User()
        user3.username = "user3"
        user3.password = "password"
        user3.signUpInBackground()*/
       // user3.saveInBackground()
        
    
     /*   let brownDog = Pet()
        let fuzzyDog = Pet()
        let dalmation = Pet()
        
        
        brownDog["owner"] = user1
        brownDog["image"] = NetworkAPI.getPhotoFile(photo: UIImage(named: "brown_dog"))
        
        fuzzyDog["owner"] = user2
        fuzzyDog["image"] = NetworkAPI.getPhotoFile(photo: UIImage(named: "fuzzy_dog"))
        
        dalmation["owner"] = user3
        dalmation["image"] = NetworkAPI.getPhotoFile(photo: UIImage(named: "dalmation"))
        
        brownDog.saveInBackground()
        fuzzyDog.saveInBackground()
        dalmation.saveInBackground()*/
        
        
        
        
        let post1 = Post()
        post1.author = Pet.currentPet()
        post1.caption = "F the police."
     //   post1.likedBy = [fuzzyDog, dalmation]
        post1.media = NetworkAPI.getPhotoFile(photo: UIImage(named: "brown_dog"))
        post1.saveInBackground()
        
        let post2 = Post()
        post2.author = Pet.currentPet()
        post2.caption = "I am fuzzy."
      //  post2.likedBy = [dalmation, brownDog]
        post2.media = NetworkAPI.getPhotoFile(photo: UIImage(named: "fuzzy_dog"))
      //  NetworkAPI.postUserImage(photo: , caption: <#T##String?#>, success: <#T##PFBooleanResultBlock?##PFBooleanResultBlock?##(Bool, Error?) -> Void#>)
        post2.saveInBackground()
        
        
        let post3 = Post()
        post3.author = Pet.currentPet()
        post3.caption = "I am a german spy."
      //  post3.likedBy = [fuzzyDog, brownDog]
        post3.media = NetworkAPI.getPhotoFile(photo: UIImage(named: "dalmation"))
        post3.saveInBackground()
        
        
        
        
    }
    
   
    
    


}

