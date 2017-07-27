//
//  EditProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 7/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: DesignableImageView!
    
    @IBOutlet weak var breedTextView: DesignableTextField!
   
    @IBOutlet weak var speciesTextView: DesignableTextField!
    
    @IBOutlet weak var ageTextView: DesignableTextField!
    
    @IBOutlet weak var weightTextView: DesignableTextField!
    
    @IBOutlet weak var heightTextView: DesignableTextField!
    
    @IBOutlet weak var bioTextView: DesignableTextField!
    
    var newBreed: String?
    var newSpecies: String?
    var newAge: NSNumber?
    var newWeight: NSNumber?
    var newHeight: NSNumber?
    var newBio: String?
    var newImage: UIImage?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPetInfo()
        
        
    }
    
    
    @IBAction func onFinishedTyping(_ sender: UITextField) {
       extractData()
        
    }
    
    @IBAction func onSaveTapped(_ sender: UIButton) {
        extractData()
        saveData()
         dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onCancelTapped(_ sender: UIButton){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onNewPhotoTapped(_ sender: Any) {
        //Open a photo picker
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //Later will hook up to custom photo taker.
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let originalImage = info[UIImagePickerControllerOriginalImage]
        as! UIImage
        
        
        self.profileImageView.image = originalImage
        extractData()
        
        dismiss(animated: true, completion: nil)
        
    
    }
    
    
    //This code assumes that user is a nice person and doesnt type letters where number belong.
    func extractData(){
        
        
        if let image = profileImageView.image{
            self.newImage = image
        }
      //  self.newImage = profileImageView.image
        
        if let breed = breedTextView.text{
           self.newBreed = breed
        }
        
      //  self.newBreed = breedTextView.text
        
        if let newSpecies = speciesTextView.text{
            self.newSpecies = newSpecies
        }
        
      //  self.newSpecies = speciesTextView.text
        
        if let weightString = weightTextView.text{
            if (weightString.isNumber){
                self.newWeight = Float(weightString) as! NSNumber

            }
        }else{
            print("User tried to input String data where numbers go!!!")

        }
        
        
       // self.newWeight = Int(weightTextView.text!) as! NSNumber
        
       // print(newWeight)
        
        if let heightString = self.heightTextView.text{
            if (heightString.isNumber){
                self.newHeight = Float(heightString) as! NSNumber
            }else{
                 print("User tried to input String data where numbers go!!!")
            }

        }
        
        if let bio = bioTextView.text{
            self.newBio = bio
        }
        
        
        //self.newHeight = Int(heightTextView.text!) as! NSNumber
        //self.newBio = bioTextView.text
        
        if let ageString = ageTextView.text{
            if ageString.isNumber{
                self.newAge = Float(ageTextView.text!) as! NSNumber
            }
        }
        
        //self.newAge = Int(ageTextView.text!) as! NSNumber
    
    }
    
    
   private func initPetInfo(){
        let pet = Pet.currentPet()
    
    if let image = pet.image{
        profileImageView.image = pet.image
    }
    

        breedTextView.text = pet.breed
        
        speciesTextView.text = pet.species
    
    if let age = pet.age{
        ageTextView.text = "\(age)"
    }
    
    if let weight = pet.weight{
        weightTextView.text = "\(weight)"
    }
    
    if let height = pet.height{
        heightTextView.text = "\(height)"
    }
    
    if let longBio = pet.longBio{
        bioTextView.text = "\(longBio)"
    }
    
    

        
    
    
    }
    
    func saveData(){
        let pet = Pet.currentPet()
        
        pet.breed = newBreed
        pet.species = newSpecies
        pet.age = newAge
        pet.weight = newWeight
        pet.height = newHeight
        pet.longBio = newBio
        pet.image = newImage
        pet["image"] = NetworkAPI.getPhotoFile(photo: newImage)
        
       // print(pet)
        pet.saveInBackground { (bool: Bool, error: Error?) in
            if let error = error{
                print("error: \(error.localizedDescription)")
            }else{
                print("finished saving!!!!")
            }
        }
    
    }
    
 
   
  
    
    
    
    
    
}
