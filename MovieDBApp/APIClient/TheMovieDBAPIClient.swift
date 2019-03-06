//
//  TheMovieDBAPIClient.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class TheMovieDBAPIClient {
    
    let reachability = Reachability()!
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original/"
    private let API_HOST = "https://api.themoviedb.org/"
    
    private let API_KEY = "api_key=3a8de24a4f5adb03229457a0122fdb8d"
    
    
    private let NOW_PLAYING_ENDPOINT = "3/movie/now_playing"
    private let POPULAR_ENDPOINT = "3/movie/popular"
    private let UPCOMING_ENDPOINT = "3/movie/upcoming"
    private let MOVIE_DETAILS_ENDPOINT = "3/movie/"
    private let MOVIE_CREDITS = "/credits"
    private let MOVIE_VIDEO = "/videos"
    private let LANGUAGE = "language=en-US"
    
    private init(){}
    
    public static let shared = TheMovieDBAPIClient()
    
    /// Fetches Movie list
    public func fetchMovieList(movieType : MovieType, pageNumber: Int, completion callback: @escaping ((_ movieList: MovieList?, _ error: String?) -> Void)) {
        var error: String?
        
        var urlStr = ""
        
        var movieList : MovieList?
        
        switch movieType {
        case .NOW_PLAYING:
            urlStr = "\(API_HOST)\(NOW_PLAYING_ENDPOINT)"
            break
        case .POPULAR:
            urlStr = "\(API_HOST)\(POPULAR_ENDPOINT)"
            break
        case .UPCOMING:
            urlStr = "\(API_HOST)\(UPCOMING_ENDPOINT)"
            break
        }
        
        urlStr = "\(urlStr)?\(API_KEY)&\(LANGUAGE)&page=\(pageNumber)"
        
        if reachability.connection != .none
        {
            Alamofire.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: {
                    response in
                    // Guarantee that we get response with the HTTP status code 200.
                    guard response.response?.statusCode == 200 else {
                        error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
                        callback(movieList!, error)
                        return
                    }
                    
                    error = response.error?.localizedDescription
                    
                    if let dataResponse = response.data {
                        do {
                            //here dataResponse received from a network request
                            let decoder = JSONDecoder()
                            movieList = try decoder.decode(MovieList.self, from:
                                dataResponse) //Decode JSON Response Data
                            print(movieList)
                        } catch let parsingError {
                            print("Error", parsingError)
                        }
                    }
                    
                    callback(movieList, error)
                    
                })
        }
        else
        {
             callback(movieList, error)
        }
        
    }
    
    public func fetchMovieDetails(movieID: String, completion callback: @escaping ((_ movieDetails: MovieDetails?, _ error: String?) -> Void)) {
        var error: String?
        
        let urlStr = "\(API_HOST)\(MOVIE_DETAILS_ENDPOINT)\(movieID)?\(API_KEY)&\(LANGUAGE)"
        
        if reachability.connection != .none
        {
            Alamofire.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: {
                    response in
                    // Guarantee that we get response with the HTTP status code 200.
                    guard response.response?.statusCode == 200 else {
                        error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
                        callback(nil, error)
                        return
                    }
                    
                    error = response.error?.localizedDescription
                    
                    if let dataResponse = response.data {
                        do {
                            //here dataResponse received from a network request
                            let decoder = JSONDecoder()
                            let movieDetetails = try decoder.decode(MovieDetails.self, from:
                                dataResponse) //Decode JSON Response Data
                            callback(movieDetetails, error)
                        } catch let parsingError {
                            print("Error", parsingError)
                            callback(nil, error)
                        }
                    }
                    else
                    {
                        callback(nil, error)
                    }
                })
        }
        else
        {
            callback(nil, error)
        }
    }
    
    public func fetchMovieCredits(movieID: String, completion callback: @escaping ((_ movieCredits: MovieCredits?, _ error: String?) -> Void)) {
        var error: String?
        
        let urlStr = "\(API_HOST)\(MOVIE_DETAILS_ENDPOINT)\(movieID)\(MOVIE_CREDITS)?\(API_KEY)&\(LANGUAGE)"
        
        if reachability.connection != .none
        {
            Alamofire.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: {
                    response in
                    // Guarantee that we get response with the HTTP status code 200.
                    guard response.response?.statusCode == 200 else {
                        error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
                        callback(nil, error)
                        return
                    }
                    
                    error = response.error?.localizedDescription
                    
                    if let dataResponse = response.data {
                        do {
                            //here dataResponse received from a network request
                            let decoder = JSONDecoder()
                            let movieCredits = try decoder.decode(MovieCredits.self, from:
                                dataResponse) //Decode JSON Response Data
                            callback(movieCredits, error)
                        } catch let parsingError {
                            print("Error", parsingError)
                            callback(nil, error)
                        }
                    }
                    else
                    {
                        callback(nil, error)
                    }
                })
        }
        else
        {
            callback(nil, error)
        }
    }
    
    public func fetchMovieVideos(movieID: String, completion callback: @escaping ((_ movieVideoColl: MovieVideoCollection?, _ error: String?) -> Void)) {
        var error: String?
        
        let urlStr = "\(API_HOST)\(MOVIE_DETAILS_ENDPOINT)\(movieID)\(MOVIE_VIDEO)?\(API_KEY)&\(LANGUAGE)"
        
        if reachability.connection != .none
        {
            Alamofire.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: {
                    response in
                    // Guarantee that we get response with the HTTP status code 200.
                    guard response.response?.statusCode == 200 else {
                        error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
                        callback(nil, error)
                        return
                    }
                    
                    error = response.error?.localizedDescription
                    
                    if let dataResponse = response.data {
                        do {
                            //here dataResponse received from a network request
                            let decoder = JSONDecoder()
                            let movieVideoColl = try decoder.decode(MovieVideoCollection.self, from:
                                dataResponse) //Decode JSON Response Data
                            callback(movieVideoColl, error)
                        } catch let parsingError {
                            print("Error", parsingError)
                            callback(nil, error)
                        }
                    }
                    else
                    {
                        callback(nil, error)
                    }
                })
        }
        else
        {
            callback(nil, error)
        }
    }
}

enum MovieType
{
    case NOW_PLAYING
    case POPULAR
    case UPCOMING
}
