//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Ramesh on 01/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var refreshControl : UIRefreshControl!
    
    var currentMovieType: MovieType?
    
    let mlDataModel =  MovieListViewModel()
    
    var arrMovies: [Movie] = [Movie]()
    
    
    private let reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let movieType = self.currentMovieType
        {
            switch movieType {
            case MovieType.NOW_PLAYING:
                self.title = "NOW PLAYING"
                break
            case MovieType.POPULAR:
                self.title = "POPULAR"
                break
            case MovieType.UPCOMING:
                self.title = "UPCOMING"
                break
            }
        }
        
        self.loadMoviesList(isPaging: false)
        
        self.refreshControl = UIRefreshControl()
        self.collectionView.addSubview(refreshControl)
        self.refreshControl!.addTarget(self, action: #selector(self.refreshMovieList), for: UIControl.Event.valueChanged)
        self.refreshControl?.layoutSubviews()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToMovieDetailsSegue" {
            if let vcMovieDet = segue.destination as? MovieDetailsViewController
            {
                if let cell = sender as? MovieListCollectionViewCell
                {
                    vcMovieDet.movie = cell.movie
                    vcMovieDet.arrMovie = self.arrMovies
                    vcMovieDet.currentIndex = cell.selectedIndex
                }
            }
        }
    }
    
    @objc func refreshMovieList()
    {
       
        if self.refreshControl!.isRefreshing{
            self.refreshControl!.endRefreshing()
        }
        
        self.loadMoviesList(isPaging: false)
        
    }
    
    func loadMoviesList(isPaging : Bool)
    {
        if let movieType = self.currentMovieType
        {
            self.showLoading()
            
            self.mlDataModel.getMovieList(movieType: movieType, isPaging: isPaging) { (arrMovie) in
                
                self.arrMovies = arrMovie
                self.collectionView.reloadData()
                
                self.hideLoading()
                
            }
        }
        
    }

}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieListCollectionViewCell
        
        let movie = arrMovies[indexPath.row]
       
        if let url = URL(string: "\(TheMovieDBAPIClient.IMAGE_BASE_URL)\(movie.posterPath ?? "")")
        {
            cell.imgMoviePoster.sd_setImage(with: url) { (image, error, cache, urls) in
                
                if (error != nil) {
                     cell.imgMoviePoster.image = UIImage.gifImageWithName("loader")
                } else {
                    cell.imgMoviePoster.image = image
                    cell.imgMoviePoster.contentMode = .scaleAspectFill
                }
            }
        }
        
        cell.labMovieTitle.text = movie.title
        cell.labMovieRating.text = "\(movie.voteAverage)"
        cell.ratingView.rating = movie.voteAverage / 2
        
        cell.movie = movie
        cell.selectedIndex = indexPath.row
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width  / 3
        
        return CGSize(width: width, height: width + ( width / 2) + 50 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arrMovies.count - 1 && !self.mlDataModel.isPagingLoading && !self.mlDataModel.isAllMoviesLoaded && !mlDataModel.isSearching {
            self.loadMoviesList(isPaging: true)
        }
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let cell = collectionView.cellForItem(at: indexPath) as? MovieListCollectionViewCell
        
         performSegue(withIdentifier: "ToMovieDetailsSegue", sender: cell)
    }
}

extension MovieListViewController: UISearchBarDelegate{
    
    
    //MARK:- SearchBar Delegates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if (searchBar.text?.count)! >= 3
        {
           self.arrMovies = mlDataModel.searchMovie(strMovieTitle: (searchBar.text?.trimmingCharacters(in: .whitespaces))!)
            self.collectionView.reloadData()
        }
        else
        {
            if mlDataModel.isSearching
            {
                self.arrMovies = mlDataModel.cancelSearch()
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
    }
    
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if mlDataModel.isSearching
        {
            self.arrMovies = mlDataModel.cancelSearch()
            self.collectionView.reloadData()
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
    }
}

