//
//  SettingsViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var user: User!
    var pet: Pet!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  tableView.delegate = self
       // tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     /*   if(user == nil) {
            if(User.current() == nil) {
                tableView.reloadData();
                return; // logged out
            }
            user = User.current();
        }*/
    }
    
    
    
    
    
    @IBAction func onLogout(_ sender: UIButton) {
        print("logout button pressed!")
        PFUser.logOutInBackground { (error: Error?) in
            if (error != nil){
                print(error!)
                return
            }
            self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
            print("Successfully logged out!!!")
           
            
            
        }
        
      
        
    }
    
   
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
      //  return user.petsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetsTableViewCell", for: indexPath) as! PetsTableViewCell
        
        let pet = user.petsArray[indexPath.row]
    
        cell.nameLabel.text = pet.name
        if (pet.image == nil) {
            pet.image = #imageLiteral(resourceName: "Default Profile Image")
        }
        cell.otherPetsImageView.image = pet.image
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
*/
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
