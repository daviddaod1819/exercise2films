//
//  DetailViewController.swift
//  exercise2films
//
//  Created by David on 16/9/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var duractionView: UIView!
    @IBOutlet weak var startsView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    
    var viewModel: DetailViewModelProtocol = DetailViewModel()
    var poster: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        self.posterImageView.image = poster
        
        makeCornerRadius()
        
        if let id = viewModel.id {
            viewModel.getMovie(id: id)
        }
    }
    
    func makeCornerRadius() {
        titleView.layer.cornerRadius = 20
        categoryView.layer.cornerRadius = 20
        duractionView.layer.cornerRadius = 20
        startsView.layer.cornerRadius = 20
    }

}


extension DetailViewController: DetailDelegate {
    
    func responseGetMovie(movie: Movie) {
        self.titleLabel.text = movie.title
        self.synopsisTextView.text = movie.plot
        self.categoryLabel.text = movie.genre
        self.starsLabel.text = movie.imdbRating
        self.durationLabel.text = movie.runtime
        
        self.directorLabel.text = movie.director
        self.productionLabel.text = movie.production
        
    }
}
