//
//  HomeTableViewCell.swift
//  EzSavior
//
//  Created by Hatto on 17/11/2563 BE.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var txtdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtdate.font = .systemFont(ofSize: 20, weight: .heavy)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

