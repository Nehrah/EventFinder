//
//  EventSearchViewController.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021
//

import UIKit

protocol EventSearchViewControllerDelegate: class {
    
    func didSelectEvent(event: Event)
}

class EventSearchViewController: UIViewController {
    
    enum State {
        case start
        case empty
        case loading
        case events
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    weak var delegate: EventSearchViewControllerDelegate?
    
    private let appConfiguration: AppConfiguration
    private let presenter: EventSearchPresenter
    private let searchController: UISearchController
    
    private var events = [Event]()
    private var selectedEvent: Event?
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        presenter = EventSearchPresenter(appConfiguration: appConfiguration)
        searchController = UISearchController(searchResultsController: nil)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateSearchResults(for: searchController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureUI() {
        presenter.attachView(view: self)
        tableView.separatorStyle = .none
        //title = NSLocalizedString("SeatGreek Finder", comment: "")
        extendedLayoutIncludesOpaqueBars = false
        
        tableView.register(UINib(nibName: String(describing: EventSearchCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventSearchCell.self))
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor.darkGray
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.setImage(UIImage(named: "magnifying-glass-icon"), for: .search, state: .normal)
            searchController.searchBar.setMagnifyingGlassColorTo(color: .white)
            
        } else {
            return
        }
        searchController.searchBar.placeholder = NSLocalizedString("Search Events", comment: "")
        searchController.searchBar.tintColor = UIColor(named: "searchBarTint")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor(named: "searchBarText") ?? .black]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        setViewState(state: .loading)
    }
    
  func setViewState(state: State) {
        switch state {
        case .start:
           // tableView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("Use the search bar above to begin finding events", comment: "")
        case .loading:
            tableView.isHidden = true
            loadingIndicator.isHidden = false
            actionLabel.isHidden = true
        case .empty:
            tableView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("No events found :(", comment: "")
        case .events:
            tableView.isHidden = false
            loadingIndicator.isHidden = true
            actionLabel.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource

extension EventSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let eventSearchCell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventSearchCell.self), for: indexPath) as? EventSearchCell {
            cell.contentView.backgroundColor = UIColor(white:0.95,alpha:1)
            eventSearchCell.shadowAndBorderForCell(EventSearchCell: eventSearchCell)
            eventSearchCell.clipsToBounds = false
          
                        //Make cell selection invisible
                        cell.selectionStyle = .none
            let event = events[indexPath.row]
            eventSearchCell.configureData(event: event, isFavorite: appConfiguration.eventRepository.eventIsFavorite(event: event))
            cell = eventSearchCell
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EventSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectEvent(event: events[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
                let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && loadingIndicator.isHidden {
                
                   // self.tableView.reloadData()
                }
    }
}

// MARK: - EventSearchView

extension EventSearchViewController: EventSearchView {
    
    func setState(state: State) {
        setViewState(state: state)
    }
    
    func setEvents(events: [Event]) {
        self.events = events
        tableView.reloadData()
    }
    
    func presentAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating

extension EventSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if(searchController.searchBar.text == nil){
            
            searchController.searchBar.text = ""
        }
        presenter.queryEvents(query: searchController.searchBar.text)
    }
}
extension UISearchBar
{
    func setPlaceholderTextColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }

    func setMagnifyingGlassColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
}
