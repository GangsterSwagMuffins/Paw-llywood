//
//  GalleryViewController.swift
//  PetWorld
//
//  Created by my mac on 5/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var chosenPicture: UIImageView!
    
    
    
    //Member vars/consts
    var assetCollection: PHAssetCollection! //Specific folder (Camera Roll)
    var photosAsset: PHFetchResult<PHAsset>!// Actual photos in the folder
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Camera roll is "smart album" because it collects photos on it's own!
        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        let options = PHFetchOptions()
        
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if (collection.firstObject != nil){ //If there the collections actually returned something
            //Found the album
            self.assetCollection = collection.firstObject! as PHAssetCollection
            print("collection has \(collection.count) many photos!")
            // Do any additional setup after loading the view.
              photosAsset = PHAsset.fetchAssets(in: self.assetCollection, options: options)
              print("Here is the colleciton size: \(photosAsset.count)")
            
            //Let the first element be the default image chosen
            let asset = self.photosAsset[0] as! PHAsset
            
            
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (result:UIImage?, info: [AnyHashable : Any]?) in
                    self.chosenPicture.image = result
            }
                
            
            
            
        }else{
            //Could not find the camera roll for some reason...
            print("Trouble finding the camera roll!")
        }
        
       
        
      
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (photosAsset != nil){
      return photosAsset.count
        }
        
        return 0
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCell", for: indexPath) as! GalleryItemCellCollectionViewCell
        
        let asset = self.photosAsset[indexPath.item] as! PHAsset
        
        
        
        PHImageManager.default().requestImage(for: asset, targetSize: cell.galleryPhoto.frame.size, contentMode: .aspectFill, options: nil) { (result:UIImage?, info: [AnyHashable : Any]?) in
            cell.setGalleryPhoto(image: result!)
        }
        
        
        
        
        
        
        
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