//
//  SearchPetsViewController.swift
//  PetWorld
//
//  Created by my mac on 8/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class SearchPetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchBarDelegate, UIScrollViewDelegate {
    
    
    
   

   @IBOutlet weak var searchView: SearchView!
    
    var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var pets: [Pet] = []
    
    var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    var onDismiss: (()->())!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
          self.searchView.searchBar.becomeFirstResponder()
        self.searchBar = self.searchView.searchBar
        self.searchBar.showsCancelButton = true
        
        self.searchBar.delegate = self
        self.searchBar.barTintColor = UIColor.white
        let attributes = [
            NSForegroundColorAttributeName : ColorPalette.primary
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        self.searchBar.tintColor = ColorPalette.primary
       self.searchBar.tintColor = ColorPalette.primary
        
var textField = self.searchBar.value(forKey: "searchField") as? UITextField
        textField?.textColor = ColorPalette.primary
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       print("dismiss")
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pets.count
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "ProfileSegue", sender: indexPath )
        
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print("searching.... \(searchText)")
        self.searchBar.showsCancelButton = true
        
        if (!searchText.isEmpty){
            NetworkAPI.searchPets(withName: searchText, successHandler: { (pets: [Pet]) -> (Void) in
                self.pets = pets
                self.tableView.reloadData()
                print("Pets loaded:\n\(pets)")
                
            }) { (error: Error) in
                print("Could not search for the pets!\n\(error)")
            }
        }
       
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolling....")
       let currentOffset: CGPoint = scrollView.contentOffset
        if (currentOffset.y > self.lastContentOffset.y)
        {
            self.searchBar.resignFirstResponder()
        }else{
            print("")
        }
        
        self.lastContentOffset = currentOffset;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let sender = sender{
            if (sender is IndexPath){
                let indexPath = sender as! IndexPath
                var pet = pets[indexPath.row]
                let profileVC = segue.destination as! ProfileViewController
                profileVC.shouldShowEditButton = false
                profileVC.pet = pet
                
               // profileVC.dismissCallback
            }
        }
        
        }
       
    

  

}
