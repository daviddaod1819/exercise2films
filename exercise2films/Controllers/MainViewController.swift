//
//  ViewController.swift
//  exercise2films
//
//  Created by David on 14/9/21.
//

import UIKit

class MainViewController: UIViewController  {
    
    @IBOutlet weak var filmCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var recommendedFilmCollectionView: UICollectionView!
    @IBOutlet weak var movies1: UILabel!
    @IBOutlet weak var movies2: UILabel!
    @IBOutlet weak var errorMovies1: UILabel!
    @IBOutlet weak var errorMovies2: UILabel!
    
    var viewModel: MainViewModelProtocol = MainViewModel()
    var posters: [Int: [UIImage?]] = [:]
    var posterIndexes: [Int] = [0, 0]
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        let search1 = "Batman"
        let search2 = "Superman"
        
        movies1.text = "\(search1) movies"
        movies2.text = "\(search2) movies"
        
        viewModel.getMovies(search1)
        viewModel.getMovies(search2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destination
            if let detailViewController = detailViewController as? DetailViewController {
                detailViewController.id = id
                detailViewController.poster = posters[posterIndexes[0]]?[posterIndexes[1]]
            }
        }
    }
    
    func getPhoto(poster: String?, indexPath: IndexPath, collectonView: UICollectionView) {
        
        if let poster = poster {
            Connection().getPhoto(urlImage: poster) { image in
                if let image = image {
                    
                    DispatchQueue.main.async {
                    
                        self.fillPosters(image: image.resizeImage(width: 280) ?? image, indexPath: indexPath, collectonView: collectonView)
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        self.fillPosters(image: UIImage(named: "no-image"), indexPath: indexPath, collectonView: collectonView)
                    }
                }
            }
        }
    }
    
    func fillPosters(image: UIImage?, indexPath: IndexPath, collectonView: UICollectionView) {
        
        if collectonView.restorationIdentifier == "filmCollectionView" {
            self.posters[0]?[indexPath.row] = image
            
        } else {
            
            self.posters[1]?[indexPath.row] = image
        }
        
        collectonView.reloadItems(at: [indexPath])
    }
    
}


//MARK: MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    
    func responseGetMovies( count: Int, i: Int ) {
        
        if count == 0 {
            
            if i == 0 {
                errorMovies1.isHidden = false
                filmCollectionView.isHidden = true
            } else {
                errorMovies2.isHidden = false
                recommendedFilmCollectionView.isHidden = true
            }
            
            return
        }
        
        posters[i] = [UIImage?](repeating: nil, count: count)
        
        if i == 0 {
            filmCollectionView.reloadData()
        } else {
            recommendedFilmCollectionView.reloadData()
        }
    }
}


//MARK: CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        
            case "filmCollectionView":
                return viewModel.movies[0]?.count ?? 0
                
            case "categoriesCollectionView":
                return viewModel.categories.count
                
            default:
                return viewModel.movies[1]?.count ?? 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        
            case "filmCollectionView":
                
                let movies = viewModel.movies[0] ?? []
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCollectionViewCell
                cell.titleLabel.text = movies[indexPath.row].title
                
                if posters[0]?[indexPath.row] == nil {
                    getPhoto(poster: movies[indexPath.row].poster, indexPath: indexPath, collectonView: collectionView)
                }
                
                cell.filmImageView.image = posters[0]?[indexPath.row] ?? UIImage(named: "no-image")
                
                return cell
                
            case "categoriesCollectionView":
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
                cell.layer.cornerRadius = 12.0
                cell.backgroundColor =  UIColor(red: CGFloat.random(in: 0...0.5), green: CGFloat.random(in: 0...0.5), blue: CGFloat.random(in: 0...0.5), alpha: 1)
                cell.categoryLabel.text = viewModel.categories[indexPath.row]
                return cell
                
            default:
                
                let movies = viewModel.movies[1] ?? []
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmPosterCell", for: indexPath) as! FilmPosterCollectionViewCell
                
                if posters[1]?[indexPath.row] == nil {
                    getPhoto(poster: movies[indexPath.row].poster, indexPath: indexPath, collectonView: collectionView)
                }
                
                cell.filmPosterImageView.image = posters[1]?[indexPath.row] ?? UIImage(named: "no-image")
                
                return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.restorationIdentifier {
        
            case "filmCollectionView":
                let movies = viewModel.movies[0] ?? []
                
                id = movies[indexPath.row].imdbID
                
                posterIndexes = [0, indexPath.row]
                
                performSegue(withIdentifier: "detailSegue", sender: nil)
                
            case "filmPosterCollectionView":
                let movies = viewModel.movies[1] ?? []
                
                id = movies[indexPath.row].imdbID
                
                posterIndexes = [1, indexPath.row]
                
                performSegue(withIdentifier: "detailSegue", sender: nil)
                
            default:
                return
        }
    }
    
    
}

