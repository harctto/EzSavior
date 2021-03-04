//
//  IncomeDDCell.swift
//  EzSavior
//
//  Created by Hatto on 30/11/2563 BE.
//

import UIKit
import DropDown

class IncomeDDCell: DropDownCell {
    
    @IBOutlet weak var DDImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        DDImage.contentMode = .scaleAspectFit
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
