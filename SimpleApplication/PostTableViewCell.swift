//
//  PostTableViewCell.swift
//  SimpleApplication
//
//  Created by tùng hoàng on 1/23/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
import UIKit
import HCTServices

class PostTableViewCell : UITableViewCell {
  @IBOutlet weak var loading: UIActivityIndicatorView!
  @IBOutlet weak var photo: UIImageView!
  func configure(post: Post) {
    guard let urlStr = post.urls?.regular, let url = URL(string: urlStr) else {
      return
    }
    
    let option = UrlOptions(url: url)
    loading.isHidden = false
    FileLoader.shared.downloadImage(with: option) { [weak self] (value, error) in
      guard let self = self else {
        return
      }
      guard let value = value else {
        return
      }
      DispatchQueue.main.async {
        self.photo.image = value
        self.loading.isHidden = true
        self.layoutIfNeeded()
      }
    }
  }
}
