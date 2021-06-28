//
//  AuthenticatorProtocol.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 6/20/19.
//  
//

import Foundation

typealias AuthenticationCompletion = (Result<URLRequest, Error>) -> Void

protocol AuthenticatorProtocol {
    
    func addAuthentication(requestConfiguration: RequestConfiguration, urlRequest: URLRequest, completion: @escaping AuthenticationCompletion)
}
