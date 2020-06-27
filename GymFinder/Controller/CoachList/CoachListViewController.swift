//
//  CoachListViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/4/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON
import CoreLocation
import GeoFire
import FirebaseAuth

class CoachListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    //MARK:-IBOutlets
    @IBOutlet weak var coachesTable: UITableView!
    
    //MARK:-Properties
    
    var ref: DatabaseReference!
    var coaches = [JSON]()
    
    var geoFire:GeoFire!
    
    var locationManager: CLLocationManager =  CLLocationManager()
    var userLocation: CLLocation?
    
    var requests:JSON!
    
    //MARK:-Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.navigationItem.hidesBackButton = true
        
        self.title = "Coaches"
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        self.ref = Database.database().reference()
        
        self.geoFire = GeoFire(firebaseRef: self.ref.child("userLocations"))
        
        self.coachesTable.delegate = self
        self.coachesTable.dataSource = self
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 5, height: 30))
        menuButton.setImage(UIImage(named: "Menu"), for: .normal)
        
        menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        let menu = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = menu
        
    }
    
    //MARK:-Private
    
    @objc func showMenu()
    {
        let alert = UIAlertController(title: "Menu", message: "", preferredStyle: .alert)
        
        let changePassword = UIAlertAction(title: "Change Password", style: .default) { (action) in
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
        let editProfile = UIAlertAction(title: "Edit Profile", style: .default) { (action) in
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
            view.isCoach = false
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
        let showFriends = UIAlertAction(title: "My Coaches", style: .default) { (action) in
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
            
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(editProfile)
        alert.addAction(showFriends)
        alert.addAction(changePassword)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCoaches()
    {
        
        self.ref.child("userLocations").observeSingleEvent(of: .value) { (snapshot) in

            let val = JSON(snapshot.value as Any)

            for (key, value) in val
            {
                var userID = value
                userID["userId"] = JSON(key)
                
                let u = userID["userId"].stringValue

                self.geoFire.setLocation(CLLocation(latitude: value["latitude"].doubleValue, longitude: value["longitude"].doubleValue), forKey: u)
            }

        }
        
        self.ref.child("requests").observeSingleEvent(of: .value) { (requests) in
            
            self.requests = JSON(requests.value as Any)

        }
        
        //42.394927, -71.096755
        
        let center = CLLocation(latitude: 42.394927, longitude: -71.096755)
        
        let circle = self.geoFire.query(at: center, withRadius: 5)
        
        let query = circle.observe(.keyEntered, with: { (keyS: String!, location: CLLocation!) in
            print("Key '\(keyS ?? "")' entered the search area and is at location '\(location ?? CLLocation())'")
            
            self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                             // Get user value
                let val = JSON(snapshot.value as Any)
                
                for (key, value) in val
                {
                    if value["userType"].stringValue == "coach" && keyS == key
                    {
                        var val = value
                        val["userId"] = JSON(key)

                        self.coaches.append(val)
                    }
                }
                
                self.coachesTable.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        })
        
    }
    
    @objc func sendRequestToCoach(sender:UIButton)
    {
        let coach = self.coaches[sender.tag - 200]
                
        self.ref.child("requests").child(coach["userId"].stringValue).child(Auth.auth().currentUser!.uid).setValue(["request":"true","userId":Auth.auth().currentUser!.uid])
    //    self.ref.child("users").child(coach["userId"].stringValue).child("requests").child(Auth.auth().currentUser!.uid).setValue(["request":"true","userId":Auth.auth().currentUser!.uid])
        
        sender.setImage(UIImage(systemName: "person.crop.circle.fill.badge.checkmark"), for: .normal)
        
        self.showMessage(message: "Request sent!")
        
    }
    
    func showMessage(message:String)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:-UITableViewDelegate/Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.coaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CoachCell = tableView.dequeueReusableCell(withIdentifier: "CoachCell", for: indexPath) as! CoachCell
        
        cell.selectionStyle = .none
        cell.coach = self.coaches[indexPath.row]
        cell.btnAddCoach.tag = indexPath.row + 200
        cell.btnAddCoach.addTarget(self, action: #selector(sendRequestToCoach(sender:)), for: .touchUpInside)
        
        for (key, _) in self.requests[self.coaches[indexPath.row]["userId"].stringValue]
        {
            if key == Auth.auth().currentUser?.uid
            {
                cell.btnAddCoach.isUserInteractionEnabled = false
                cell.btnAddCoach.setImage(UIImage(systemName: "person.crop.circle.fill.badge.checkmark"), for: .normal)
            }
            else
            {
                cell.btnAddCoach.isUserInteractionEnabled = true
                cell.btnAddCoach.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //MARK:-IBActions


}

extension CoachListViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        
        
        print("user:\(self.userLocation!.coordinate.latitude),\(self.userLocation!.coordinate.longitude)")
        
        
        self.getCoaches()
        
        manager.stopUpdatingLocation()
    }
}

