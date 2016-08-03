//
//  PostTableViewCell.swift
//  tumblrClient
//
//  Created by tianhe_wang on 8/3/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit
import AFNetworking

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
