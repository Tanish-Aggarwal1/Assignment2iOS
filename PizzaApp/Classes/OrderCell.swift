//
//  OrderCell.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-16.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // outlets for the 3 items in the cell
        @IBOutlet var avatarImageView: UIImageView!
        @IBOutlet var primaryLabel: UILabel!
        @IBOutlet var secondaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
