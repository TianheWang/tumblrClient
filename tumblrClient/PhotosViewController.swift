//
//  ViewController.swift
//  tumblrClient
//
//  Created by tianhe_wang on 8/3/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var posts: [NSDictionary]!
  
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 320
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(fetchData(_:)), forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)
    fetchData(refreshControl)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
    func fetchData(refreshControl: UIRefreshControl) {
    
    let clientId = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    let url = NSURL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(clientId)")
    let request = NSURLRequest(
      URL: url!,
      cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
      timeoutInterval: 10)
    
    let session = NSURLSession(
      configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
      delegate: nil,
      delegateQueue: NSOperationQueue.mainQueue()
    )
    
    let task: NSURLSessionDataTask = session
      .dataTaskWithRequest(request,
                           completionHandler: { (dataOrNil, response, error) in
                            if let data = dataOrNil {
                              if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                data, options:[]) as? NSDictionary {
                                let response = responseDictionary["response"] as? NSDictionary
                                if let response = response {
                                  self.posts = response["posts"] as? [NSDictionary]
                                  print(self.posts.count)
                                  self.tableView.reloadData()
                                }
                              }
                            }
                            refreshControl.endRefreshing()
      })
    task.resume()
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as! PostTableViewCell
    let post = posts![indexPath.row]
    let photos = post["photos"] as? [NSDictionary]
    let originalSize = photos![0]["original_size"] as? NSDictionary
    let imageURL = originalSize!["url"] as? String
    let postImageURL = NSURL(string: imageURL!)
    
    let postTitle = post["summary"] as? String
    cell.postImageView.setImageWithURL(postImageURL!)
    cell.postTitle.text = postTitle

    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts?.count ?? 0
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let cell = sender as! PostTableViewCell
    let indexPath = tableView.indexPathForCell(cell)
    let post = posts![indexPath!.row]
    let photos = post["photos"] as? [NSDictionary]
    let originalSize = photos![0]["original_size"] as? NSDictionary
    let imageURL = originalSize!["url"] as? String

    
    let destinationViewController = segue.destinationViewController as! PhotoDetailsViewController
    destinationViewController.photoUrl = imageURL!

  }
  
}

