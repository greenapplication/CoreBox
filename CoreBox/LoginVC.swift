//
//  LoginVC.swift
//  CoreBox
//
//  Created by MindLogic Solutions on 26/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var Employee=[NSManagedObject]()
    var json:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLogin(sender: AnyObject) {
        
        
        if self.txtUsername.text=="" && self.txtPassword.text==""
        {
            let alert=UIAlertView(title: "Login failed..", message: "Please enter username and password", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else{
            
            //hides keyboard if it open
            view.endEditing(true)
            
            //1
            let appDelegate =
                UIApplication.sharedApplication().delegate as? AppDelegate
            
            let managedContext = appDelegate?.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName:"Registration")
            
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
            
            if !json.isEmpty
            {
                json.removeAll(keepCapacity: true)
            }
            
            var flag : Bool = false
            for i in 0..<Employee.count
            {
                let alMsg = Employee[i]
                
                let Uname = alMsg.valueForKey("username") as! String
                let password = alMsg.valueForKey("password") as! String
                
                if(self.txtUsername.text == Uname && self.txtPassword.text == password){
                    flag = true
                    break
                }
                
            }
            if(flag == true){
                
                let homeVC=self.storyboard?.instantiateViewControllerWithIdentifier("HomeVC")as! HomeVC
                navigationController?.pushViewController(homeVC, animated: true)
                
            }else{
                
                let alert=UIAlertView(title: "Login failed..", message: "username or password wrong!", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            
        }
        
    }

    @IBAction func buttonSignUp(sender: AnyObject) {
        let signupVC=self.storyboard?.instantiateViewControllerWithIdentifier("SignUpVC")as! SignUpVC
        navigationController?.pushViewController(signupVC, animated: true)
    }
   
}
