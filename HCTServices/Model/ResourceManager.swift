//
//  ResourceManager.swift
//  HCTServices
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
import UIKit
class ResourceManager{
  private static var instance: ResourceManager = ResourceManager();
  private let dataCache = NSCache<NSString, NSData>()
  private init() {
    //Can only init inside class
    setCacheLimit(totalCostLimit: nil, countLimit: nil);
  }
  static func shared() -> ResourceManager {
    return instance
  }
  func setDataObject(data: NSData, forKey key:NSString){
    dataCache.setObject(data, forKey: key)
  }
  func setCacheLimit(totalCostLimit:Int? = LibConfig.memoryCapacity, countLimit:Int? = LibConfig.capacity) {
    
    if let totalCostLimit = totalCostLimit {
      dataCache.totalCostLimit = totalCostLimit
    }
    if let countLimit = countLimit {
      dataCache.countLimit = countLimit
    }
  }
  
  func getDataObject(forKey key: NSString) -> NSData?{
    return dataCache.object(forKey: key)
  }
}
