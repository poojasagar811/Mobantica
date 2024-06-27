//
//  reviewTableViewCell.swift
//  mobantica
//
//  Created by Crescendo Worldwide India on 27/06/24.
//

import UIKit
import Cosmos

class reviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cosmosView.settings.updateOnTouch = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
