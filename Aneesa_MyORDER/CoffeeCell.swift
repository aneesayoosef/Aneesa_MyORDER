//
//  CoffeeCell.swift
//  Aneesa_MyORDER
//
//  Created by user195932 on 5/18/21.
//

import UIKit

class CoffeeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var coffeSize: UILabel!
    
    
    @IBOutlet weak var coffeQuantity: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
