//
//  LikeTableViewCell.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 01/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit

class LikeTableViewCell: UITableViewCell {

    @IBOutlet weak var liketagname: UILabel!
    
    @IBOutlet weak var copyToClipBoard: UIButton!
    
    @IBAction func copyToKeyboard(_ sender: Any)
    {
        UIPasteboard.general.string = liketagname.text
        print("LikedTag Copied :\(liketagname.text!)")
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
