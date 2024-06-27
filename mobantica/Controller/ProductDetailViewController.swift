//
//  ProductDetailViewController.swift
//  mobantica
//
//  Created by apple on 26/06/24.
//

import UIKit
import Cosmos

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionnLabel: UILabel!
    @IBOutlet var conntentView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var returnPolicyLabel: UILabel!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        if let product = product {
            titleLabel.text = product.title
            categoryLabel.text = product.category
            descriptionnLabel.text = product.description
            ratingLabel.text = "\(product.rating)"
            priceLabel.text = "₹ \(product.price)"
            reviewCount.text = "( \(product.reviews.count) reviews )"
            cosmosView.rating = product.rating
            returnPolicyLabel.text = "Return Policy : \(product.returnPolicy)"
            
            // Load the thumbnail image
            if let url = URL(string: product.thumbnail) {
                loadImage(from: url) { image in
                    DispatchQueue.main.async {
                        self.thumbnailImage.image = image
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    //MARK: Review button Action
    
    @IBAction func reviewAction(_ sender: Any) {
        performSegue(withIdentifier: "reviewDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewDetails",
           let destinationVC = segue.destination as? reviewViewController {
            destinationVC.reviews = product?.reviews ?? []
        }
    }
    
    //MARK: Custom back button

    private func setupNavigationBar() {
        let backButton = CustomBackButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
