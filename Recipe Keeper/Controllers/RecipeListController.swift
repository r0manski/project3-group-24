//
//  Recipe List Controller.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit
import RealmSwift
class RecipeListController: UITableViewController, UISearchResultsUpdating {
    
//    let sampleName = "Spaghetti"
//    let sampleTime = 120
//    let sampleCuisine = Cuisine.Italian
//    let sampleIngredient = "paster 1 pack, 6 tomatoes"
    
    //values from filter
    var selectedCuisine:String?
    var selectedTime:Int?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var recipes: [Recipe] = []
    
    
    
    
    @IBAction func unwindToRecipeList(_ unwindSegue: UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 0
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 236/255.0, green: 195/255.0, blue: 11/255.0, alpha: 1)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        let sampleRecipe = Recipe(sampleName, sampleIngredient, sampleTime, sampleCuisine)
//        recipes.append(sampleRecipe)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareDataForTableView()
        tableView.reloadData()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController.isActive = false

    }
    
    //retrieving data from DB to array recipes
    func prepareDataForTableView(){
        recipes = []
        var tempRecipes = [Recipe]()
        let realm = try! Realm()
        var results: Results<Recipe>!
        if isSearching(){
            results = realm.objects(Recipe.self).filter("name CONTAINS[cd] %@",searchController.searchBar.text!)
        }else{
            
            var predicates = [NSPredicate]()
            if selectedCuisine != nil{
                let predicate = NSPredicate(format: "cuisine = %@", selectedCuisine!)
                predicates.append(predicate)
            }
            if selectedTime != nil{
                let predicate = NSPredicate(format: "time <= %d", selectedTime!)
                predicates.append(predicate)
            }
            if predicates.count > 0{
                let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                results =  realm.objects(Recipe.self).filter(compoundPredicate)
            }else{
                results =  realm.objects(Recipe.self)
            }
        }
        for recipe in results{
            tempRecipes.append(recipe)
        }
        recipes = tempRecipes
    }
    
    
    // MARK: - Helpers
    func isSearching()->Bool{
        
        guard searchController.isActive else {return false}
        guard let searchText = searchController.searchBar.text else {return false}
        
        return searchText.count > 1
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
    
        prepareDataForTableView()
    
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    //setting number of rows for recepies
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recipes.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "RecipeItem", for: indexPath) as! RecipeItemCell
        let recipe = recipes[indexPath.row]
        cell.updateRecipeList(with: recipe)
        cell.showsReorderControl = false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeController") as! RecipeController
        vc.currentRecipe = recipes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    
  
    
    //filtering the recipe list
    @IBAction func filterAction(_ sender: Any) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "FilterController") as! FilterController
        
        if selectedCuisine != nil{
            vc.selectedCuisineIndex = vc.cuisines.index(of: Cuisine(rawValue: selectedCuisine!)!)
        }
        
        if selectedTime != nil{
            vc.selectedTimeIndex = vc.times.index(of: selectedTime!)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
