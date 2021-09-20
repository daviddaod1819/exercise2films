//
//  DetailViewModel.swift
//  exercise2films
//
//  Created by David on 17/9/21.
//

import UIKit

protocol DetailDelegate {
    func responseGetMovie(movie: Movie)
}

protocol DetailViewModelProtocol {
    var id: String? {get set}
    func getMovie(id: String)
    var delegate: DetailDelegate? {get set}
}

class DetailViewModel {
    var id: String?
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
