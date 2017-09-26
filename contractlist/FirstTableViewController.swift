//
//  FirstTableViewController.swift
//  contractlist
//
//  Created by havisha tiruvuri on 9/26/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class FirstTableViewController: UITableViewController, AddItemViewControllerDelegate, DisplayViewControllerDelegate{
    
    var items = [Contactlist]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contactlist")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [Contactlist]
        } catch {
            print("\(error)")
        }
        
    }
    
    func itemSaved(by: additemViewController, firstname: String, lastname: String, phonenumber: String, indexPath: NSIndexPath?) {
        print("Recived Text from top view: \(firstname) \(lastname) \(phonenumber)")
        if let ip = indexPath {
            let item = items[ip.row]
            item.firstname = firstname
            item.lastname = lastname
            item.number = phonenumber
        } else {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Contactlist", into: managedObjectContext) as! Contactlist
        item.firstname = firstname
        item.lastname = lastname
        item.number = phonenumber
        items.append(item)
   }
    
    do {
    try managedObjectContext.save()
    } catch {
    print("\(error)")
    }
    
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
    }

    func DoneButtonPressed(by: DisplayViewController) {
        print("done")
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        fetchAllItems()
        self.title = "Contact List"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func cancelButtonPressed(by controller: additemViewController){
        print("I'm the hidden controller, But I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "additem", sender: sender)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "display" {
            let navigationController = segue.destination as! UINavigationController
            let displayViewController = navigationController.topViewController as! DisplayViewController
            displayViewController.delegate = self
        let indexPath = sender as! NSIndexPath
        
        let item = items[indexPath.row]
        displayViewController.fdisplay = item.firstname!
        displayViewController.ldisplay = item.lastname!
        displayViewController.ndisplay = item.number!
      //  displayViewController.indexPath = indexPath
        } else if type(of: sender!) == UIBarButtonItem.self {
//
            print("1")
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! additemViewController
            addItemTableViewController.delegate = self
          addItemTableViewController.ntitle = "New Contact"
    } else {
        print(sender!)
        print("2")
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! additemViewController
        addItemTableViewController.delegate = self
        
        let indexPath = sender as! NSIndexPath
        
        let item = items[indexPath.row]
        addItemTableViewController.item1 = item.firstname!
        addItemTableViewController.item2 = item.lastname!
        addItemTableViewController.item3 = item.number!
        addItemTableViewController.indexPath = indexPath
       addItemTableViewController.ntitle = "Edit Contact"
           }
    }
    
    
    // MARK: - Table view data source

    //table view row count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    //table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! FirstTableViewCell
        
        cell.firstnameLabel?.text = items[indexPath.row].firstname
        cell.lastnameLabel?.text = items[indexPath.row].lastname
        cell.phonenumberLabel?.text = items[indexPath.row].number
        return cell
    }
    
    //table view  select row for action sheet
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    
    let Menu = UIAlertController(title: "contact list", message: nil, preferredStyle: .actionSheet)
    let View = UIAlertAction(title: "View", style: .default, handler: { (alert: UIAlertAction!) -> Void in
        print("Open View")
        self.performSegue(withIdentifier: "display", sender: indexPath)
    })
    let Edit = UIAlertAction(title: "Edit", style: .default, handler: { (alert: UIAlertAction!) -> Void in
        print("Open Edit")
        self.performSegue(withIdentifier: "additem", sender: indexPath)
//        self.title = "Contact List"
    })
    let Delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
        print("Open Delete")
        let item = self.items[indexPath.row]
        self.managedObjectContext.delete(item)
        do {
            try self.managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        self.items.remove(at: indexPath.row)
        tableView.reloadData()
    })
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        print("Cancel")
      //  self.present(Menu, animated: true, completion: nil)

    })
    
    
    Menu.addAction(View)
    Menu.addAction(Edit)
    Menu.addAction(Delete)
    Menu.addAction(cancel)
    
 
    present(Menu, animated: true, completion: nil)

    }
    
    
    //   performSegue(withIdentifier: "additem", sender: indexPath)
     //  TableView.dataSource = self

}
