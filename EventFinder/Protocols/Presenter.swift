//
//  Presenter.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021.
//  
//

import Foundation

protocol Presenter {
    
    associatedtype View
    
    func attachView(view: View)
    func detachView()
}
