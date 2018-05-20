//
//  AddRecipeController.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 18/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit
import RealmSwift
class AddRecipeController: UITableViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    let recipiesArray:[[String:Any]] = [
        ["name":"pasta","time":25,"cuisine":"italian","instructions":[[""]]]
    
    ]
    var name:String = ""
    var cuisine:String = "Australian"
    var time = 0
    var ingredients = [String]()
    var instructions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //remove keyboard when outside the area outside the text field is tapped
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddRecipeController.tapDetected))
        view.addGestureRecognizer(tap)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    let numberOfRowsAtSection: [Int] = [1, 1, 1]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return ingredients.count
        }else{
            return instructions.count
        }
    }
    // returning headers of instructions and ingridients
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            //getting header
            let headerView = Bundle.main.loadNibNamed("AddRecipeIngredientHeaderView", owner: self, options: nil)?.first as? UIView
            //getting button
            let button = headerView?.viewWithTag(1) as! UIButton
            //deleting old target
            button.removeTarget(nil, action: nil, for: .allEvents)
            //adding ingridient
            button.addTarget(self, action: #selector(AddRecipeController.addIngredientAction), for: .touchUpInside)
            //getting recepi name
            let nameTextField = headerView?.viewWithTag(2) as! UITextField
            nameTextField.delegate = self
            nameTextField.text = name
            //getting selected cuisine
            let pickerView = headerView?.viewWithTag(3) as! UIPickerView
            pickerView.delegate = self
            pickerView.dataSource = self
            switch Cuisine(rawValue: cuisine)!{
            case .Australian:
                pickerView.selectRow(0, inComponent: 0, animated: false)
            case .Chinese:
                pickerView.selectRow(1, inComponent: 0, animated: false)
            case .Italian:
                pickerView.selectRow(2, inComponent: 0, animated: false)
            case .Russian:
                pickerView.selectRow(3, inComponent: 0, animated: false)
            case .Thai:
                pickerView.selectRow(4, inComponent: 0, animated: false)
            case .Vietnamese:
                pickerView.selectRow(5, inComponent: 0, animated: false)
            }
            //getting time for cooking
            let timeTextField = headerView?.viewWithTag(4) as! UITextField
            timeTextField.delegate = self
            timeTextField.text = "\(time)"
            
            return headerView
        }else{
            let headerView = Bundle.main.loadNibNamed("AddRecipeInstructionHeaderView", owner: self, options: nil)?.first as? UIView
            let button = headerView?.viewWithTag(1) as! UIButton
            button.removeTarget(nil, action: nil, for: .allEvents)
            button.addTarget(self, action: #selector(AddRecipeController.addInstructionAction), for: .touchUpInside)
            return headerView
        }
    }
    
    //setting header height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 535
        }else{
            return 56
        }
        
    }
    //setting footer height
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.02
    }
    
    // showing ingridients and instrcutions in the respective cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var text = ""
        if indexPath.section == 0{
            text = ingredients[indexPath.row]
        }else{
            text = instructions[indexPath.row]
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTextCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = text

        return cell
    }
    
    //deselecting cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 2{ 
            name = textField.text ?? ""
        }else if textField.tag == 4{
            time = Int(textField.text ?? "0")!
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return Cuisine.Australian.rawValue
        case 1:
            return Cuisine.Chinese.rawValue
        case 2:
            return Cuisine.Italian.rawValue
        case 3:
            return Cuisine.Russian.rawValue
        case 4:
            return Cuisine.Thai.rawValue
        case 5:
            return Cuisine.Vietnamese.rawValue
        
        default:
            return ""
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            cuisine = Cuisine.Australian.rawValue
        case 1:
            cuisine = Cuisine.Chinese.rawValue
        case 2:
            cuisine = Cuisine.Italian.rawValue
        case 3:
            cuisine = Cuisine.Russian.rawValue
        case 4:
            cuisine = Cuisine.Thai.rawValue
        case 5:
            cuisine = Cuisine.Vietnamese.rawValue
            
        default:
            cuisine = ""
        }
    }
    
    // MARK: - User actions
    
    //действие при нажатии конпки добавить ингридиент
    @objc func addIngredientAction(){
        print("addIngredientAction")
        
        let textEditor = storyboard?.instantiateViewController(withIdentifier: "TextEditorController") as! TextEditorController
        textEditor.mode = .ingredient
        navigationController?.pushViewController(textEditor, animated: true)
        
    }
    //actions when add instruction button is tapped

    @objc func addInstructionAction(){
        print("addInstructionAction")
        let textEditor = storyboard?.instantiateViewController(withIdentifier: "TextEditorController") as! TextEditorController
        textEditor.mode = .instruction
        navigationController?.pushViewController(textEditor, animated: true)
    }
   
    //saving recepi to DB
    @IBAction func saveAction(_ sender: Any) {
        let realm = try! Realm()
        
        
        let realmInstructions = List<Instruction>()
        var i = 1
        for instruction in instructions{
            let realmInstruction = Instruction(text:instruction, step:i, time:25)
            realmInstructions.append(realmInstruction)
            i += 1
        }
        
        let realmIngredients = List<String>()
        for ingredient in ingredients{
            realmIngredients.append(ingredient)
        }

        let recipe = Recipe(name: name, time: time, cuisine: cuisine, ingredients: realmIngredients, instructions: realmInstructions)
        try! realm.write {
            realm.add(recipe, update: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func tapDetected(){
        view.endEditing(true)
    }
    
}
