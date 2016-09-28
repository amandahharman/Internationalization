//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/28/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else{fatalError("Cannot show detail without an item)")}
        textField.text = item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let item = item {
            item.text = textField.text
            DataController.sharedInstance.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
        
    }

   
}
