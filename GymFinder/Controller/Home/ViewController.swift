//
//  ViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/3/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //MARK:-IBOutlets
    
    //MARK:-Properties
    
    //MARK:-Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()        
    }
    
    
    //MARK:-Private
    
    //MARK:-IBActions
    @IBAction func loginAction(_ sender: Any)
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func signupAction(_ sender: Any)
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

