//
//  Recipe.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 18/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import Foundation
import RealmSwift


//model object for recipe
class Recipe: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var time: Int = 0
    @objc dynamic var cuisine: String = ""
    
    var ingredients = List<String>()
    var instructions = List<Instruction>()
    
    convenience init (name: String, time: Int, cuisine: String, ingredients: List<String>, instructions: List<Instruction>) {
        self.init()
        self.name = name
        self.time = time
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.instructions = instructions
        
    }
    
    override static func primaryKey() -> String? {
        return "name" //unique name
    }
    
}

//model object for instruction
class Instruction: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var step: Int = 0
    @objc dynamic var time: Int = 0
    
    convenience init (text:String, step: Int, time: Int) {
        self.init()
        self.text = text
        self.step = step
        self.time = time
    }
    
}


//struct for cuisines
enum Cuisine: String {
    case Australian
    case Chinese
    case Italian
    case Russian
    case Thai
    case Vietnamese
}


