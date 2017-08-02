//
//  ProfileViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PetFieldsLoadedDelegate {
    
    var pet: Pet?
    var user: User!
    var shouldShowEditButton: Bool = true
    
    @IBOutlet var profileView: ProfileView!
    
    var tableViewController: AboutMeTableViewController?
    
    
    
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        //Code to open edit profile view controller
        
        self.performSegue(withIdentifier:
            "EditProfile", sender: nil)
        print("editProfileButtonPressed")
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Depends on whether or not came from choosing the profile tab or clicking on someone else's profile
        self.profileView.showEdit = shouldShowEditButton
      //  updateOwnerField()
        //Have an instance of delegate from app del
        
        if (shouldShowEditButton){
            if (Pet.getPets().count > 0){
                print("number of pets > 0")
                //Get the current pet
                self.pet = Pet.currentPet()
                //Automatically updates the UI after finished loading...
                
                if let pet = self.pet{
                    self.profileView.loadProfileImage(pet: pet)
                    self.profileView.updateUI(pet: pet)
                }
                
                
            }else{ // If no pets were loaded....
                print("getPets() has <= 0")
            }
        }
       
        
        
        if let pet = self.pet{
            self.profileView.updatePetUI(pet: pet)
        }
        
        
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         self.tableViewController = storyBoard.instantiateViewController(withIdentifier: "AboutMeTableViewController") as! AboutMeTableViewController
        
        
        
        
        self.tableViewController?.pet = self.pet
        self.tableViewController?.view.frame = self.profileView.containerView.bounds
        self.profileView.containerView.addSubview((self.tableViewController?.view)!)
        
        
        
        
        
  
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animatee3d: Bool) {
        //Have an instance of delegate from app del
        let currentUser = User.current()!
        
        
        if (shouldShowEditButton){
            if (self.pet == nil){
                if (Pet.getPets().count > 0){
                    //Get the current pet
                    self.pet = Pet.currentPet()
                    if let pet = self.pet{
                        self.profileView.loadProfileImage(pet: pet)
                    }
                    
                    
                    
                    
                }else{ // If no pets were loaded....
                    print("getPets() has <= 0")
                }
                
                
            }
        }
       
       
        
        if let pet = self.pet{
            self.profileView.pet = pet
          //  print(pet)
           
        }
          self.tableViewController?.pet = self.pet
        
        if let pet = self.pet{
              self.tableViewController?.updateUI(pet: pet)
            self.tableViewController?.tableView.reloadData()
            
        }
       
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapLogOut(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to Log Out of PetWorld?", preferredStyle: UIAlertControllerStyle.alert);
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
        
        refreshAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action: UIAlertAction!) in
            
            User.logOutInBackground()
            //change view controller to login view controller
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(viewController!, animated: true, completion: nil)
 
        }));
        
        present(refreshAlert, animated: true, completion: nil);
    }

    
    func petFieldsLoaded(){
        
        if let pet = self.pet{
              self.profileView.updatePetUI(pet: (self.pet!))
              self.tableViewController?.updateUI(pet: pet)
              self.tableViewController?.tableView.reloadData()
        }
      
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "picEditor" {
            let dVc = segue.destination as! ProfilePictureEditorViewController
            dVc.user = User.current()
            dVc.pet = self.pet
        }
    }
 

}
