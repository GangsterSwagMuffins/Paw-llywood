//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    var pet: Pet!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pet == nil {
            imageView.image = #imageLiteral(resourceName: "Default Profile Image")
        }
        if (pet != nil) {
            breedLabel.text = pet.breed
            imageView.image = pet.image
            genderLabel.text = pet.gender
            followersLabel.text = String(describing: pet.followers)
            followingLabel.text = String(describing: pet.following)
            if pet.image == nil {
                pet.image = #imageLiteral(resourceName: "Default Profile Image")
            }
            imageView.image = pet.image
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(user == nil) {
            if(User.current() == nil) {
                return; // logged out
            }
            user = User.current();
        }
        user = User.current();
        if user.petsArray.first != nil {
            pet = user.petsArray.first
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapLogOut(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to Log Out of PetWorld?", preferredStyle: UIAlertControllerStyle.alert);
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
        
        refreshAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action: UIAlertAction!) in
            
            User.logOutInBackground()
            //change view controller to login view controller
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(viewController!, animated: true, completion: nil)
 
        }));
        
        present(refreshAlert, animated: true, completion: nil);
    }
    
    @IBAction func onTapBreedEdit(_ sender: Any) {
        breedLabel.isUserInteractionEnabled = true;
        breedLabel.becomeFirstResponder()
    }

    @IBAction func onTapAgeEdit(_ sender: Any) {
        ageLabel.isUserInteractionEnabled = true
        ageLabel.becomeFirstResponder()
    }
    @IBAction func onTapGenderEdit(_ sender: Any) {
        genderLabel.isUserInteractionEnabled = true
        genderLabel.becomeFirstResponder()
    }
    
    @IBAction func onTapNameEdit(_ sender: Any) {
        nameLabel.isUserInteractionEnabled = true
        nameLabel.becomeFirstResponder()
    }
    
    
    @IBAction func onTapAddPet(_ sender: Any) {
        pet.name = nameLabel.text
        pet.breed = breedLabel.text
        pet.age = Int(ageLabel.text!)
        pet.gender = genderLabel.text
        pet.following = Int(followingLabel.text!)
        pet.followers = Int(followersLabel.text!)
        user.petsArray.append(pet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isUserInteractionEnabled = false
        return true;
    }
    
    @IBAction func onTapEditPic(_ sender: Any) {
        performSegue(withIdentifier: "picEditor", sender: self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "picEditor" {
            let dVc = segue.destination as! ProfilePictureEditorViewController
            dVc.user = User.current()
            dVc.pet = self.pet
        }
    }
 

}
