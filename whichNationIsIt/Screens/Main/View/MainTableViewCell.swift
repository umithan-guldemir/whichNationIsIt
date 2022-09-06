//
//  MainTableViewCell.swift
//  whichNationIsIt
//
//  Created by Umithan  on 15.08.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryFlag: UILabel!
    @IBOutlet weak var countryProbability: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
