//
//  NewEmptyLegsTblViewCell.swift
//  FLY ELITEJETS
//
//  Created by iMac on 09/09/25.
//

import UIKit

class NewEmptyLegsTblViewCell: UITableViewCell {

    @IBOutlet weak var lblJetType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblToName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
