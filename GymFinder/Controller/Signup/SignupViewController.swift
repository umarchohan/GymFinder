//
//  SignupViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/3/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON
import FirebaseCore
import FirebaseAuth
import CoreLocation

class SignupViewController: UIViewController
{
    
    //MARK:-IBOutlets
    @IBOutlet weak var userSegment: UISegmentedControl!
    
    @IBOutlet weak var txtHourly: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //MARK:-Properties
    
    var locationManager: CLLocationManager =  CLLocationManager()
    var userLocation: CLLocation?
    
    var ref: DatabaseReference!
    
    //MARK:-Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
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
        if self.txtName.text == ""
        {
            self.showMessage(message: "Name is required")
            return false
        }
        
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
        
        if self.txtAge.text == ""
        {
            self.showMessage(message: "Age is required")
            return false
        }
        
        if self.userSegment.selectedSegmentIndex == 0
        {
            if self.txtHourly.text == ""
            {
                self.showMessage(message: "Hourly is required")
                return false
            }
        }
        
        return true
    }
    
    //MARK:-IBActions
    
    @IBAction func segmentAction(_ sender: UISegmentedControl)
    {
        self.view.endEditing(true)
        
        if sender.selectedSegmentIndex == 0
        {
            self.txtHourly.isHidden = false
        }
        else
        {
            self.txtHourly.isHidden = true
        }
        
        self.txtName.text = ""
        self.txtAge.text = ""
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        self.txtHourly.text = ""

            
    }
    
    @IBAction func signupAction(_ sender: Any)
    {
        
        self.view.endEditing(true)
        
        if self.validateData()
        {
            var params:[String:String] = [:]
            
            
            Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (result, error) in
                
                                
                guard let user = result?.user, error == nil else {
                    
                    self.showMessage(message: error!.localizedDescription)
                    
                  return
                }
                
                 print("\(user.email!) created")
                
                params["name"] = self.txtName.text
                params["age"] = self.txtAge.text
                params["email"] = self.txtEmail.text
                
                if let location = self.userLocation
                {
                    //42.382841, -71.103976
                    
                   // 42.371124, -71.105646
                    
                   // 42.364432, -71.154317
                    
                    //42.394927, -71.096755
                    
//                    let locationParams = ["latitude":"\(location.coordinate.latitude)",
//                        "longitude":"\(location.coordinate.longitude)"]
//                    self.ref.child("userLocations").child(user.uid).setValue(locationParams)
                    
                    let locationParams = ["latitude":"42.394927",
                        "longitude":"-71.096755"]
                    self.ref.child("userLocations").child(user.uid).setValue(locationParams)
                    
                }
                
                if self.userSegment.selectedSegmentIndex == 0
                {
                    params["userType"] = "coach"
                    params["hourly"] = self.txtHourly.text
                }
                else
                {
                    params["userType"] = "user"
                }
                
                self.ref.child("users").child(user.uid).setValue(params)
                                
                self.txtName.text = ""
                self.txtAge.text = ""
                self.txtEmail.text = ""
                self.txtPassword.text = ""
                self.txtHourly.text = ""
                
                self.showMessage(message: "User is signed up succesfully!")
                
            }
            
        }
    }
}

extension SignupViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        
        manager.stopUpdatingLocation()
    }
}
