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
        let URL = Bundle.main.url(forResource: "WolfieAndLammy", withExtension: "mp4")
        
        player = AVPlayer.init(url: URL!)
        player.volume = 0.0
        
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = view.layer.frame
        
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        player.play()
        
        view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        
        
        
    }
    
    func playerItemReachEnd(notification: NSNotification){
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
