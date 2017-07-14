//
//  PetPhotoUploadViewController.swift
//  PetWorld
//
//  Created by my mac on 7/7/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class PetPhotoUploadViewController: UIViewController {

    @IBOutlet weak var profileImagePreview: UIImageView!
    weak var parentVC: UIViewController!
    
    
    
    var pet: Pet?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImagePreview.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagePreviewTapped(_:)
            )
        )
        
        profileImagePreview.addGestureRecognizer(tapRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("view will disappear called")
        extractPhoto()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "TransitionToNormalViewController") as! TransitionToNormalViewController
        vc.pet = self.pet
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChooseTapped(_ sender: UIButton) {
        openGallery()
        
    }
    
    
    
    func imagePreviewTapped(_ sender: UITapGestureRecognizer){
        print("Tap recognized by imageview")
        openGallery()
    }
    
    func openGallery(){
        
        print("openGallery called!")
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //This function extracts the photo from the UIImageView and stores in the pet object
    func extractPhoto(){
        let currentUser = PFUser.current() as! User
        self.pet?.image = profileImagePreview.image
        
        print("extractPhoto() called")
    }
    
   


}



//Implement the imagePickerController delegate functions
extension PetPhotoUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImagePreview.image = originalImage
        extractPhoto()
        
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
}
