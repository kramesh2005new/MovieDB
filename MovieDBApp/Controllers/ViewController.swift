//
//  ViewController.swift
//  MovieDBApp
//
//  Created by Ramesh on 06/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiClient = TheMovieDBAPIClient.shared
    
    var selectedMovieType: MovieType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func buttNowPlaying_TouchDown(_ sender: Any) {
        
        self.moveToMovieListScreen(movieType: .NOW_PLAYING)
        
    }
    
    @IBAction func buttPopular_TouchDown(_ sender: Any) {
        
        self.moveToMovieListScreen(movieType: .POPULAR)
        
    }
    
    @IBAction func buttUpcoming_TouchDown(_ sender: Any) {
        
        self.moveToMovieListScreen(movieType: .UPCOMING)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToMovieListSegue" {
            if let vcMovieList = segue.destination as? MovieListViewController
            {
                vcMovieList.currentMovieType = selectedMovieType
            }
        }
    }
    
    func moveToMovieListScreen(movieType: MovieType)
    {
        selectedMovieType = movieType
        
        performSegue(withIdentifier: "ToMovieListSegue", sender: nil)
    }
    
    
}

