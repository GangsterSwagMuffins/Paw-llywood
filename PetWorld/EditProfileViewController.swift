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
    
    
    
    func extractData(){
        self.newImage = profileImageView.image
        
        self.newBreed = breedTextView.text
        self.newSpecies = speciesTextView.text
        self.newWeight = Int(weightTextView.text!) as! NSNumber
        print(newWeight)
        self.newHeight = Int(heightTextView.text!) as! NSNumber
        self.newBio = bioTextView.text
        
        self.newAge = Int(ageTextView.text!) as! NSNumber
    
    }
    
    
   private func initPetInfo(){
        let pet = AppDelegate.currentPet()
    
        profileImageView.image = pet.image
    
    
        breedTextView.text = pet.breed ?? "PettyMcPetPet"
        
        speciesTextView.text = pet.species ?? "DinoNugget"
    
    if let age = pet.age{
        ageTextView.text = "\(age)"
    }else{
        ageTextView.text = "0"
    }
    
    if let weight = pet.weight{
        weightTextView.text = "\(weight)"
    }else{
        weightTextView.text = "900"
    }
    
    if let height = pet.height{
        heightTextView.text = "\(height)"
    }else{
        heightTextView.text = "20"
    }
    
    if let longBio = pet.longBio{
        bioTextView.text = "\(longBio)"
    }else{
        bioTextView.text = "I am a pet."
    }
    
    

        
    
    
    }
    
    func saveData(){
        let pet = AppDelegate.currentPet()
        
        pet.breed = newBreed
        pet.species = newSpecies
        pet.age = newAge
        pet.weight = newWeight
        pet.height = newHeight
        pet.longBio = newBio
        pet.image = newImage
        pet["image"] = Pet.getPhotoFile(photo: newImage)
        
        print(pet)
        pet.saveInBackground { (bool: Bool, error: Error?) in
            if let error = error{
                print("error: \(error.localizedDescription)")
            }else{
                print("finished saving!!!!")
            }
        }
    
    }
    
 
   
  
    
    
    
    
    
}
