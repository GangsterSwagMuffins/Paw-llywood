//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var breedLabel: UITextField!
    @IBOutlet var ageLabel: UITextField!
    @IBOutlet var genderLabel: UITextField!
    @IBOutlet var statusLabel: UITextField!
    @IBOutlet var weightLabel: UITextField!
    @IBOutlet var heightLabel: UITextField!
    @IBOutlet var followersLabel: UITextField!
    @IBOutlet var followingLabel: UITextField!
    var pet: Pet!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pet == nil {
            imageView.image = #imageLiteral(resourceName: "Default Profile Image")
        }
        breedLabel.delegate = self
        nameLabel.delegate = self
        ageLabel.delegate = self
        genderLabel.delegate = self
        statusLabel.delegate = self
        weightLabel.delegate = self
        heightLabel.delegate = self
        followersLabel.delegate = self
        followingLabel.delegate = self
        
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
    
    override func viewWillAppear(_ animatee3d: Bool) {
        if(user == nil) {
            if(User.current() == nil) {
                return; // logged out
            }
            user = User.current();
        }
        user = User.current();
        if user.petsArray.first != nil && user.petsArray.count > 1 {
            self.pet = user.petsArray.first
        }else{
            self.pet = Pet()
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
        breedLabel.becomeFirstResponder()
    }

    @IBAction func onTapAgeEdit(_ sender: Any) {
        ageLabel.becomeFirstResponder()
    }
    @IBAction func onTapGenderEdit(_ sender: Any) {
        genderLabel.becomeFirstResponder()
    }
    
    @IBAction func onTapNameEdit(_ sender: Any) {
        nameLabel.becomeFirstResponder()
    }
    
    @IBAction func onTapStatusEdit(_ sender: Any) {
        statusLabel.becomeFirstResponder()
    }
    @IBAction func onTapWeightEdit(_ sender: Any) {
        weightLabel.becomeFirstResponder()
    }
    
    @IBAction func onTapHeightEdit(_ sender: Any) {
        heightLabel.becomeFirstResponder()
    }
    @IBAction func onTapAddPet(_ sender: Any) {
      //  pet.name = nameLabel.text
        pet.breed = breedLabel.text
        pet.age = Int(ageLabel.text!)
        pet.gender = genderLabel.text
        pet.following = Int(followingLabel.text!)
        pet.followers = Int(followersLabel.text!)
        user.petsArray.append(pet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func onTapEditPic(_ sender: Any) {
        //self.performSegue(withIdentifier: "picEditor", sender: self)
        let vc = UIImagePickerController();
        vc.delegate = self;
        vc.allowsEditing = true;
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        present(vc, animated: true, completion: nil);

    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            pet.image = image
            imageView.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
