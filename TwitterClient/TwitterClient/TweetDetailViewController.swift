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
      if segue.identifier == "ProfileViewController"{
         if let destinationController = segue.destination as? ProfileViewController {
            destinationController.userProfile = self.profile   
         }
      }
   }
   
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      super.prepare(for: segue, sender: sender) //same segue and sender its passing
//
//   if segue.identifier == "ProfileViewController"{//segue its transitioning to
//
//         if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {//to know index path, returns Int
//            let selectedTweet = self.allTweets[selectedIndex] //above row used to know where tweet is. returns tweet
            
//            if let destinationController = segue.destination as? ProfileViewController {
//               destinationController.tweet = selectedTweet
//            } //makes seleced go into destination controller
            
            //           destinationController.tweet = selectedTweet //assigned it back
//         }
         
         
//      }
      
//   }
   
   

}
