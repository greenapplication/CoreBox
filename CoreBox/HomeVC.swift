//
//  HomeVC.swift
//  CoreBox
//
//  Created by MindLogic Solutions on 26/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit
import CoreData
class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var Employee=[NSManagedObject]()
    var json:NSMutableArray=NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAdd.layer.cornerRadius = self.btnAdd.frame.size.width / 2
        self.btnAdd.clipsToBounds = true
        
        DisplayData()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAddEmploye(sender: AnyObject) {
        let signupVC=self.storyboard?.instantiateViewControllerWithIdentifier("AddEmployeVC")as! AddEmployeVC
        navigationController?.pushViewController(signupVC, animated: true)

    }
    
    //MARK- tableviewmethods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let lblName = cell.viewWithTag(2) as! UILabel
        lblName.text = json.objectAtIndex(indexPath.row).valueForKey("name") as? String
        
        let lblEmail = cell.viewWithTag(3) as! UILabel
        lblEmail.text = json.objectAtIndex(indexPath.row).valueForKey("email")as? String
        
        let lblcity = cell.viewWithTag(4) as! UILabel
        lblcity.text = "\(json.objectAtIndex(indexPath.row).valueForKey("city")as! String) \(json.objectAtIndex(indexPath.row).valueForKey("salary")as! String) \(json.objectAtIndex(indexPath.row).valueForKey("number")as! String)"
        
        
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(Employee[indexPath.row] as NSManagedObject)
            json.removeObjectAtIndex(indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            tblView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
            
        }
        
    }

    func DisplayData(){
        
        //hides keyboard if it open
        view.endEditing(true)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate
        
        let managedContext = appDelegate?.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"EmployeData")
        
        do
        {
            let fetchedResults =  try managedContext!.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults
            {
                Employee = results
            }
        }
        catch _ {
            print("Could not fetch")
            
        }
        
        print(Employee.count)
        
        if !json.isEqual("")
        {
            json.removeAllObjects()
        }
        
        for i in 0..<Employee.count
        {
            let alMsg = Employee[i]
            
            let city = alMsg.valueForKey("city") as! String
            let email = alMsg.valueForKey("email") as! String
            let name = alMsg.valueForKey("name") as! String
            let number = alMsg.valueForKey("number") as! String
            //let profile = alMsg.valueForKey("profile") as! String
            let salary = alMsg.valueForKey("salary") as! String
            
            
            
            let dic:NSMutableDictionary=NSMutableDictionary()
            dic.setValue(name, forKey: "name")
            dic.setValue(email, forKey:"email")
            dic.setValue(city, forKey:"city")
            dic.setValue(number, forKey:"number")
            dic.setValue(salary, forKey:"salary")
            
            json.addObject(dic)
            
            print(json)
            
        }
        
        tblView.reloadData()
        
    }
    
}
