//
//  ProfilePictureEditorViewController.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/26/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class ProfilePictureEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    weak var profileImage: UIImageView!
    var user: User!
    var pet: Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false);
        
        // Do any additional setup after loading the view.
        imageView.clipsToBounds = true;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapImageView(_ sender: Any) {
        let vc = UIImagePickerController();
        vc.delegate = self;
        vc.allowsEditing = true;
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        present(vc, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        // let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imageView.contentMode = .scaleAspectFill;
        imageView.layer.borderColor = UIColor.white.cgColor;
        imageView.layer.borderWidth = 2.0;
        imageView.image = editedImage;
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil);
        
        updateProfileImage();
    }
    
    func updateProfileImage() {
        /*
        profileImage = self.imageView.image;
         
        image.save();
        User.current()?.save();
        dismiss(animated:true, completion: nil);
 
        */
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
