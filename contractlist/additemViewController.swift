//
//  ViewController.swift
//  contractlist
//
//  Created by havisha tiruvuri on 9/26/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class additemViewController: UIViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    
      var indexPath: NSIndexPath?
    var item1: String?
    var item2: String?
    var item3: String?
    var ntitle: String?
    
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!

    @IBOutlet weak var phonenumberTextField: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
        
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        delegate?.itemSaved(by: self, firstname: firstnameTextField.text!, lastname: lastnameTextField.text!, phonenumber: phonenumberTextField.text!, indexPath: indexPath)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameTextField.text = item1
        lastnameTextField.text = item2
        phonenumberTextField.text = item3
        self.navigationItem.title =   ntitle
//        self.settitle = title
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

