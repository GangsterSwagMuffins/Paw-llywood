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
        let photoPost = resize(photo: self.chosenPicture.image!, newSize: CGSize(width: 240, height: 240))
            NetworkAPI.postUserImage(photo: photoPost, caption: captionText) { (success: Bool, error: Error?) in
            if success {
                print("Photo posted")
                self.performSegue(withIdentifier: "PhotoCaptureSegue", sender: nil)
            } else {
                print(error?.localizedDescription ?? "Photo not posted")
            }
        }
    
    }
    
    func resize(photo: UIImage, newSize: CGSize) -> UIImage {
        
        //Resize the image to match the siize that is passed in
        let resizedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizedImage.contentMode = UIViewContentMode.scaleAspectFill
        resizedImage.image = photo
        
        //update the image on the view controller to the new size
        UIGraphicsBeginImageContext(resizedImage.frame.size)
        resizedImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
