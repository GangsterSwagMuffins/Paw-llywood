//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PetFieldsLoadedDelegate {
    
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
        updateOwnerField()
        //Have an instance of delegate from app del
        let currentUser = User.current()!
        if (AppDelegate.getPets().count > 0){
            print("number of pets > 0")
            //Grab the current pet from settings
            let defaults = UserDefaults.standard
            let petIndex = defaults.integer(forKey: "currentPet")
            
            //Get the current pet
             self.pet = AppDelegate.getPets()[petIndex]
            
            loadProfileImage(pet: self.pet)
            loadBackgroundImage(pet: self.pet)
            
            

        }else{ // If no pets were loaded....
            print("getPets() has <= 0")
        }
        
        
        if let pet = self.pet{
            updatePetUI(pet: pet)
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
    
    
    
    
    
    func updatePetUI(pet: Pet){
        updatePetName(pet: pet)
        updateProfilePicture(pet :pet)
        updatePetAgeLabel(pet: pet)
        updateBreedLabel(pet: pet)
        updateHobbyLabel(pet: pet)
        updateFullBioLabel(pet: pet)
        updateMiniBioLabel(pet: pet)
        updateBackgroundImage(pet: pet)
    }
    
    
    
    func updatePetName(pet: Pet){
        if let petName = pet.name{
            petNameLabel.text = petName
        }
    }
    
    func updatePetAgeLabel(pet: Pet){
        if let age = pet.age {
            petAgeLabel.text = "\(age)"
        }
    }
    
    func updateBreedLabel(pet: Pet){
        if let breed = pet.breed{
            breedLabel.text = breed
        }
        
    }
    
    func updateHobbyLabel(pet: Pet){
        if let hobby = pet.hobby{
            hobbyLabel.text = hobby
        }
    }
    
    func updateFullBioLabel(pet: Pet){
        if let fullBio = pet.longBio{
            fullBioLabel.text = fullBio
        }
    }
    
    
    func updateProfilePicture(pet: Pet){
        //Extract the image and put on the scren
        if let profilePicture = pet.image{
            profilePictureImageView.image = profilePicture
        }
    }
    
    func updateMiniBioLabel(pet: Pet){
        if let miniBio = pet.miniBio{
            miniBioLabel.text = miniBio
        }
    }
    
    func updateBackgroundImage(pet: Pet){
        if let backgroundImage = pet.backgroundImage{
         backgroundPictureImageView.image = backgroundImage
        }
    }
    
    
    func loadProfileImage(pet: Pet){
        //Check to see if the image of the pet was already loaded previously
        if self.pet.image == nil{
            //If it was not loaded then make a request to the server.
            let imageFile : PFFile = pet["image"] as! PFFile
            
            Pet.loadPicture(imageFile: imageFile, successBlock: { (image: UIImage) in
                //Then update the UI
                pet.image = image
                self.updatePetUI(pet: pet)
            })
            
        }else{//If it was already loaded then updat the UI
            self.updatePetUI(pet: pet)
        }
    }
    
    func loadBackgroundImage(pet: Pet){
        //Check to see if the image of the pet was already loaded previously
        if self.pet.backgroundImage == nil{
            //If it was not loaded then make a request to the server.
            let imageFile : PFFile = pet["backgroundImage"] as! PFFile
            
            Pet.loadPicture(imageFile: imageFile, successBlock: { (backgroundImage: UIImage) in
                //Then update the UI
                print("backgroundImage")
                pet.backgroundImage = backgroundImage
                self.updatePetUI(pet: pet)
            })
            
        }else{//If it was already loaded then updat the UI
            self.updatePetUI(pet: pet)
        }
    }
    
    
    func updateOwnerField(){
        
        let currentUser = User.current()
        let username = currentUser?.username
        let ownerText = ownerLabel.text!
     
        if let username = username{
            ownerLabel.text = "\(ownerText) \(username)"
        }
    }
    
    
    func petFieldsLoaded(){
        
        if let pet = self.pet{
              updatePetUI(pet: (self.pet!))
        }
      
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
