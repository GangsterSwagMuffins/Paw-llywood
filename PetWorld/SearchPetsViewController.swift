//
//  SearchPetsViewController.swift
//  PetWorld
//
//  Created by my mac on 8/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class SearchPetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchBarDelegate {
    
    
    
   

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var pets: [Pet] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetDescription", for: indexPath) as! PetDescriptionCellTableViewCell
        
        cell.pet = pets[indexPath.row]
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pets.count
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "ProfileSegue", sender: indexPath )
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print("searching.... \(searchText)")
        
        NetworkAPI.searchPets(withName: searchText, successHandler: { (pets: [Pet]) -> (Void) in
            self.pets = pets
            self.tableView.reloadData()
            print("Pets loaded:\n\(pets)")
            
        }) { (error: Error) in
            print("Could not search for the pets!\n\(error)")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let sender = sender{
            if (sender is IndexPath){
                let indexPath = sender as! IndexPath
                var pet = pets[indexPath.row]
                let profileVC = segue.destination as! ProfileViewController
                profileVC.shouldShowEditButton = false
                profileVC.pet = pet
            }
        }
        
        }
       
    

  

}
