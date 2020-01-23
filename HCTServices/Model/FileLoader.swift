//
//  API.swift
//  HCTServices
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation

open class FileLoader {
  private var service: Service!
  public static let shared = FileLoader();
  func download(with options: UrlOptions, completion: @escaping ServiceCompletion<Data>) {
    
    if let dataObject = ResourceManager.shared().getDataObject(forKey: options.url.absoluteString as NSString) {
      completion(dataObject as Data, nil)
      return
    }
    service?.download(with: options) { (data, error) in
      
      if let error = error {
        completion(nil, error)
        return;
      }
      guard let data = data else {
        completion(nil, nil)
        return
      }
      ResourceManager.shared().setDataObject(data: data as NSData, forKey: options.url.absoluteString as NSString)
      completion(data, nil)
    }
  }
  
  private init() {
    service = ServiceImplement()
  }
  
  func cancel(from url: URL) {
    service.cancel(from: url)
  }
}
