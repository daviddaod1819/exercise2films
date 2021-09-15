//
//  ViewController.swift
//  exercise2films
//
//  Created by David on 14/9/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var filmCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        
        if collectionView.restorationIdentifier == "filmCollectionView" {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCollectionViewCell
        } else if collectionView.restorationIdentifier == "categoriesCollectionView" {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            cell.layer.cornerRadius = 12.0
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmPosterCell", for: indexPath) as! FilmPosterCollectionViewCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.restorationIdentifier != "categoriesCollectionView" {
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

