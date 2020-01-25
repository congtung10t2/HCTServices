//
//  ViewController.swift
//  SimpleApplication
//
//  Created by tùng hoàng on 1/22/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import UIKit
import HCTServices

class ViewController: UIViewController {
  var refreshControl: UIRefreshControl?
  var posts : [Post] = []
  @IBOutlet weak var postsTable: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    postsTable.dataSource = self;
    postsTable.delegate = self;
    self.loadData()
    self.refreshData()
  }
  func refreshData(){
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action:  #selector(loadData), for: .valueChanged)
    self.refreshControl = refreshControl
    self.postsTable.addSubview(refreshControl)
  }
  
  @objc func loadData() {
    guard let url = URL(string: AppConfig.endPointUrl) else {
      return
    }
    let option = UrlOptions(url: url)
    FileLoader.shared.downloadJson(ofType: [Post].self, with: option) {[weak self] (value, error) in
      guard let self = self else {
        return;
      }
      guard let value = value else {
        return
      }
      self.posts = value
      DispatchQueue.main.async {
        self.postsTable.reloadData()
        self.refreshControl?.endRefreshing()
      }
    }
  }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell
      else {
        return UITableViewCell()
    }
    cell.configure(post: posts[indexPath.row])
    return cell
  }
}
