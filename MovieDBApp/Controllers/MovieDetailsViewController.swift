//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labRunningTime: UILabel!
    @IBOutlet weak var labReleaseDate: UILabel!
    @IBOutlet weak var labGeneres: UILabel!
    @IBOutlet weak var labLanguages: UILabel!
    @IBOutlet weak var labVoteCount: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var movieVideoCollectionView: UICollectionView!
    
    let mdDataModel =  MovieDetailsViewModel()
    
    var movie: Movie?
    
    var arrMovie: [Movie]?
    
    var currentIndex: Int = 0
    
    private let reuseIdentifier = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.delegate = self
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.delegate = self
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Do any additional setup after loading the view.
        self.getSelectedMovieDetails()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getSelectedMovieDetails()
    {
        if let selMovie = self.movie
        {
            showLoading()
            
            mdDataModel.getMovieDetails(movieID: "\(selMovie.id)") { (movieDetails) in
                
                if movieDetails != nil
                {
                     self.loadMovieDetails()
                }
                
                self.hideLoading()
                
                self.mdDataModel.getMovieVideos(movieID: "\(selMovie.id)", completion: { (movieVideoColl) in
                    self.movieVideoCollectionView.reloadData()
                    
                })
                
            }
        }
    }
    
    func loadMovieDetails()
    {
        if let url = URL(string: "\(TheMovieDBAPIClient.IMAGE_BASE_URL)\(self.mdDataModel.movieDetails!.posterPath ?? "")")
        {
            self.imgMoviePoster.sd_setImage(with: url) { (image, error, cache, urls) in
                
                if (error != nil) {
                    self.imgMoviePoster.image = UIImage.gifImageWithName("loader")
                } else {
                    self.imgMoviePoster.image = image
                    self.imgMoviePoster.contentMode = .scaleAspectFill
                }
            }
        }
        
        self.title = self.mdDataModel.movieDetails?.title
        
        self.labTitle.text = (self.mdDataModel.movieDetails?.title)!
        
        self.labReleaseDate.text =  self.mdDataModel.movieDetails?.releaseDate
       
        self.labRunningTime.text = "\(self.mdDataModel.movieDetails?.runtime ?? 0)"
        self.labGeneres.text = self.mdDataModel.genres
        self.labLanguages.text = self.mdDataModel.languages
        
        self.ratingView.rating = (self.mdDataModel.movieDetails?.voteAverage)! / 2
        self.labVoteCount.text = "(\(self.mdDataModel.movieDetails?.voteCount ?? 0))"
        
        self.crewCollectionView.reloadData()
        
    }
    
}

extension MovieDetailsViewController: UIGestureRecognizerDelegate
{
    //MARK:- Swipe Gesture
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                
                if self.currentIndex > 0
                {
                    currentIndex -= 1
                    
                    self.movie = arrMovie![currentIndex]
                    self.getSelectedMovieDetails()
                }
                
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                
                if (currentIndex < (arrMovie?.count)! - 1 )
                {
                    currentIndex += 1
                    
                    self.movie = arrMovie![currentIndex]
                    self.getSelectedMovieDetails()
                }
                
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
            
        }
        
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == crewCollectionView
        {
            if  self.mdDataModel.movieCredits != nil
            {
                return (self.mdDataModel.movieCredits?.cast.count)!
            }
            else
            {
                return 0
            }
        }
        else if collectionView == movieVideoCollectionView
        {
            if  self.mdDataModel.movieVideoColl != nil
            {
                return (self.mdDataModel.movieVideoColl?.results.count)!
            }
            else
            {
                return 0
            }
        }
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == crewCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCreditsCollectionViewCell
            
            let movieCast = self.mdDataModel.movieCredits?.cast[indexPath.row]
            
            if let url = URL(string: "\(TheMovieDBAPIClient.IMAGE_BASE_URL)\(movieCast?.profile_path ?? "")")
            {
                cell.imgCrew.sd_setImage(with: url) { (image, error, cache, urls) in
                    
                    if (error != nil) {
                        cell.imgCrew.image = UIImage.gifImageWithName("loader")
                    } else {
                        cell.imgCrew.image = image
                        cell.imgCrew.contentMode = .scaleAspectFill
                    }
                }
            }
            
            cell.labName.text = movieCast?.name
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieVideoCollectionViewCell
            
            let movieVideo = self.mdDataModel.movieVideoColl!.results[indexPath.row]
            
            cell.labName.text = movieVideo.name
            cell.youtubeCom.youtubeVideoIdentifier = movieVideo.key
            return cell
        }
        
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
//        let cell = collectionView.cellForItem(at: indexPath) as? MovieListCollectionViewCell
    }
}
