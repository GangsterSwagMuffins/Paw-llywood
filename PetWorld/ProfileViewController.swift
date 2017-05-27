//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapLogOut(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to Log Out of Instagram?", preferredStyle: UIAlertControllerStyle.alert);
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
        
        refreshAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action: UIAlertAction!) in

          //  User.logOutInBackground;
            //change view controller to login view controller
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(viewController!, animated: true, completion: nil)
 
        }));
        
        present(refreshAlert, animated: true, completion: nil);
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
