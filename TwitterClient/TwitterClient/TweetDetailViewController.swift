//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/22/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit 

class TweetDetailViewController: UIViewController {
   
   @IBOutlet weak var tweetUserLabel: UILabel!
   @IBOutlet weak var tweetLabel: UILabel!
   @IBOutlet weak var retweetedLabel: UILabel!
   
   var tweet : Tweet! //makes it crash if there is no tweet present to tweet
   
    override func viewDidLoad() {
        super.viewDidLoad()
   
      self.tweetLabel.text = tweet.text
      self.tweetUserLabel.text = tweet.user?.name ?? "Unknown"
      
      if self.tweet.retweeted{
      self.retweetedLabel.text = "This is retweeted"
      } else {
      self.retweetedLabel.text = "Not a retweet"
      }
      
      print(self.tweet.user?.name ?? "Unknown") //nill coalesing for ??
      print(self.tweet.text)
         
    }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender)
      
      if segue.identifier == ProfileViewController.identifier{
         if let destinationController = segue.destination as? ProfileViewController {
          
            API.shared.getUser(callback: { (user) in
               destinationController.user = user})
         }
      }
   }
}

   

