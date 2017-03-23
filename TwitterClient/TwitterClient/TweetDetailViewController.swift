//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/22/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
   
   var tweet : Tweet! //makes it crash is there is no tweet present to tweet
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      print(self.tweet.user?.name ?? "Unknown") //nill coalesing for ??
      print(self.tweet.text)
      
        // Do any additional setup after loading the view.
    }


}
