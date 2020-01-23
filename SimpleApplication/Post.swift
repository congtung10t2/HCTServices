//
//  Post.swift
//  SimpleApplication
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation

class Post : NSObject, Decodable {
  var id: String?
  var likedByUser: Bool?
  var likes: Int?
  var width: Int?
  var height: Int?
  var createdAt: String?
  var color: String?
  var user: User?
  var urls: Urls?
  var links: Links?
  var currentUserCollections: [User]?
  var categories : [Category] = []
}
