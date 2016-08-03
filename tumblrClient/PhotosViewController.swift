//
//  ViewController.swift
//  tumblrClient
//
//  Created by tianhe_wang on 8/3/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  var posts: [NSDictionary]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    fetchData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func fetchData() {
    
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
                                }
                              }
                            }
      })
    task.resume()
  }
  
}

