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
     
        MRProgressOverlayView.showOverlayAdded(to: self.appdelegate.window, title: "Loading...", mode: .indeterminateSmall, animated: true)
        
    }
    
    func hideLoading()
    {
        MRProgressOverlayView.dismissOverlay(for: self.appdelegate.window, animated: true)
    }

}
