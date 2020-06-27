//
//  UserRequestsViewController.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/5/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON
import FirebaseAuth

class UserRequestsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //MARK:-IBOutlets
    
    @IBOutlet weak var userRequestsTable: UITableView!
    
    //MARK:-Properties
    
    var ref: DatabaseReference!
    var userRequests = [JSON]()
    
    //MARK:-Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        self.title = "User Requests"
        
        self.ref = Database.database().reference()
        
        self.userRequestsTable.delegate = self
        self.userRequestsTable.dataSource = self
        
        self.getUserRequests()
        
        
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
            view.isCoach = true
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
        let showFriends = UIAlertAction(title: "My Trainees", style: .default) { (action) in
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
            view.isCoach = true
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(editProfile)
        alert.addAction(showFriends)
        alert.addAction(changePassword)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getUserRequests()
    {
        
        self.ref.child("requests").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (requests) in
                        
            let val = JSON(requests.value as Any)
            
            for (key, _) in val
            {
                self.ref.child("users").child(key).observeSingleEvent(of: .value) { (user) in
                                        
                    var u = JSON(user.value as Any)
                    
                    u["userId"] = JSON(key)
                    
                    self.userRequests.append(u)
                    
                    self.userRequestsTable.reloadData()

                }
                
            }
        }

    }
    
    @objc func acceptRequest(sender:UIButton)
    {
        let user = self.userRequests[sender.tag - 200]
                
        //Add friend to login user list
        self.ref.child("friends").child(Auth.auth().currentUser!.uid).child(user["userId"].stringValue).setValue(["isFriend":"true","friendId":user["userId"].stringValue])
        
        //Add friend to the user who sent request
        self.ref.child("friends").child(user["userId"].stringValue).child(Auth.auth().currentUser!.uid).setValue(["isFriend":"true","friendId":Auth.auth().currentUser!.uid])
        
        //Remove request from request table
        self.ref.child("requests").child(Auth.auth().currentUser!.uid).child(user["userId"].stringValue).removeValue()
        
        self.userRequests.remove(at: sender.tag - 200)
        
        self.userRequestsTable.reloadData()
        
    }
    
    @objc func rejectRequest(sender:UIButton)
    {
        let user = self.userRequests[sender.tag - 300]
        
        self.ref.child("requests").child(Auth.auth().currentUser!.uid).child(user["userId"].stringValue).removeValue()
        
        self.userRequests.remove(at: sender.tag - 300)
        self.userRequestsTable.reloadData()
    }
    
    //MARK:-UITableViewDelegate/Datasource
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.userRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
                
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        cell.selectionStyle = .none
        
        cell.lblUserName.text = self.userRequests[indexPath.row]["name"].stringValue
        
        cell.btnAccept.tag = indexPath.row + 200
        cell.btnReject.tag = indexPath.row + 300
        
        cell.btnReject.addTarget(self, action: #selector(rejectRequest(sender:)), for: .touchUpInside)
        cell.btnAccept.addTarget(self, action: #selector(acceptRequest(sender:)), for: .touchUpInside)
        
        return cell
    }

}
