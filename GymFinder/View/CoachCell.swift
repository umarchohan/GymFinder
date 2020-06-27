//
//  CoachCell.swift
//  GymFinder
//
//  Created by Umar Afzal on 6/4/20.
//  Copyright © 2020 Umar Afzal. All rights reserved.
//

import UIKit
import SwiftyJSON

class CoachCell: UITableViewCell
{
    @IBOutlet weak var lblCoachName: UILabel!
    @IBOutlet weak var lblCoachRate: UILabel!
    @IBOutlet weak var btnAddCoach: UIButton!
    
    var coach:JSON = JSON()
    {
        didSet {
            
            self.lblCoachName.text = coach["name"].stringValue
            
            if coach["hourly"].stringValue.count > 0
            {
                self.lblCoachRate.text = "Hourly:\(coach["hourly"].stringValue)$"
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
