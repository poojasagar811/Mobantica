//
//  reviewViewController.swift
//  mobantica
//
//  Created by Crescendo Worldwide India on 27/06/24.
//

import UIKit

class reviewViewController: UIViewController {
    var reviews: [Review] = []
    
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableVIew.roundCorners(corners:  [.topLeft, .topRight], radius: 30)
        tableVIew.delegate =  self
        tableVIew.dataSource = self
        let nib = UINib(nibName: "reviewTableViewCell", bundle: nil)
        tableVIew.register(nib, forCellReuseIdentifier: "reviewTableViewCell")
        
        
    }
    
    //MARK: Navigation Bar Button Setup
    private func setupNavigationBar() {
        // Custom back button
        let backButton = CustomBackButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Tableview Methods

extension reviewViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewTableViewCell", for: indexPath)as! reviewTableViewCell
        let review = reviews[indexPath.row]
        cell.nameLabel.text = review.reviewerName
        cell.reviewLabel.text = review.comment
        cell.cosmosView.rating = Double(review.rating)
        let date = review.date
        let newDateString = date.fromUTCToLocalDate()
        cell.dateLabel.text = newDateString
        return cell
    }
    
}
