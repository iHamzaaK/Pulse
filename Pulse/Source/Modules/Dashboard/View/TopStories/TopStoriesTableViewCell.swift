//
//  TopStoriesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import ReadMoreTextView
class TopStoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtViewDetail: ReadMoreTextView!{
        didSet{
            txtViewDetail.textContainerInset.left = 0
            let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: self.contentView.tintColor,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]
            let readLessTextAttributes = [
                NSAttributedString.Key.foregroundColor: self.contentView.tintColor,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]
            txtViewDetail.attributedReadMoreText = NSAttributedString(string: "... Read more", attributes: readMoreTextAttributes)
            txtViewDetail.attributedReadLessText = NSAttributedString(string: " Read less", attributes: readLessTextAttributes)
        }
    }
    @IBOutlet weak var btnSendComment: UIButton!
    @IBOutlet weak var txtComment: BaseUITextfield!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var btnBookmark: BaseUIButton!
    @IBOutlet weak var btnShare: BaseUIButton!
    @IBOutlet weak var btnLike: BaseUIButton!
    @IBOutlet weak var lblNewsType: BaseUILabel!
    @IBOutlet weak var lblDate: BaseUILabel!
    @IBOutlet weak var lblTitle: BaseUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            
        txtViewDetail.onSizeChange = { _ in }
        txtViewDetail.shouldTrim = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
