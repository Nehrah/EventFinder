//
//  EventDetailViewController.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021

import Kingfisher
import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    @IBOutlet weak var eventFav: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    private var rightBarButton: UIBarButtonItem!
    private let appConfiguration: AppConfiguration
    private let presenter: EventDetailPresenter
    private var event: Event
    
    init(appConfiguration: AppConfiguration, event: Event) {
        self.appConfiguration = appConfiguration
        presenter = EventDetailPresenter(appConfiguration: appConfiguration)
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @IBAction func eventFavAction(_ sender: Any) {
        presenter.rightBarButtonPressed(event: event)
    }
    func configureUI() {
        presenter.attachView(view: self)
        
        title = "Details"//event.title
        extendedLayoutIncludesOpaqueBars = true
        eventNameLabel.text = event.title
        
        //rightBarButton = UIBarButtonItem(image: UIImage(named: "heart_empty"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(rightBarButtonPressed(sender:)))
        //rightBarButton.tintColor = UIColor.red
       // navigationItem.rightBarButtonItems = [rightBarButton]
        presenter.configureButtonImage(event: event)
        
        //eventImageView.layer.cornerRadius = 10
        if let imageString = event.imageURL, let url = URL(string: imageString) {
            eventImageView.kf.setImage(with: url)
        }
        eventLocationLabel.text = event.formattedCityState
        if let date = event.date {
            eventDateLabel.text = DateFormatter.eventFormatter.string(from: date)
        }
    }
    
    @objc
    func rightBarButtonPressed(sender: UIBarButtonItem) {
        presenter.rightBarButtonPressed(event: event)
    }
}

// MARK: - EventDetailView

extension EventDetailViewController: EventDetailView {
    
    func showEmptyButtonImage() {
        eventFav.setImage(UIImage(named: "heart_empty"), for: .normal)
       // eventF.image = UIImage(named: "heart_empty")
    }
    
    func showFilledButtonImage() {
        eventFav.setImage(UIImage(named: "heart_filled"), for: .normal)
    }
}
