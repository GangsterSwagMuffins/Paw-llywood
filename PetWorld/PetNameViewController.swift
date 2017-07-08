//
//  PetNameViewController.swift
//  PetWorld
//
//  Created by my mac on 7/7/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


//TODO: Add checks so the user does not leave pet name field blank.
class PetNameViewController: UIViewController {

    
    var pet : Pet?
    
    
    @IBOutlet weak var petNameTextField: DesignableTextField!
    @IBOutlet weak var checkMarkButton: DesignableButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pet = Pet()
        //Use respsponder chain for target action
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Just in case the user does not press the check mark
    @IBAction func finishedTypingPetName(_ sender: UITextField) {
        let petName = sender.text;
        
        if let petName = petName {
            pet?.name = petName
        }
        
        
        
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        //Duct tape check
        let petName = petNameTextField.text ?? "PettyMcPetPet";
        
       pet?.name = petName
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pagerVC = storyboard.instantiateViewController(withIdentifier: "TutorialPageViewController") as! TutorialPageViewController
        pagerVC.setViewControllers([pagerVC.vcArray[1]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
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
