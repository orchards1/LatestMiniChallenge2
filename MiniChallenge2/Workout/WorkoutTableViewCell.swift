//
//  WorkoutTableViewCell.swift
//  MiniChallenge2
//
//  Created by Mulyanti Lauw on 20/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
