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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.cornerRadius = 20
        categoryView.layer.cornerRadius = 20
        duractionView.layer.cornerRadius = 20
        startsView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
