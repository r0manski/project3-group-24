//
//  Instruction.swift
//  Instructionr Keeper
//
//  Created by Archer on 2018/5/17.
//  Copyright © 2018年 Alice Mai Tu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class Instruction: Object {
    /// relate
    @objc dynamic var recipe: Recipe?
    /// primary key
    @objc dynamic var createdTime: String = ""
    /// content
    @objc dynamic var content: String = ""
    /// time
    @objc dynamic var time: String = ""
    
    override static func primaryKey() -> String? {
        return "createdTime"
    }
    
}


func == (lhs: Instruction, rhs:Instruction) -> Bool
{
    return lhs.content == rhs.content && lhs.time == rhs.time && lhs.recipe == rhs.recipe
}



extension Instruction {
    @discardableResult
    static func save(_ recipe: Recipe, content: String, time: String) -> Instruction {
        let item = Instruction()
        item.createdTime = String(Date().timeIntervalSince1970)
        
        item.recipe = recipe
        item.content = content
        item.time = time
        
        var exsit = false
        for go in Instruction.getAllInstructions() {
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
    
    /// load all step based on recipe
    static func getInstructionsByRecipe(_ recipe: Recipe) -> [Instruction] {
        let cos = Instruction.getAllInstructions()
        var retCo : [Instruction] = []
        cos.forEach {
            if $0.recipe == recipe {
                retCo.append($0)
            }
        }
        
        return retCo
    }

    static func getAllInstructions() -> [Instruction] {
        let realm = try! Realm() // Create realm pointing to default file
        let results = realm.objects(Instruction.self).sorted(byKeyPath: "createdTime", ascending: false)
        let array = results.get(offset: 0, limit: results.count)
        return array as! [Instruction]
    }
}


