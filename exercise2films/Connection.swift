//
//  Connection.swift
//  exercise2films
//
//  Created by David on 16/9/21.
//

import UIKit

class Connection {
    private let url = "http://www.omdbapi.com/?apikey=4f7203f2&"
    
    func getConnection(urlString: String, extendUrl: String = "", completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        guard let url = URL(string: urlString + extendUrl) else {
            completion(nil, nil, nil)
            return
        }
        
        var urlRequest = URLRequest( url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            completion(data, response, error)
            
        }.resume()
    }
    
    func getMovie(id: String, completion: @escaping (_ movie: Movie? ) -> Void) {
        getConnection(urlString: url, extendUrl: "i=\(id)") { data, response, error in
            if let data = data {
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    completion(movie)
                } catch {
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
    }
    
    func getMovies(search: String, completion: @escaping (_ movies: [Search]? ) -> Void) {
        getConnection(urlString: url, extendUrl: "type=movie&s=\(search)") { data, response, error in
            if let data = data {
                do {
                    let movies = try JSONDecoder().decode(Movies.self, from: data)
                    completion(movies.search)

                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getPhoto(urlImage: String, completion: @escaping (_ image: UIImage? ) -> Void) {
        getConnection(urlString: urlImage) { data, response, error in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
}


