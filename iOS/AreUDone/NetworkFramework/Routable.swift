//
//  Routable.swift
//  NetworkFramework
//
//  Created by a1111 on 2020/11/19.
//

import Foundation

public enum APIError: Error {
  case data,
       decodingJSON
  case redirection,  // 300 번
       client,        // 400 번
       server,        // 500 번
       failed
}

public protocol Routable {
  func request<T: Decodable>(route: EndPointable, completionHandler: ((Result<T,APIError>) -> Void)?)
}

extension Routable {
  func handleNetworkResponseError(_ response: HTTPURLResponse) -> APIError? {
    switch response.statusCode {
    case 200...299: return nil
    case 300...399: return .redirection
    case 401...500: return .client
    case 501...599: return .server
    default: return .failed
    }
  }
  
  func configureRequest(from route: EndPointable) -> URLRequest? {
    var urlComponents = route.baseURL
    
    if let query = route.query {
      var queryItems = [URLQueryItem]()
      query.forEach { (key, value) in
        queryItems.append(URLQueryItem(name: key, value: value))
      }
      
      urlComponents.queryItems = queryItems
    }
    
    if let url = urlComponents.url {
      var request = URLRequest(url: url)
      
      request.httpMethod = route.httpMethod?.rawValue
      request.httpBody = route.bodies?.encode().data(using: String.Encoding.utf8)
      route.headers?.forEach { key, value in
        request.setValue(value, forHTTPHeaderField: key)
      }
      return request
    }
    return nil
  }
}

