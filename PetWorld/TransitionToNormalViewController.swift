//
//  TransitionToNormalViewController.swift
//  PetWorld
//
//  Created by my mac on 7/7/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class TransitionToNormalViewController: UIViewController {
    
    
    
    @IBOutlet weak var profilePicturePreview: UIImageView!

    @IBOutlet weak var petNamePreview: UILabel!
    
    weak var parentVC: UIViewController?
    
    
    var pet: Pet?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          updateUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
          updateUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        let currentUser = User.current()
        petNamePreview.text = self.pet?.name
        profilePicturePreview.image = self.pet?.image
        
    }
    
    @IBAction func onTappedStart(_ sender: Any) {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
        //Now update the user since we have made the pet object.
        let currentUser = User.current()!
      
        pet?["name"] = pet?.name
        pet?["image"] = Post.getPhotoFile(photo: pet?.image)
        pet?["owner"] = currentUser
        

        Pet.add(newPet: pet!)
        
       pet?.saveInBackground()
        
        currentUser.saveInBackground()
     

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
