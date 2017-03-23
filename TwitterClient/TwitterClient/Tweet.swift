//
//  Tweet.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/20/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation

class Tweet {
   
   let text : String
   let id : String
   let retweeted : Bool
   
   var user : User?
   
   
   init?(json: [String: Any]) { //string is there to represent keys, any is the values in the JSON file
      if let text = json["text"] as? String, let id = json["id_str"] as? String {//retrieves it as a string
         self.text = text
         self.id = id
         if let userDictionary = json["user"] as? [String : Any] {
            self.user = User(json: userDictionary)
         }
         if json["retweeted_status"] == nil {
            self.retweeted = false
         }else {
            self.retweeted = true
            print("true")
         }
      } else {
         return nil
      }
      
      
      
   }
   
}
