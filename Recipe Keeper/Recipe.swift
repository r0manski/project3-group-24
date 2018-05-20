//
//  Recipe.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 13/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


//protocol Ingredient {
//    var ingredient: String { get set}
//}
//
//struct Instruction {
//    var step: [Int: String]
//    var timer: [Int: Int]
//}

//enum Cuisine: String {
//    case Australian
//    case Chinese
//    case Italian
//    case Thai
//    case Vietnamese
//}

//class Recipe: Ingredient {
//    var name: String
//    var ingredient: String
//    var instruction: Instruction?
//    var time: Int
//    var cuisine: Cuisine
//
//    init (_ name: String, _ ingredient: String, _ time: Int, _ cuisine: Cuisine) {
//        self.name = name
//        self.ingredient = ingredient
//        self.time = time
//        self.cuisine = cuisine
//    }
//}


@objc enum Cuisine: Int {
    case Australian
    case Chinese
    case Italian
    case Thai
    case Vietnamese
    
    var value: String {
        switch self {
        case .Australian:
            return "Australian"
        case .Chinese:
            return "Chinese"
        case .Italian:
            return "Italian"
        case .Thai:
            return "Thai"
        case .Vietnamese:
            return "Vietnamese"
        }
    }
}



class Recipe: Object {
    /// name
    @objc dynamic var name: String = ""
    /// ingredient
    @objc dynamic var ingredient: String = ""
    /// time
    @objc dynamic var time: Int = 0
    ///
    @objc dynamic var cuisine: Cuisine = .Australian
    
    /// primary key
    @objc dynamic var createdTime: String = ""
    
    override static func primaryKey() -> String? {
        return "createdTime"
    }
    
}

func == (lhs: Recipe, rhs:Recipe) -> Bool
{
    return lhs.name == rhs.name && lhs.ingredient == rhs.ingredient && lhs.time == rhs.time && lhs.cuisine.value == rhs.cuisine.value
}


extension Recipe {
    @discardableResult
    static func save(_ name: String, ingredient: String, time: Int, cuisine: Cuisine = .Australian) -> Recipe {
        let item = Recipe()
        item.createdTime = String(Date().timeIntervalSince1970)

        item.name = name
        item.ingredient = ingredient
        item.time = time
        item.cuisine = cuisine
        
        var exsit = false
        for go in Recipe.getAllRecipes() {
            if go == item {
                exsit = true
                break
            }
        }
        
        if !exsit {
            item.writeToDB()
        }
        return item
    }
    
    func update()  {
        let realm = try! Realm() // Create realm pointing to default file
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    func writeToDB() {
        // Realms are used to group data together
        let realm = try! Realm() // Create realm pointing to default file
        
        // Persist your data easily
        try! realm.write {
            realm.add(self)
        }
        
    }
    
    func delete() {
        let realm = try! Realm() // Create realm pointing to default file
        
        // Persist your data easily
        try! realm.write {
            realm.delete(self)
        }
        
    }

    /// search based on key word
    static func getAllRecipesByWords(_ words: String) -> [Recipe] {
        let realm = try! Realm() // Create realm pointing to default file
        let results = realm.objects(Recipe.self).sorted(byKeyPath: "createdTime", ascending: false).filter("name CONTAINS '\(words)'")
        let array = results.get(offset: 0, limit: results.count)
        return array as! [Recipe]
        
    }
    
    /// load some type
    static func getAllRecipesByType(_ cuisine: Cuisine) -> [Recipe] {
        let realm = try! Realm() // Create realm pointing to default file
        let results = realm.objects(Recipe.self).sorted(byKeyPath: "createdTime", ascending: false)
        let array = results.get(offset: 0, limit: results.count) as! [Recipe]
        return array.filter{$0.cuisine == cuisine}
        
    }

    /// load all 
    static func getAllRecipes() -> [Recipe] {
        let realm = try! Realm() // Create realm pointing to default file
        let results = realm.objects(Recipe.self).sorted(byKeyPath: "createdTime", ascending: false)
        let array = results.get(offset: 0, limit: results.count)
        return array as! [Recipe]
    }
}





extension Results {
    
    func get <T:Object> (offset: Int = 0, limit: Int ) -> Array<T> {
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<T> = Array<T>() // results list
        
        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        } else {
            lim = limit
        }
        
        //do slicing
        for i in off..<lim{
            let dog = self[i] as! T
            l.append(dog)
        }
        
        //results
        return l
    }
}

