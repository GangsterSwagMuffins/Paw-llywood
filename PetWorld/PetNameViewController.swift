//
//  PetNameViewController.swift
//  PetWorld
//
//  Created by my mac on 7/7/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse


//TODO: Add checks so the user does not leave pet name field blank.
class PetNameViewController: UIViewController {

    

    
    
    
    @IBOutlet weak var petNameTextField: DesignableTextField!
    @IBOutlet weak var checkMarkButton: DesignableButton!
    
    weak var parentVC : UIViewController!
    
    
    var pet: Pet?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pet = Pet()
        
        
        //Use respsponder chain for target action
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Just in case the user does not press the check mark
    @IBAction func finishedTypingPetName(_ sender: UITextField) {
       
        
        self.pet?.name = sender.text
        
        print("User stopped typing in username for their pet.")
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        print("viewWillDisappear called!")
        
        saveName();
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pagerVC = storyboard.instantiateViewController(withIdentifier: "PetPhotoUploadViewController") as! PetPhotoUploadViewController
        pagerVC.pet = self.pet
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        //Duct tape check
       
        
     
    
        
    }
    
    
    func saveName(){
       
        let petName = petNameTextField.text ?? "PettyMcPetPet";
        self.pet?.name = petName
        print("saveName() called")
    
    }
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
        
    }
    

}
