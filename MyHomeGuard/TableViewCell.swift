//
//  TableViewCell.swift
//  MyHomeGuard
//
//  Created by YIDING on 7/10/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageThumb: UIImageView!
    
    @IBOutlet weak var textThumb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
