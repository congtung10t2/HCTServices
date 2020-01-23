//
//  Category.swift
//  SimpleApplication
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
class Category : NSObject, Decodable {
  var id: Int
  var title: String
  var photoCount: Int?
  var links : Links?
}
