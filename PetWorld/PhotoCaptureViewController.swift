//
//  PhotoCaptureViewController.swift
//  PetWorld
//
//  Created by my mac on 5/25/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoCaptureViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set up camera here.....
        
        //Create a new session
        
        
        session = AVCaptureSession()
        //Configure the session for med res capture (So it's under 10 mb limit)
        session!.sessionPreset = AVCaptureSessionPresetMedium
        
        //We select the back camera as the default input device
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        //Create a new AVCaptureDeviceInput
        //and associate it with the backcamera
        
        //Chance that input device is not
        //available so...
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do{
            
            
            input = try AVCaptureDeviceInput(device: backCamera)
        }catch let error1 as NSError{
            
            error = error1
            input = nil
            print(error!.localizedDescription)
            
        }
        
        
        
        if error == nil && session!.canAddInput(input){
            
            session!.addInput(input)
            
        }
        
        
        
        //Configuring the output....
        
        stillImageOutput = AVCapturePhotoOutput()
        let settings = AVCapturePhotoSettings()
        
        if session!.canAddOutput(stillImageOutput){
            session!.addOutput(stillImageOutput)
            //Configure live preview here....
            
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            
            previewView.layer.addSublayer(videoPreviewLayer!)
            
            session!.startRunning()
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.videoPreviewLayer?.frame = previewView.bounds
        
    }
    
    
    
    @IBAction func didTakePhoto(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
