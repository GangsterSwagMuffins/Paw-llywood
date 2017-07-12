//
//  TutorialPageViewController.swift
//  PetWorld
//
//  Created by my mac on 7/7/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse



class TutorialPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "PetNameViewController"),
                self.vcInstance(name: "PetPhotoUploadViewController"),
                  self.vcInstance(name: "TransitionToNormalViewController")]} ()
    
    
    
    var currIndex = 0;
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
            }
        
        }
    }
    
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TutorialPageViewController loaded!")
        self.delegate = self
        self.dataSource = self
        //Initialize the first pet
        let currentUser = PFUser.current() as! User
        let pet = Pet(className: "Pet")
        pet.saveInBackground()
        currentUser.petsArray.append(pet)
        
        
        
        
        
        if let firstViewController = vcArray.first{
           self.setViewControllers([firstViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            
            print("Found first View controller!")
        
        }else{
            print("Could not find first View controller!")
        }
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        
        guard let viewControllerIndex = vcArray.index(of: viewController) else{
             return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard vcArray.count > previousIndex else {
            return nil
        }
        
        
        return vcArray[previousIndex]
        
        
        
    }
    
   
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = vcArray.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = vcArray.count
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        
        guard viewControllersCount > nextIndex else{
            return nil
        }
        
        
        return vcArray[nextIndex]
        
        
    
    }
    
    
   
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count

}
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    guard let firstViewController = viewControllers?.first,
        let firstViewControllerIndex = vcArray.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
}
    
    func onCheckMarkTapped(sender: UIButton){
      let vc =  self.pageViewController(self, viewControllerAfter: vcInstance(name: "PetPhotoUploadViewController"))
        
        setViewControllers([vc!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        print("onCheckMarkTappedCalled!")
    
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
