//
//  URLOptions.swift
//  HCTServices
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
//TODO maybe more options in the future like accesskey, url param, etc..
open class UrlOptions {
  public var url: URL!
  public init(url: URL) {
    self.url = url;
  }
}
