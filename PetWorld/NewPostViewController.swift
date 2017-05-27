//
//  NewPostViewController.swift
//
//  Copyright © 2017 Vinnie Chen. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCaptionClearText(_ sender: Any) {
        captionTextField.text = ""
    }
    
    @IBAction func onPost(_ sender: Any) {
        // caption
        let caption = captionTextField.text
        // post photo
        let photoPost = resize(photo: self.photoImageView.image!, newSize: CGSize(width: 240, height: 240))
        Post.postUserImage(photo: photoPost, caption: caption) { (success: Bool, error: Error?) in
            if success {
                print("Photo posted")
                self.tabBarController?.selectedIndex = 0 // move back to home screen
            } else {
                print(error?.localizedDescription ?? "Photo not posted")
            }
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Image selected with UIImagePickerController
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {
                print("Error image selected")
                fatalError("Error image selected")
        }
        
        //reset the view controller to original settings
        photoImageView.image = originalImage
        
        
        // Dismisses UIImagePickerController
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        // Show image picker
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
