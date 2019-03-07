//
//  MovieListViewTests.swift
//  MovieDBAppTests
//
//  Created by Ramesh on 07/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import XCTest
@testable import MovieDBApp

class MovieListViewTests: XCTestCase {
    
    var mlDataModel:MovieListViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        mlDataModel = MovieListViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        mlDataModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToGetMovieListForNowPlaying()
    {
        mlDataModel.getMovieList(movieType: .NOW_PLAYING, isPaging: true) { (arrMovie) in
            
            XCTAssertTrue(arrMovie.count > 0)
            
        }
    }
    
    func testToGetMovieListForPopular()
    {
        mlDataModel.getMovieList(movieType: .POPULAR, isPaging: false) { (arrMovie) in
            
            XCTAssertTrue(arrMovie.count > 0)
            
        }
    }
    
    func testToGetMovieListForUpcoming()
    {
        mlDataModel.getMovieList(movieType: .UPCOMING, isPaging: true) { (arrMovie) in
            
            XCTAssertTrue(arrMovie.count > 0)
            
        }
    }
    
    func testSearchMovieInList()
    {
        mlDataModel.getMovieList(movieType: .NOW_PLAYING, isPaging: false) { (arrMovie) in
            
            XCTAssertFalse(arrMovie.count == 0)
            
            if arrMovie.count > 0
            {
                let searchMovie = "Captain"
                
                let arrSearchMovie = self.mlDataModel.searchMovie(strMovieTitle: searchMovie)
                
                XCTAssertFalse(arrSearchMovie.count == 0)
                
                let checkSearch = arrSearchMovie.filter{($0.title?.contains(searchMovie))!}
                
                XCTAssertEqual(checkSearch.count, arrSearchMovie.count, "Search working wrong")
                
            }
            
        }
    }

}
