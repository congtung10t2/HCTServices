//
//  User.swift
//  SimpleApplication
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
class User : NSObject, Decodable{
  let id: String?
  let username: String?
  let name: String?
  let profileImage: ProfileImage?
  let links: Links?
}
//
