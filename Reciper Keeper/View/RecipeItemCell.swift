//
//  RecipeItemCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 10/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class RecipeItemCell: UITableViewCell {

    @IBOutlet weak var RecipeTitle: UILabel!
    @IBOutlet weak var RecipeTime: UILabel!
    @IBOutlet weak var RecipeCuisine: UILabel!
    
    
    
    func updateRecipeList (with recipe: Recipe) {
        RecipeTitle.text = recipe.name
        RecipeTime.text = String(recipe.time) + " minutes"
        RecipeCuisine.text = recipe.cuisine.rawValue
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
