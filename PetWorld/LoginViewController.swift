//
//  LoginViewController.swift
//  PetWorld
//
//  Created by my mac on 4/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    
    @IBAction func onLoginTap(_ sender: UIButton) {
        
        print("Called!")
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        print("username: \(username)\n")
        print("password: \(password)\n")
        
        
        //Actually login user
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if (user != nil){
                print("You are logged in!!!")
                self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            }else{
                print(error!)
                print("Trouble signing in!!!")
            }
        }
        
    }
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        //If user presses the sign up button then go to the sign up screen
        //Probably uncessesary
      
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
        

        
        
        /*The following is code to set up the background video*/
        
        //Find the video in the project folder
        let URL = Bundle.main.url(forResource: "WolfieAndLammy", withExtension: "mp4")
        //Create AVPlayer object
        player = AVPlayer.init(url: URL!)
        //Until I find a way to strip audio....
        player.volume = 0.0
        
        
        //Create a player layer
        playerLayer = AVPlayerLayer(player: player)
        //Keep aspect ration
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //Set the player layer dimensions to the views layer dimensions
        playerLayer.frame = view.layer.frame
        
        //Don't mess with video at the end
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        //Start the video
        player.play()
        
        //Insert the the player into the view
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //Create a callback for the event that the video stops so it replays again
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        
        
        
    }
    
    func playerItemReachEnd(notification: NSNotification){
        
        //Reset the video to start again
        player.seek(to: kCMTimeZero)
        
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //
    }
    

}
