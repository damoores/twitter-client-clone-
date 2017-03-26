//
//  TweetNibCell.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/23/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {
   @IBOutlet weak var userImageView: NSLayoutConstraint!
   @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
   
   
   var tweet: Tweet! {
      didSet {
         self.tweetLabel.text = tweet.text
         self.usernameLabel.text = tweet.user?.name ?? "Unknown User"
         
         if let user = tweet.user{//use this to wrap this function to unwrap it
            UIImage.fetchImageWith(user.profileImageURL){(image) in
               self.userImageView.image = image
            }
         }
         
         
      }
   }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
}
