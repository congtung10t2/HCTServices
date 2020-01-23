//
//  Service.swift
//  HCTServices
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation

public typealias ServiceCompletion<T> = (_ data: T?, _ error: Error?) -> Void
protocol Service {
  func download(with options: UrlOptions, completion: @escaping ServiceCompletion<Data>);
  func cancel(from url: URL);
}
class ServiceImplement : Service {//Simple get data by dataTask. We can replace by whatever in the future
  func download(with options: UrlOptions, completion: @escaping ServiceCompletion<Data>) {
    let session = self.getSession()
    session.dataTask(with: URLRequest(url: options.url)) { data, response, error in
     completion(data, error)
    }.resume()
  }
  
  func getSession()-> URLSession {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 30.0
    sessionConfig.timeoutIntervalForResource = 30.0
    let session = URLSession(configuration: sessionConfig)
    return session
  }
  
  func cancel(from url: URL) {
    URLSession.shared.getAllTasks { sessions in
      _ = sessions.filter({$0.currentRequest?.url == url}).map({$0.cancel()});
    }
  }
}
