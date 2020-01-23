//
//  FileLoader+Extension.swift
//  HCTServices
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
import UIKit
//load image
typealias JSONObject = [String : String]
extension FileLoader {
  public func downloadImage(with option: UrlOptions, completion: @escaping ServiceCompletion<UIImage>) {
    self.download(with: option) { (data, error) in
      guard let data = data, error == nil else {
        completion(nil, error)
        return
      }
      completion(UIImage(data: data), nil)
    }
  }
  public func downloadJson<T:Decodable>(ofType: T.Type, with option: UrlOptions, completion: @escaping ServiceCompletion<T>) {
    self.download(with: option) { (data, error) in
      guard let data = data, error == nil else {
        completion(nil, error)
        return
      }
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let object = try decoder.decode(T.self, from: data)
        completion(object, nil);
      } catch let jsonError {
        print("Failed to decode: ", jsonError)
      }
      //completion(jsonData, nil)
    }
  }

}
