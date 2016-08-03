//
//  PhotoDetailsViewController.swift
//  tumblrClient
//
//  Created by kate_odnous on 8/3/16.
//  Copyright © 2016 tianhe_wang. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
  
  @IBOutlet weak var postImageView: UIImageView!
  var photoUrl: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageURL = NSURL(string: self.photoUrl)
    postImageView.setImageWithURL(imageURL!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
