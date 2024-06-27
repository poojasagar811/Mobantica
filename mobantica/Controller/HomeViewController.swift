//
//  HomeViewController.swift
//  mobantica
//
//  Created by Crescendo Worldwide India on 26/06/24.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController {
    var selectedCategory: String?
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.roundCorners(corners:  [.topLeft, .topRight], radius: 30)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    @IBAction func beautyBtnTapped(_ sender: Any) {
        selectedCategory = "beauty"
        performSegue(withIdentifier: "productList", sender: self)
    }
    
    @IBAction func fragranceBtnTapped(_ sender: Any) {
        selectedCategory = "fragrances"
        performSegue(withIdentifier: "productList", sender: self)
    }
    
    @IBAction func groceriesBtnTapped(_ sender: Any) {
        selectedCategory = "groceries"
        performSegue(withIdentifier: "productList", sender: self)
    }
    
    @IBAction func furnitureBtnTapped(_ sender: Any) {
        selectedCategory = "furniture"
        performSegue(withIdentifier: "productList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productList" {
            if let destinationVC = segue.destination as? ProductListViewController,
               let category = selectedCategory {
                destinationVC.category = category
            }
        }
    }
    
}
