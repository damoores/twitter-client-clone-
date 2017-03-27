//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/23/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var profileImageView: UIImageView!
   @IBOutlet weak var location: UILabel!

   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      // Do any additional setup after loading the view.
   }
   var profile : User?
   
   var user : User? {
      didSet {
         self.name.text = user?.name
         self.location.text = user?.location
         UIImage.fetchImageWith((user?.profileImageURL)!) {(profilePic) in
            self.profileImageView.image = profilePic
         }
      }
   }
   


}
