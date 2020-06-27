//
//  ChangePasswordViewController.swift
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

class ChangePasswordViewController: UIViewController
{
    //MARK:-IBOutlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCode: UITextField!
    
    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    //MARK:-Properties
    
    var codeSent:Bool = false
    var codeVerified = false
    
    //MARK:-Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        if txtNewPassword.text == ""
        {
            showMessage(message: "Please enter new password")
            return false
        }
        
        if txtOldPassword.text == ""
        {
            showMessage(message: "Please enter old password")
            return false
        }
        
        if !codeSent
        {
            showMessage(message: "Please enter email to receive a verification code first.")
            
            return false
        }
        
        if !codeVerified
        {
            showMessage(message: "Please verify code first to change password.")
            
            return false
        }
        
        return true
    }
    
    //MARK:-IBActions
    
    
    @IBAction func sendCode(_ sender: Any)
    {
        if self.txtEmail.text == ""
        {
            self.showMessage(message: "Please entetr the email to continue.")
        }
        else
        {
            Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
                
                if let e = error
                {
                    self.showMessage(message: e.localizedDescription)
                }
                
                self.codeSent = true
                self.showMessage(message: "A verification code is sent to you on the email you entered.Please verify that code to change the password.")
                
            }
        }
        
        
    }
    
    @IBAction func verifyCode(_ sender: Any)
    {
        Auth.auth().verifyPasswordResetCode(txtCode.text!) { (string, error) in
            
        }
    }
    
    @IBAction func changePassAction(_ sender: Any)
    {
        if validateData()
        {
        }
    }
    
}
