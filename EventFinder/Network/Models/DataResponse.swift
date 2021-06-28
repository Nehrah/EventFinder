//
//  DataResponse.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021

import Foundation

struct DataResponse<T> {
    
    let data: T?
    let urlResponse: URLResponse?
    
    init(data: T?, urlResponse: URLResponse?) {
        self.data = data
        self.urlResponse = urlResponse
    }
}
