//
//  EditProfileViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/7/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON
import FirebaseAuth

class EditProfileViewController: UIViewController
{
    
    //MARK:-IBOutlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtHourly: UITextField!
    
    //MARK:-Properties
    
    var isCoach:Bool = false
    
    var ref: DatabaseReference!

    
    //MARK:-Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.txtEmail.isEnabled = false
        
        if !self.isCoach
        {
            self.txtHourly.isHidden = true
        }
        
        self.ref = Database.database().reference()
        
        self.getUserData()
    }

    //MARK:-Private
    
    func getUserData()
    {
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid)
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (user) in
                                
            let u = JSON(user.value as Any)
            
            self.txtEmail.text = u["email"].stringValue
            self.txtAge.text = u["age"].stringValue
            self.txtName.text = u["name"].stringValue
            
            if self.isCoach
            {
                self.txtHourly.text = u["hourly"].stringValue
            }

        }
    }
    
    func showMessage(message:String)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func validateData() -> Bool
    {
        if txtName.text == ""
        {
            self.showMessage(message: "Name is required.")
            return false
        }
        
        if txtAge.text == ""
        {
            self.showMessage(message: "Age is required.")
            return false
        }
        
        if self.isCoach
        {
            if txtHourly.text == ""
            {
                self.showMessage(message: "Hourly is required.")
                return false
            }
        }
        
        return true
    }
    
    //MARK:-IBActions
    
    @IBAction func editAction(_ sender: Any)
    {
        self.view.endEditing(true)
        
        if validateData()
        {
            var params:[String:String] = [:]
            
            params["name"] = self.txtName.text
            params["age"] = self.txtAge.text
            params["email"] = self.txtEmail.text
            
            if self.isCoach
            {
                params["hourly"] = txtHourly.text
                params["userType"] = "coach"
            }
            else
            {
                params["userType"] = "user"
                
            }
            
            self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(params)
            
            showMessage(message: "Profile updated!")
            
        }
    }
    
    
}
