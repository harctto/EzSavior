//
//  HomeTableInfoOutcomeCell.swift
//  EzSavior
//
//  Created by Hatto on 1/12/2563 BE.
//

import UIKit

class HomeTableInfoOutcomeCell: UITableViewCell {

    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbNotes: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var imgIconType: UIImageView!
    @IBOutlet weak var viewInfoCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
