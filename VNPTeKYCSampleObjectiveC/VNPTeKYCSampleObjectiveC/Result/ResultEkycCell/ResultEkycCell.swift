//
//  ResultEkycCell.swift
//  FullVNPTeKYC
//
//  Created by Minh Nguyễn Minh on 04/01/2023.
//

import UIKit

class ResultEkycCell: UITableViewCell {

    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var imageViewCapture: UIImageView!
    
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    @IBOutlet weak var widthImageView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.labelContent.font = UIFont.systemFont(ofSize: 15.0)
        self.labelContent.textColor = UIColor.black
        self.labelContent.numberOfLines = 0
        
        self.imageViewCapture.backgroundColor = UIColor.white
        self.heightImageView.constant = 0.0
        self.widthImageView.constant = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
