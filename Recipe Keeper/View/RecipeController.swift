//
//  RecipeController.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 10/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class RecipeController: UITableViewController {
    var currentRecipe: Recipe!
    var ingredients: [String] = ["1 pack of pasta", "500g tomatoes"]
    
    var steps: [Step] = []
    let step1 = Step("Cook pasta", true, 10)
    let step2 = Step("Chop tomatoes and onions", false, 0)
    let step3 = Step("Season minced beef", false, 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = currentRecipe.name
        steps.append(step1)
        steps.append(step2)
        steps.append(step3)
        //tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
        override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return steps.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //Display ingredients
        if indexPath.section == 0 {
            let instructionCell = tableView.dequeueReusableCell(withIdentifier:
                "InstructionItem", for: indexPath) as! IngredientViewCell
            let ingredient = ingredients[indexPath.row]
        }
        // Display instruction
        else if indexPath.section == 1 {
            let instructionCell = tableView.dequeueReusableCell(withIdentifier:
            "InstructionItem", for: indexPath) as! InstructionCell
            let step = steps[indexPath.row]
            instructionCell.updateInstruction(stepNumber: indexPath.row, detail: step)
            instructionCell.showsReorderControl = false
            return cell
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
