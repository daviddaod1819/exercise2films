//
//  MainViewModel.swift
//  exercise2films
//
//  Created by David on 17/9/21.
//

import UIKit

protocol MainViewModelProtocol {
    
    var movies: [Int : [Search]] {get set}
    var id: String? {get set}
    var i: Int {get set}
    var categories: [String] {get}
    
    func getMovies(_ search: String)
    
    var delegate: MainViewModelDelegate? {get set}
}

protocol MainViewModelDelegate {
    func responseGetMovies(count: Int, i: Int)
}

class MainViewModel {
    
    var movies: [Int: [Search]] = [:]
    
    var id: String?
    
    var i: Int = 0
    
    var categories: [String] = ["Action", "Adventure", "Sci-Fi", "Horror"]
    
    var delegate: MainViewModelDelegate?
    
    
}

extension MainViewModel: MainViewModelProtocol {
    
    internal func getMovies(_ search: String) {
        
        let i = self.i
        
        Connection().getMovies(search: search) { movies in
            if let movies = movies  {
                
                self.movies[i] = movies
                
                DispatchQueue.main.async {
                    self.delegate?.responseGetMovies(count: movies.count, i: i)
                }
                
            } else {
                print("Error")
                DispatchQueue.main.async {
                    self.delegate?.responseGetMovies(count: 0, i: i)
                }
            }
        }
        
        self.i += 1
    }
}
