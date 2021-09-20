//
//  DetailViewModel.swift
//  exercise2films
//
//  Created by David on 17/9/21.
//

import Foundation

protocol DetailDelegate {
    func responseGetMovie(movie: Movie)
}

protocol DetailViewModelProtocol {
    func getMovie(id: String)
    var delegate: DetailDelegate? {get set}
}

class DetailViewModel {
    var delegate: DetailDelegate?
    
}

extension DetailViewModel: DetailViewModelProtocol {
    
    internal func getMovie(id: String) {
        
        Connection().getMovie(id: id) { movie in
            if let movie = movie {
                
                let genre = movie.genre?.components(separatedBy: ",")
                movie.genre = genre?.first
                
                DispatchQueue.main.async {
                    self.delegate?.responseGetMovie(movie: movie)
                }
                
            } else {
               print("Error")
            }
        }
    }
}
