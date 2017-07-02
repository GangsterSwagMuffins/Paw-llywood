//
//  HomeViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
// 

import UIKit
import Parse
import AVFoundation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var feed: [PFObject] = []
    var posts: [Post] = []
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        let currentUser = PFUser.current()
        
        // Query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "_created_at")
        query.whereKey("author", equalTo: currentUser)
        
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.feed = posts
                for postMap in self.feed{
                    let post = Post()
                    post.constructor(postMap: postMap, tableView: self.tableView )
                    self.posts.append(post)
                    
                }
                
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
        
        
        
        
        print("Loading Home")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        var count = 1
        
        
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    self.tableView.reloadData()
    }
    
    // Table functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        //So we don't have to look at old pictures since we are reusing cells.
        if (cell.imageView?.image != nil){
            
            cell.imageView?.image = nil
        }
        
        
        
        cell.post = posts[indexPath.row]
        
       
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
