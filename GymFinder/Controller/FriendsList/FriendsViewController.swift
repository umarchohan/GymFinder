//
//  FriendsViewController.swift
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

class FriendsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    //MARK:-IBOutlets
    @IBOutlet weak var friendsTable: UITableView!
    
    //MARK:-Properties
    
    var isCoach:Bool = true
    
    var ref: DatabaseReference!
    var friends = [JSON]()
    
    //MARK:-Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.friendsTable.delegate = self
        self.friendsTable.dataSource = self
        
        self.ref = Database.database().reference()
        
        self.getFriends()
    }
    
    //MARK:-Private
    
    func getFriends()
    {
        self.ref.child("friends").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snaphsot) in
            
            let val = JSON(snaphsot.value as Any)
            
            for (key, _) in val
            {
                self.ref.child("users").child(key).observeSingleEvent(of: .value) { (user) in
                                        
                    var u = JSON(user.value as Any)
                    
                    u["userId"] = JSON(key)
                    
                    self.friends.append(u)
                    
                    self.friendsTable.reloadData()

                }
                
            }
            
        }
    }
    
    //MARK:-UITableViewDelegate/Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CoachCell = tableView.dequeueReusableCell(withIdentifier: "CoachCell", for: indexPath) as! CoachCell
        
        cell.selectionStyle = .none
        cell.coach = self.friends[indexPath.row]
        
        cell.btnAddCoach.isHidden = true

        return cell
    }
    
    //MARK:-IBActions


}
