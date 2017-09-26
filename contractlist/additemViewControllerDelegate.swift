//
//  additemViewControllerDelegate.swift
//  contractlist
//
//  Created by havisha tiruvuri on 9/26/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func itemSaved(by: additemViewController, firstname: String, lastname: String, phonenumber: String, indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: additemViewController)
}
