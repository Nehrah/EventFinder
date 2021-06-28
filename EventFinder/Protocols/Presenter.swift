//
//  Presenter.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 9/19/19.
//  
//

import Foundation

protocol Presenter {
    
    associatedtype View
    
    func attachView(view: View)
    func detachView()
}
