//
//  SearchPetsViewController.swift
//  PetWorld
//
//  Created by my mac on 8/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class SearchPetsViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetDescription", for: indexPath) as! PetDescriptionCellTableViewCell
        
        cell.pet = posts[indexPath.row]
        
        return cell
        
        
    
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return posts.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        NetworkAPI.s
        
    }
    

  

}
