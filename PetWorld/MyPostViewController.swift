//
//  PublicPostViewController.swift
//  PetWorld
//
//  Created by my mac on 8/3/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import MBProgressHUD

class MyPostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    var posts: [Post] = []
    var isLoading: Bool = false
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        self.collectionView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (!isLoading){
            print("loadPosts")

            loadPosts()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PublicPostCell", for: indexPath)as! PublicPostCollectionViewCell
        
        cell.post = posts[indexPath.row]
        
        return cell
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    func loadPosts(){
        
        isLoading = true
        
        NetworkAPI.getMyPosts(numPosts: 20, successHandler: { (posts: [Post]) in
            self.posts = posts
            self.isLoading  = false
            self.collectionView.reloadData()
        }) { (error: Error) in
            self.isLoading = false
            print(error)
        }
        
    }

}
