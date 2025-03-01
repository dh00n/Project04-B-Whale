//
//  Router.swift
//  NetworkFramework
//
//  Created by a1111 on 2020/11/19.
//

import Foundation

final public class Router: Routable {
  private var task: URLSessionTask?
  
  public init() { }
  
  public func request<T: Decodable>(route: EndPointable, completionHandler: ((Result<T,APIError>) -> Void)? = nil) {
    let session = URLSession.shared
    
    guard let request = configureRequest(from: route) else { return }
    task = session.dataTask(with: request) { data, response, error in
      guard let completionHandler = completionHandler else { return }
      
      guard let data = data else {
        completionHandler(.failure(.data))
        return
      }
      
      if let response = response as? HTTPURLResponse {
        let responseError = self.handleNetworkResponseError(response)
        
        switch responseError {
        case nil: // 200번
          
          if T.self == Data.self {
            completionHandler(.success(data as! T))
          } else {
            do {
              let model = try JSONDecoder().decode(T.self, from: data)
              completionHandler(.success(model))
            } catch {
              print(error)
              completionHandler(.failure(.decodingJSON))
            }
          }
        default: // 300~500번
          if let responseError = responseError {
            completionHandler(.failure(responseError))
          }
        }
      }
    }
    task?.resume()
  }
}


extension Dictionary {
  func encode() -> String {
    return self.map { key, value in
      "\(key)=\(value)"
    }.joined(separator: "&")
  }
}



