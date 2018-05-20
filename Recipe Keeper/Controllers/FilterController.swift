//
//  FilterController.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class FilterController: UITableViewController {

    //creating cuisine array
    let cuisines = [Cuisine.Australian, .Chinese, .Italian, .Russian, .Thai, . Vietnamese]
    var selectedCuisineIndex:Int?
    
    //creating time array
    let times = [60,50,40,30,20,10]
    var selectedTimeIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    //setting number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //setting number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cuisines.count
        }else{
            return times.count
        }
        
    }

    // creating headers for sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("GrayHeaderView", owner: self, options: nil)!.first as! UIView
        
        let label = header.viewWithTag(1) as! UILabel
        if section == 0{
            label.text = "CUISINE"
        }else{
            label.text = "TIME"
        }
        return header
    }
    
    //setting height for header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    //setting height for footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.02
    }
    
    //building cells and check marks
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        
        
        if indexPath.section == 0{
            let cuisine = cuisines[indexPath.row]
            cell.textLabel?.text = cuisine.rawValue
            if selectedCuisineIndex != nil && selectedCuisineIndex! == indexPath.row{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
            
        }else{
            let time = times[indexPath.row]
            cell.textLabel?.text = "No more than \(time) minutes"
            if selectedTimeIndex != nil && selectedTimeIndex! == indexPath.row{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
        }
        return cell
    }
   
    // setting indexes of selected cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            if selectedCuisineIndex != nil && selectedCuisineIndex == indexPath.row{
                selectedCuisineIndex = nil
            }else{
                selectedCuisineIndex = indexPath.row
            }
   
        }else{
            
            if selectedTimeIndex != nil && selectedTimeIndex == indexPath.row{
                selectedTimeIndex = nil
            }else{
                selectedTimeIndex = indexPath.row
            }
            
        }
        
        
        
        tableView.reloadData()
    }


    // showing filtered data
    @IBAction func showSelectedAction(_ sender: Any) {
        //finding previous view controller and calling up its methods - kinda hack, TODO refactoring
        if let vcs = navigationController?.viewControllers{
            if let previousVC = vcs[vcs.count - 2] as? RecipeListController{
         
                previousVC.selectedCuisine = selectedCuisineIndex != nil ? cuisines[selectedCuisineIndex!].rawValue : nil
                previousVC.selectedTime = selectedTimeIndex != nil ? times[selectedTimeIndex!] : nil
                previousVC.searchController.isActive = false
                previousVC.searchController.searchBar.text = nil
                previousVC.prepareDataForTableView()
                previousVC.tableView.reloadData()
           
            }
        }
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    //clearing the form
    @IBAction func clearAction(_ sender: Any) {
        selectedCuisineIndex = nil
        selectedTimeIndex = nil
        tableView.reloadData()
    }
}
