//
//  commoditiesTableViewCell.swift
//  eggpieIosFinal
//
//  Created by user_23 on 2018/1/17.
//  Copyright © 2018年 user_23. All rights reserved.
//

import UIKit

class commoditiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commoditiesImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
