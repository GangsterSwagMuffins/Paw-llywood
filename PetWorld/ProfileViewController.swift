//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pet: Pet!
    var user: User!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var backgroundPictureImageView: UIImageView!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var miniBioLabel: UILabel!
    
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var petAgeLabel: UILabel!
    
    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var hobbyLabel: UILabel!
    
    @IBOutlet weak var fullBioLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = User.current()
        let username = currentUser?.username
        let ownerText = ownerLabel.text!
        
        if let username = username{
            ownerLabel.text = "\(ownerText) \(username)"
           

        }

        //Populate all the pet fields/info/data GUI
        let pet = currentUser?.petsArray.first
        
        
        if let pet = pet {
            //Extract the image and put on the scren
            if let profilePicture = pet.image{
                profilePictureImageView.image = profilePicture
            }
            //Extract the pet's name and display on screen.
            if let petName = pet.name{
                petNameLabel.text = petName
            }
            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animatee3d: Bool) {
      
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
