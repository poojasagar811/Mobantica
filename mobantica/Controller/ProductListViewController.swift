//
//  ProductListViewController.swift
//  mobantica
//
//  Created by Crescendo Worldwide India on 26/06/24.
//

import UIKit

class ProductListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var category: String?
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        //MARK: Register the custom cell
        let nib = UINib(nibName: "ProductListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductListTableViewCell")
        setupNavigationBar()
        
        if let category = category {
            fetchProducts(for: category) { [weak self] products in
                guard let self = self else { return }
                
                if let products = products {
                    DispatchQueue.main.async {
                        self.products = products
                        self.tableView.reloadData()
                    }
                } else {
                    print("Failed to fetch products for category: \(category)")
                }
            }
        } else {
            print("Category is nil")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    //MARK: Custom back button
    private func setupNavigationBar() {
        
        let backButton = CustomBackButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    //MARK: Back button Action
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetails",
           let destinationVC = segue.destination as? ProductDetailViewController,
           let indexPath = sender as? IndexPath {
            destinationVC.product = products[indexPath.row]
        }
    }
    
}
func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error loading image: \(error)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("No data received for image")
            completion(nil)
            return
        }
        
        completion(UIImage(data: data))
    }.resume()
}

//MARK: Tableview Delegate and Datasource Method

extension ProductListViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        let product = products[indexPath.row]
        cell.productTitle.text = product.title
        cell.productCategory.text = product.category
        cell.productPrice.text = "₹ \(product.price)"
        
        if let url = URL(string: product.thumbnail) {
            loadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showProductDetails", sender: indexPath)
    }
}
