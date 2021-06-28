//
//  URLSessionMock.swift
//  EventFinderTests
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 6/26/19.
//  
//

import Foundation
@testable import EventFinder

class URLSessionMock: URLSession {
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let dataTaskMock = DataTaskMock()
        dataTaskMock.completionHandler = completionHandler
        return dataTaskMock
    }
}
