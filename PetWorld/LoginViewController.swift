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

    @IBOutlet weak var errorDisplay: UILabel!
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    
    @IBAction func onLoginTap(_ sender: UIButton) {
        
        
        updateErrorDisplay(showErrorDisplay: false)
        
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
    
        
        
        //Actually login user
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if (user != nil){
                Pet.loadPets(finishedDownloading: { (pets: [Pet]) in
                    if (pets.count > 0){
                        //Save all the pets here!
                        Pet.pets = pets
                    }
                })
                
                print("You are logged in!!!")
                self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            }else if let error = error{
                let pfError = error as! NSError
                
                if pfError.code == 101{
                    print("Bad User/Pass Combination")
                    self.errorDisplay.text = "Bad User/Pass Combination"
                }
                
                self.updateErrorDisplay(showErrorDisplay: true)
                
                
                
            }
        }
        
    }
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        //If user presses the sign up button then go to the sign up screen
        //Probably uncessesary
      self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
        

        
        
        /*The following is code to set up the background video*/
        
        //Find the video in the project folder
        let URL = Bundle.main.url(forResource: "BGVideo", withExtension: "mp4")
        //Create AVPlayer object
        player = AVPlayer.init(url: URL!)
        //Until I find a way to strip audio....
        player.volume = 0.0
        
        
        //Create a player layer
        playerLayer = AVPlayerLayer(player: player)
        //Keep aspect ration
        playerLayer.videoGravity = AVLayerVideoGravityResize
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
    
    func updateErrorDisplay(showErrorDisplay: Bool){
        if (showErrorDisplay){
            self.errorDisplay.isHidden = false
            passwordTextField.showRightView = true
            passwordTextField.updateView()
            
        }else{
            self.errorDisplay.isHidden = true
            passwordTextField.showRightView = false
        }
    
    }
    
  
    
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //
    }
    

}
