//
//  DataTaskMocks.swift
//  EventFinderTests
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 6/26/19.
//  
//

import Foundation
@testable import EventFinder

class DataTaskMock: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var modelRequestCompletion: ModelRequestCompletion?
    var dataRequestCompletion: DataRequestCompletion?
    
    var modelRequestCompletionResult: Result<DataResponse<Decodable>, Error>?
    var dataRequestCompletionResult: Result<DataResponse<Data>, Error>?
    
    override func resume() {
        if let modelRequestCompletionResult = modelRequestCompletionResult {
            modelRequestCompletion?(modelRequestCompletionResult)
        }
        if let dataRequestCompletionResult = dataRequestCompletionResult {
            dataRequestCompletion?(dataRequestCompletionResult)
        }
    }
}
