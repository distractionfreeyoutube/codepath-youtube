//
//  VideoTableViewCell.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
