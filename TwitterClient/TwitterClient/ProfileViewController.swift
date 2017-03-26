//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/23/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

      var user : User? {
         didSet {
            self.name.text = user?.name
            self.location.text = user?.location
            UIImage.fetchImageWith((user?.profileImageURL)!) {(profilePic) in
            self.profileImageView.image = profilePic
            }
         }
      }
      
        // Do any additional setup after loading the view.
    }


}
