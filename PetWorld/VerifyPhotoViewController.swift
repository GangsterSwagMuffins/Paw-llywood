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

    @IBOutlet weak var tabBar: HeaderView!
    
    @IBOutlet weak var chosenPicture: UIImageView!
    var picture: UIImage?
    
    var exitCallback: ((Void) -> (Void))?
    var postSuccesful: ((Post) -> (Void))?
    var postFailure: ((Post, Error) -> (Void))?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        chosenPicture.image = picture
        caption.delegate = self
        self.tabBar.onClickCallBack = {
            self.dismiss(animated: true, completion: nil)
        }
        self.tabBar.titleText.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func onPost(_ sender: Any) {
        // caption
        let captionText = caption.text
        // post photo
        let resizedImage = NetworkAPI.resize(photo: self.chosenPicture.image!, newSize: CGSize(width: 240, height: 240))
            let post = Post()
            post.media = NetworkAPI.getPhotoFile(photo: resizedImage)
            NetworkAPI.postUserImage(photo: resizedImage, caption: captionText) { (success: Bool, error: Error?) in
                if let error = error{
                    print("error occured")
                    self.postFailure?(post, error)
                    //Tell the home view controller that there was some error.
                }else{
                    if success{
                        self.postSuccesful?(post)
                    }
                }
                
        }
        
       postDismiss()
    
    }
    
    
    
    
   
    func postDismiss(){
        self.dismiss(animated: false) { 
            self.exitCallback?()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }


}
