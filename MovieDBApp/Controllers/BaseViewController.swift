//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Ramesh on 01/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit
import MRProgress

class BaseViewController: UIViewController {
    
    let appdelegate =  UIApplication.shared.delegate as! AppDelegate
    //var overlay : MRProgressOverlayView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showLoading()
    {
     
        let overlay = MRProgressOverlayView.showOverlayAdded(to: self.appdelegate.window, animated: true)

        overlay!.mode = .indeterminateSmall
        
        overlay!.tintColor = UIColor.init(red: 7/255, green: 28/255, blue: 36/255, alpha: 1)
        
        overlay!.titleLabelText = "Loading..."
        
        overlay!.titleLabel.superview?.backgroundColor =  UIColor.init(red: 1/255, green: 209/255, blue: 119/255, alpha: 1)
        
    }
    
    func hideLoading()
    {
        MRProgressOverlayView.dismissOverlay(for: self.appdelegate.window, animated: true)
    }

}
