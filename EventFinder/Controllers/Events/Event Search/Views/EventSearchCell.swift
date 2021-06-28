//
//  EventSearchCell.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021
//

import Kingfisher
import UIKit

class EventSearchCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(event: Event, isFavorite: Bool) {
        
        favoriteImageView.isHidden = !isFavorite
        eventImageView.layer.cornerRadius = 10
        if let imageString = event.imageURL, let url = URL(string: imageString) {
            eventImageView.kf.setImage(with: url)
        } else {
            eventImageView.image = nil
        }
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.formattedCityState
        if let date = event.date {
            eventDateLabel.text = DateFormatter.eventFormatter.string(from: date)
        }
    }
}
extension UITableViewCell{
func shadowAndBorderForCell(EventSearchCell : UITableViewCell){
// SHADOW AND BORDER FOR CELL
//EventSearchCell.contentView.layer.cornerRadius = 5
    if #available(iOS 13.0, *) {
        EventSearchCell.backgroundColor = UIColor.systemGray6
    } else {
        EventSearchCell.backgroundColor = UIColor.systemGray
    }
EventSearchCell.contentView.layer.borderWidth = 2
//EventSearchCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
EventSearchCell.contentView.layer.masksToBounds = false
EventSearchCell.layer.shadowColor = UIColor.lightGray.cgColor
    EventSearchCell.layer.shadowOffset = CGSize(width: 3, height: 3.0)
EventSearchCell.layer.shadowRadius = 6.0
    EventSearchCell.layer.shadowOpacity = 0.7
EventSearchCell.layer.masksToBounds = false
    EventSearchCell.layer.cornerRadius = 2
    
   
/*EventSearchCell.layer.shadowPath = UIBezierPath(roundedRect:EventSearchCell.bounds, cornerRadius:EventSearchCell.contentView.layer.cornerRadius).cgPath*/
    EventSearchCell.layer.shadowPath = UIBezierPath(rect: EventSearchCell.bounds).cgPath
    
  
}
}

