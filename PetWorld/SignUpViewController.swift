//
//  SignUpViewController.swift
//  PetWorld
//
//  Created by my mac on 4/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: DesignableTextField!
    
    
    @IBOutlet weak var errorDisplay: UILabel!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        errorDisplay.isHidden = true
        
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelSignUp", sender: nil)

    }
    @IBAction func onCreateAccTap(_ sender: UIButton) {
        errorDisplay.isHidden = true
        
        print("Start adventure")
        
        let user = User()
        
        
        let username = usernameTextField.text! ?? ""
        
        let password = passwordTextField.text! ?? ""
        
        let email = emailTextField.text! ?? ""
        
        if (email == "" || username == "" || password == ""){
            
            print("One of the fields was left blank.")
            errorDisplay.isHidden = false
            errorDisplay.text = "One of the above fields is blank"
        }
        
        
        
        user.username = username
        user.password = password
        
        print("username: \(username)")
        print("password: \(password)")
        
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("Something went wrong.")
                  print(error.localizedDescription)
                
                let nsError = error as! NSError
            
                let code = nsError.code
                if (code == 202){
                    print("username already exists")
                    self.errorDisplay.isHidden = false
                    
                    self.errorDisplay.text = "Username already taken."
                }
                // Show the errorString somewhere and let the user try again.
            } else {
                print("Successfully signed up!")
                // Hooray! Let them use the app now.
                self.performSegue(withIdentifier: "TutorialSegue", sender: nil)
                
            }
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
    }
 

}
