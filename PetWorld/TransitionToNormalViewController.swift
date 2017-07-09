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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        let currentUser = PFUser.current() as! User
        
        let pet = currentUser.petsArray.first
        
        if let image = pet?.image {
            profilePicturePreview.image = pet?.image
            print("pet image: \(pet?.image)")
        }
       
        if let name = pet?.name{
            print("petname: \(pet?.name)")
            
            petNamePreview.text = pet?.name
        
        }
        
    
    }
    
    @IBAction func onTappedStart(_ sender: Any) {
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
