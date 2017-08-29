//
//  GalleryViewController.swift
//  PetWorld
//
//  Created by my mac on 5/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var topBar: HeaderView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var chosenPicture: UIImageView!
    
    
    
    
    //Member vars/consts
    var assetCollection: PHAssetCollection! //Specific folder (Camera Roll)
    var photosAsset: PHFetchResult<PHAsset>!// Actual photos in the folder
    
    var lastCellIndex: IndexPath?
    
    var finishedCallback: ((Void) -> (Void))?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.titleText.textColor = UIColor.white
        self.topBar.leftButton.tintColor = UIColor.white
        
        self.topBar.rightButton.tintColor = UIColor.white
        
        self.topBar.onRightClickCallBack = {
            self.performSegue(withIdentifier: "VerifySegue", sender: nil)
        }
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.topBar.onClickCallBack = {
            //Do this function when action button is pressed!
            
            print("is the finished call back nil \(self.finishedCallback == nil)" )
            self.dismiss(animated: true, completion: { 
                //Here should go call back to dismiss post media tab view controller
                if let finshed = self.finishedCallback{
                    finshed()
                    print("finished called!!!")
                }
            })
        }
        
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
            
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 400, height: 400), contentMode: .aspectFill, options: nil) { (result:UIImage?, info: [AnyHashable : Any]?) in
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        print("Size called!")
        let screen = UIScreen.main.bounds
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height
        
        return CGSize(width: collectionView.frame.size.width/3 - 1, height: screenHeight / 6)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCell", for: indexPath) as! GalleryItemCellCollectionViewCell
        
        let asset = self.photosAsset[indexPath.item] as! PHAsset
   
        PHImageManager.default().requestImage(for: asset, targetSize: cell.galleryPhoto.frame.size, contentMode: .aspectFill, options: nil) { (result:UIImage?, info: [AnyHashable : Any]?) in
            cell.setGalleryPhoto(image: result!)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell index: \(indexPath.item)")
        print("press detected")
        
      /*  if (self.lastCellIndex != nil){
            self.collectionView.deselectItem(at: lastCellIndex!, animated: true)
        
        }*/
        
        //Update the new last cell
        lastCellIndex = indexPath
      
   
        let cell : GalleryItemCellCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCell", for: indexPath) as! GalleryItemCellCollectionViewCell
        
        
        
        //Extract the gallery image and present it to the user
        
        let asset = self.photosAsset[indexPath.item] as! PHAsset
        
        
        
        PHImageManager.default().requestImage(for: asset, targetSize: chosenPicture.frame.size, contentMode: .aspectFill, options: nil) { (result:UIImage?, info: [AnyHashable : Any]?) in
            self.chosenPicture.image = result
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using
        let destVc: VerifyPhotoViewController = segue.destination as! VerifyPhotoViewController
        
        // Pass the selected object to the new view controller.
        destVc.picture = self.chosenPicture.image
        
        destVc.exitCallback = {
            self.dismiss(animated: false, completion: {
                self.finishedCallback?()
            })
        }
        
        
    }
    

}
