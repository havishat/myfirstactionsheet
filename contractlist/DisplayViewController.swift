//
//  DisplayViewController.swift
//  contractlist
//
//  Created by havisha tiruvuri on 9/26/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var fdisplay: String?
    var ldisplay: String?
    var ndisplay: String?
    
    var list = [Contactlist]()
    
    weak var delegate: DisplayViewControllerDelegate?
    
    @IBOutlet weak var firstnameLabel: UILabel!
    
    @IBOutlet weak var lastnamelabel: UILabel!

    
    @IBOutlet weak var phonenumber: UILabel!
    
    
    @IBAction func DoneBarButton(_ sender: UIBarButtonItem) {
        delegate?.DoneButtonPressed(by: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameLabel.text = fdisplay
        lastnamelabel.text = ldisplay
        phonenumber.text = ndisplay
        self.title = fdisplay
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
