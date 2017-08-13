//
//  AboutMeTableViewController.swift
//  PetWorld
//
//  Created by my mac on 7/15/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class AboutMeTableViewController: UITableViewController {
    
    
  static  let TAG: String = "AboutMeTableViewController"
    
    var pet: Pet?
    
    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!

    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var hobbyLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        if let pet = self.pet{
            
            updateUI(pet: pet)
            
        }
        
        self.tableView.allowsSelection = false
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("\(AboutMeTableViewController.TAG) viewWillAppear()")
        if let pet = self.pet{
            updateUI(pet: pet)
        }
    }
    
        
        func viewDidAppear(animated: Bool){
            
            if let pet = self.pet{
                
                updateUI(pet: pet)
                
            }
        
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func updateUI(pet: Pet){
        updateBreedLabel(pet: pet)
        updateAgeLabel(pet: pet )
       // updateHobbyLabel(pet: pet)
        updateSpeciesLabel(pet: pet)
        updateBioLabel(pet: pet)
        updateHeightLabel(pet: pet)
        updateWeightLabel(pet: pet)
        
    }
    
    
    func updateBreedLabel(pet: Pet){
        if let breed = pet.breed{
            self.breedLabel.text = breed
        }
        
        self.breedLabel.textColor = ColorPalette.primary
    }
    
    func updateAgeLabel(pet: Pet){
        if let age = pet.age{
            self.ageLabel.text  = "\(age)"
        }
        self.ageLabel.textColor = ColorPalette.primary
    }
    
    
    func updateBioLabel(pet: Pet){
        if let bio = pet.longBio{
            self.bioLabel.text = bio
        }
        self.bioLabel.textColor = ColorPalette.primary
    }
    
    func updateWeightLabel(pet: Pet){
        
        if let weight = pet.weight{
            let weightDecimal = weight as? Float
            if let weightDecimal = weightDecimal{
                self.weightLabel.text =  "\(weightDecimal) lbs"
            }
        }
        self.weightLabel.textColor = ColorPalette.primary
    }
    
    func updateHeightLabel(pet: Pet){
        if let height = pet.height{
            let heightDecimal = height as? Float
            if let heightDecimal = heightDecimal{
                    self.heightLabel.text = "\(heightDecimal) inches"
                }
            }
        
        self.heightLabel.textColor = ColorPalette.primary
        }
    

    func updateSpeciesLabel(pet: Pet){
        if let species = pet.species{
            self.speciesLabel.text = species
        }
        self.speciesLabel.textColor = ColorPalette.primary
    }
    
    func updateHobbyLabel(pet: Pet){
        if let hobby = pet.hobby{
           self.hobbyLabel.text = hobby
        }
        self.hobbyLabel.textColor = ColorPalette.primary
    }

    

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 
 */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
