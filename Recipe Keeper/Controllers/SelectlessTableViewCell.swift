//
//  SelectlessTableViewCell.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/05/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

//preventing selecting the cell visually
class SelectlessTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }

}
