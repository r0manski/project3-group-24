//
//  InstructionCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 13/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    @IBOutlet weak var StepTagColor: UIView!
    @IBOutlet weak var StepDescription: UILabel!
    @IBOutlet weak var Action: UIButton!
    
    
    func updateInstruction (stepNumber: Int, detail step: Step) {
        // Styling for step
        if (stepNumber + 1) % 3 == 0 {
            StepTagColor.backgroundColor = UIColor(red: 213.0/255.0, green: 96.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        } else if (stepNumber + 1) % 2 == 0 {
            StepTagColor.backgroundColor = UIColor(red: 236.0/255.0, green: 195.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        } else {
            StepTagColor.backgroundColor = UIColor(red: 243.0/255.0, green: 119.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        }
        
        // Action for step
        if step.needTimer == false {
            let checkedImage = UIImage.init(imageLiteralResourceName: "Checked")
            Action.setTitle("Done", for: .normal)
            Action.setImage(checkedImage, for: .highlighted)
        }
        StepDescription.text = step.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
