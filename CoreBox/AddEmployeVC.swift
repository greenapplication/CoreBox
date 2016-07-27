//
//  AddEmployeVC.swift
//  CoreBox
//
//  Created by MindLogic Solutions on 26/07/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit
import CoreData

class AddEmployeVC: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    var Employee=[NSManagedObject]()
    var imgData:NSData=NSData()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfile(sender: AnyObject) {
        let actionSheet = UIActionSheet(title:nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take Photo", "Choose Photo")
        
        actionSheet.showInView(self.view)

    }

    @IBAction func buttonRegister(sender: AnyObject) {
        
        //hides keyboard if it open
        view.endEditing(true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let managedContext = appDelegate?.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("EmployeData",inManagedObjectContext:managedContext!)
        
        let MSG = NSManagedObject(entity: entity!,
                                  insertIntoManagedObjectContext:managedContext)
        
        //3
        MSG.setValue(txtName.text!, forKey: "name")
        MSG.setValue(txtEmail.text!, forKey: "email")
        MSG.setValue(txtCity.text!, forKey: "city")
        MSG.setValue(txtNumber.text!, forKey: "number")
        MSG.setValue(txtSalary.text!, forKey: "salary")
        MSG.setValue(imgData, forKey: "profile")
        
        do {
            try managedContext?.save()
            let alrt=UIAlertView(title: "CoreDataDemo", message: "employee register succeed..", delegate: self, cancelButtonTitle: "OK")
            alrt.show()
           navigationController?.popViewControllerAnimated(true)
            
        } catch _ {
            let alrt=UIAlertView(title: "CoreDataDemo", message: "employee register failed..", delegate: self, cancelButtonTitle: "OK")
            alrt.show()
        }
        
        //5
        Employee.append(MSG)
        
    }
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        
        switch (buttonIndex){
            
        case 1:
            if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
                let deviceNotFoundAlert: UIAlertView = UIAlertView(title: "No Device", message: "Camera is not available", delegate: nil, cancelButtonTitle: nil, otherButtonTitles:"Okay")
                deviceNotFoundAlert.show()
            }
            else {
                let picker: UIImagePickerController = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .Camera
                self.presentViewController(picker, animated: true, completion: { _ in })
            }
        case 2:
            let picker: UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: { _ in })
        default:
            print("Default")
            //Some code here..
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.profileImage.image = pickedImage
            //conver selected image to nsdata
            imgData = UIImageJPEGRepresentation(pickedImage, 1.0)!
            
        }
        dismissViewControllerAnimated(false, completion: nil)
        
    }

}
