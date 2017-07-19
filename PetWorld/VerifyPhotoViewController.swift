//
//  VerifyPhotoViewController.swift
//  PetWorld
//
//  Created by my mac on 5/27/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class VerifyPhotoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var caption: UITextField!

    @IBOutlet weak var chosenPicture: UIImageView!
    var picture: UIImage?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        chosenPicture.image = picture
        caption.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onPost(_ sender: Any) {
        // caption
        let captionText = caption.text
        // post photo
        let photoPost = NetworkAPI.resize(photo: self.chosenPicture.image!, newSize: CGSize(width: 240, height: 240))
            let post = Post()
            post.media = NetworkAPI.getPhotoFile(photo: photoPost)
            NetworkAPI.postUserImage(photo: photoPost, caption: captionText) { (success: Bool, error: Error?) in
            if success {
                print("Photo posted")
                self.performSegue(withIdentifier: "PhotoCaptureSegue", sender: nil)
            } else {
                print(error?.localizedDescription ?? "Photo not posted")
            }
        }
    
    }
    
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
