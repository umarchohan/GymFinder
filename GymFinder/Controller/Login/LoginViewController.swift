//
//  LoginViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/3/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON

class LoginViewController: UIViewController
{
    //MARK:-IBOutlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //MARK:-Properties
    
    
    var ref: DatabaseReference!
    
    //MARK:-Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    //MARK:-Private
    
    func showMessage(message:String)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func validateData() -> Bool
    {

        if self.txtEmail.text == ""
        {
            self.showMessage(message: "Email is required")
            return false
        }
        
        if !Helper.nsStringIsValidEmail(self.txtEmail.text!)
        {
            self.showMessage(message: "Email is not valid")
            return false
        }
        
        if self.txtPassword.text == ""
        {
            self.showMessage(message: "Password is required")
            return false
        }
        return true
    }
    
    //MARK:-IBActions
    @IBAction func loginAction(_ sender: Any)
    {
        self.view.endEditing(true)
        
        if self.validateData()
        {
            Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!)  { (result, error) in
                
                
                guard let user = result?.user, error == nil else {
                    
                    self.showMessage(message: error!.localizedDescription)
                    
                    return
                }
                
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                    let value = JSON(snapshot.value as Any)
                    
                    print("User data:\(value)")
                    
                    if value["userType"].stringValue == "user"
                    {
                        let view = self.storyboard?.instantiateViewController(withIdentifier: "CoachListViewController") as! CoachListViewController
                        self.navigationController?.pushViewController(view, animated: true)
                    }
                    else
                    {
                        let view = self.storyboard?.instantiateViewController(withIdentifier: "UserRequestsViewController") as! UserRequestsViewController
                        self.navigationController?.pushViewController(view, animated: true)
                    }
                    
        
                  }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
        
        }
        
    }
    
}
