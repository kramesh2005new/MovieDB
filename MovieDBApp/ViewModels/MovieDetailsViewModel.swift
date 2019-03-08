//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieDetailsViewModel: NSObject {
    
    let apiClient = TheMovieDBAPIClient.shared
    
    let general = General()
    
    var movieDetails: MovieDetails?
    
    var movieCredits: MovieCredits?
    
    var movieVideoColl: MovieVideoCollection?
    
    var languages = ""
    
    var genres = ""
    
    func getMovieDetails(movieID: String, completion: @escaping (MovieDetails?) -> ())
    {
        apiClient.fetchMovieDetails(movieID: movieID) { (movieDetails, error) in
            
            self.movieDetails = movieDetails
            if self.movieDetails != nil
            {
                let arrLanguages = (self.movieDetails?.spokenLanguages)!.map{ $0.name }
                
                self.languages = arrLanguages.joined(separator: ", ")
                
                let arrGenres = (self.movieDetails?.genres)!.map{ $0.name}
                
                self.genres = arrGenres.joined(separator: ", ")
                
                if let strReleaseDate = self.movieDetails?.releaseDate
                {
                    self.movieDetails?.releaseDate = self.general.formatDate(dateStr: strReleaseDate)
                }
                else
                {
                    self.self.movieDetails?.releaseDate = ""
                }
                
                self.getMovieCredits(movieID: movieID, completion: { (movieCredits) in
                    
                    self.movieCredits = movieCredits
                    
                    completion(movieDetails)
                    
                })
                
            }
            else
            {
                self.languages = ""
                self.genres = ""
                
                completion(movieDetails)
            }
            
        }
        
    }
    
    func getMovieCredits(movieID: String, completion: @escaping (MovieCredits?) -> ())
    {
        apiClient.fetchMovieCredits(movieID: movieID) { (movieCredits, error) in
            
            completion(movieCredits)
            
        }
    }
    
    func getMovieVideos(movieID: String, completion: @escaping (MovieVideoCollection?) -> ())
    {
        apiClient.fetchMovieVideos(movieID: movieID) { (movieVideoColl, error) in
            
            self.movieVideoColl = movieVideoColl
            
            completion(movieVideoColl)
            
        }
    }

}
