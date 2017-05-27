//
//  LoginViewController.swift
//  PetWorld
//
//  Created by my mac on 4/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLoginTap(_ sender: Any) {
        
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
