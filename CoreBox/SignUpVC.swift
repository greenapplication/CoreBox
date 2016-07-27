//
//  SignUpVC.swift
//  CoreBox
//
//  Created by MindLogic Solutions on 26/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit
import CoreData

class SignUpVC: UIViewController {
    
    var Employee=[NSManagedObject]()
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContatctNumber: UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonSignUp(sender: AnyObject) {
        
        //hides keyboard if it open
        view.endEditing(true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let managedContext = appDelegate?.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Registration",inManagedObjectContext:managedContext!)
        
        let MSG = NSManagedObject(entity: entity!,
                                  insertIntoManagedObjectContext:managedContext)
        
        //3
        MSG.setValue(txtUsername.text!, forKey: "username")
        MSG.setValue(txtPassword.text!, forKey: "password")
        MSG.setValue(txtEmail.text!, forKey: "email")
        MSG.setValue(txtContatctNumber.text!, forKey: "mobile")
        
        do {
            try managedContext?.save()
            let alrt=UIAlertView(title: "CoreDataDemo", message: "record added succeed..", delegate: self, cancelButtonTitle: "OK")
            alrt.show()
            
            txtContatctNumber.text=""
            txtEmail.text=""
            txtPassword.text=""
            txtUsername.text=""
            
            
        } catch _ {
            let alrt=UIAlertView(title: "CoreDataDemo", message: "record added failed..", delegate: self, cancelButtonTitle: "OK")
            alrt.show()
        }
        
        //5
        Employee.append(MSG)
        
    }
    
    
    
    @IBAction func buttonBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    

}
