//
//  Recipe.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 13/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import Foundation

protocol Ingredient {
    var ingredient: [String] { get set}
}

struct Step {
    var description: String
    var needTimer: Bool
    var timer: Int?
    
    init(_ description: String, _ needTimer: Bool, _ timer: Int?) {
        self.description = description
        self.needTimer = needTimer
        self.timer = timer
    }
}

enum Cuisine: String {
    case Australian
    case Chinese
    case Italian
    case Thai
    case Vietnamese
}

class Recipe: Ingredient {
    var name: String
    var ingredient: [String]
    var instruction: [Step]?
    var time: Int
    var cuisine: Cuisine
    
    init (_ name: String, _ ingredient: [String], _ time: Int, _ cuisine: Cuisine) {
        self.name = name
        self.ingredient = ingredient
        self.time = time
        self.cuisine = cuisine
    }
}
