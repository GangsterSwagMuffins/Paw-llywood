//
//  SignUpViewController.swift
//  PetWorld
//
//  Created by my mac on 4/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelSignUp", sender: nil)

    }
    @IBAction func onCreateAccTap(_ sender: Any) {
        
        let user = PFUser()
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        
        user.username = username
        user.password = password
        
        print("username: \(username)")
        print("password: \(password)")
        
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("Something went wrong.")
                  print(error.localizedDescription)
                // Show the errorString somewhere and let the user try again.
            } else {
                print("Successfully signed up!")
                // Hooray! Let them use the app now.
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
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
        if segue.identifier == "signupSegue" {
            let dVc = segue.destination as! HomeViewController
        }
    }
 

}
