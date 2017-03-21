//
//  JSONParser.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/20/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Tweet]?)->()

class JSONParser {
   
   static var sampleJSONData : Data {
      guard let tweetJSONPath = Bundle.main.url(forResource: "tweet", withExtension: "json") else //bundle is part of foundation
      { fatalError("Tweet.json does not exist in this bundle") }
      
      do {
      
         let tweetJSONData = try Data(contentsOf: tweetJSONPath)
         
         return tweetJSONData
         
      } catch {
         fatalError("Failed to create data from tweetJSONPath")
      }
      
   }

   class func tweetsFrom(data: Data, callback: JSONParserCallback){ //used off of typealias
      
      do{
         if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]]{
            var tweets = [Tweet]()
            
            for tweetDictionary in rootObject {
               if let tweet = Tweet(json: tweetDictionary){
                  tweets.append(tweet)
               }
            }
            
            callback(true, tweets)
            
         }
      } catch {
         print("Error Serializing JSON")
         callback(false, nil) //if it fails it will send this to the callback aka (Bool, [Tweet]?)->()
      }
      
   }
   
}
