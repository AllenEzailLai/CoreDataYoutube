//
//  ViewController.swift
//  CoreDataYoutube
//
//  Created by Allen Lai on 16/03/2015.
//  Copyright (c) 2015 Allen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnSave() {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue(txtUsername.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        
        context.save(nil)
        
        println(newUser)
        println("Object Save.")
    }
    
    @IBAction func btnLoad() {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", txtUsername.text)
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        if results.count > 0 {
            var res = results[0] as NSManagedObject
            txtUsername.text = res.valueForKey("username") as String
            txtPassword.text = res.valueForKey("password") as String
//            for res in results {
//                println(res)
//            }
        } else {
            println("0 Result Returned...Potential Error")
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

