//
//  AddFriendViewController.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/27/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class AddFriendViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
    }
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func onTapNumber(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onSave(_ sender: Any) {
        let post = PFObject(className: "Friend")
        post["name"] = nameTextField.text
        post["number"] = numberTextField.text
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground { (True, error) in
            
        }
        
        self.performSegue(withIdentifier: "showFriends", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Add Friend will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Add Friend will disappear")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
