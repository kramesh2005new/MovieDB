//
//  MovieListTableViewModel.swift
//  MovieApp
//
//  Created by Ramesh on 01/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieListViewModel {
    
    let apiClient = TheMovieDBAPIClient.shared
    
    var currentMovieList: MovieList?
    
    var arrMovies: [Movie] = [Movie]()
    
    var arrSearchMovies: [Movie] = [Movie]()
    
    var isPagingLoading: Bool = false
    
    var isAllMoviesLoaded: Bool = false
    
    var isSearching : Bool = false
    
    func getMovieList(movieType: MovieType, isPaging: Bool, completion: @escaping ([Movie]) -> ())
    {
        var pageNumberToFetch = 1
        
        if isPaging
        {
            if let mList = currentMovieList
            {
                if mList.page == mList.total_pages
                {
                    isAllMoviesLoaded = true
                    completion(self.arrMovies)
                    return
                }
                
                pageNumberToFetch = mList.page + 1
            }
        }
        else
        {
            currentMovieList = nil
            arrMovies = [Movie]()
        }
        
        isPagingLoading = true
        
        apiClient.fetchMovieList(movieType: movieType, pageNumber: pageNumberToFetch) { (movieList, error) in
            
            self.isPagingLoading = false
            
            if let mList = movieList
            {
                self.currentMovieList = mList
                self.arrMovies.append(contentsOf: (self.currentMovieList?.results)!)
                
                completion(self.arrMovies)
            }
            else
            {
                completion(self.arrMovies)
            }
            
        }

    }
    
    func searchMovie(strMovieTitle: String) -> [Movie]
    {
        arrSearchMovies = arrMovies.filter{ ($0.title?.contains(strMovieTitle))!}
        
        self.isSearching = true
        
        return arrSearchMovies
    }
    
    func cancelSearch() -> [Movie]
    {
        self.isSearching = false
        
        arrSearchMovies = [Movie]()
        
        return arrMovies
    }
    

}
