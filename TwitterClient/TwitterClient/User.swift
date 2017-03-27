//
//  User.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/20/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation

class User{
   
   let name : String
   let profileImageURL : String
   let location : String
   let screenName : String
   
   init?(json:[String: Any]) {
      print(json)//allow to look at json to get parameters
      
      
      
      if let name = json["name"] as? String,
         let profileImageURL = json["profile_image_url"] as? String,
         let location = json["location"] as? String,
         let screenName = json["screen_name"] as? String {
         
         self.name = name
         self.profileImageURL = profileImageURL
         self.location = location
         self.screenName = screenName
         
      } else {
         return nil
      }
   }
}
