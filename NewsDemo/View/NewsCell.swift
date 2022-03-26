//
//  Golescell.swift
//  Daily Positive Me
//
//  Created by Intelivita iOS on 17/08/21.
//  Copyright © 2021 Aamil Silawat. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    //MARK:- === Outlet ===
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWebLink: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
