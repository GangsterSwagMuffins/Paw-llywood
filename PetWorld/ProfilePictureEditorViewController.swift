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


    var profileImage: UIImageView!
    var user: User!
    var pet: Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false);
        
        // Do any additional setup after loading the view.
       //imageView.clipsToBounds = true;

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
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTapProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "backToProfile" {
            let dVC = segue.destination as! ProfileViewController
            dVC.pet = self.pet
            dVC.imageView = self.profileImage
            dVC.user = self.user
        }
    }
 

}
