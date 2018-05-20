//
//  TextEditorController.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit
enum TextEditorMode{
    case ingredient, instruction
}
class TextEditorController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var mode:TextEditorMode!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func saveAction(_ sender: Any) {
        if let vcs = navigationController?.viewControllers{
            if let previousVC = vcs[vcs.count - 2] as? AddRecipeController{
                if mode == .instruction{
                    previousVC.instructions.append(textView.text)
                }else if mode == .ingredient{
                    previousVC.ingredients.append(textView.text)
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
