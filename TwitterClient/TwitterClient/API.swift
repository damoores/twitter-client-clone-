//
//  API.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/21/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountCallback = (ACAccount?) -> () //giving a new name to another type
typealias UserCallback = (User?) -> ()
typealias TweetsCallback = ([Tweet]?) ->()

//enum Callback {
//   case Accounts(ACAccount?)
//   case User(User?)
//   case Tweets([Tweet]?)
//}
//
//typealias babyGotBack = (Callback) -> ()


class API{
   static let shared = API()
   
   var account : ACAccount? //telling variable what type it is, aka ACAccount
   
   private func login(callback: @escaping AccountCallback){//these are trailing closures, escaping the scope of function itself, used to asychronous calls , i.e. @escaping
      let accountStore = ACAccountStore()
      
      let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
      
      accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
         
         if let error = error {
            print("Error: \(error.localizedDescription)")
            callback(nil)
            return
         }
         
         if success {
            //if no errors...
            if let account = accountStore.accounts(with: accountType).first as? ACAccount{
               callback(account)
            }
         } else {
            print("The user did not allow access to this account")
            callback(nil)
         }
         
      }
   }
   
   private func getOAuthUser(callback: @escaping UserCallback){
      let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
      
      if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
         
         request.account = self.account
         
         request.perform(handler: { (data, response, error) in
            if let error = error {
               print("Error: \(error)")
               callback(nil) //this callback needs an escaping thing by the callback
               return
            }
            
            guard let response = response else { callback(nil); return }
            guard let data = data else { callback(nil); return}
            
            
            
            switch response.statusCode {
               
            case 200...299:
               JSONParser.responseStatusCodes(data: data, callback: { (success, tweets) in
                  if success {
                     callback(tweets)
                  }
               })
               print("Everything is good with a \(response.statusCode)")
            case 400...499:
               print("Something is wrong with the app with a code \(response.statusCode)")
               return
            case 500...599:
               print("\(response.statusCode) means there is a problem with a server")
               return
            default:
               print("Error response came back with statusCode: \(response.statusCode)")
               callback(nil)
            }
         
            
         })
         //               if let userJSON = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
         //                  let user = User(json: userJSON)
         //                  print("Everything is good with a \(response.statusCode)")
         //                  callback(user)
         //
         //               }
         //need to put in a do catch for this force unwrap, and move this JSON part in the JSON parser class
      }//need to import social framework
      
   }
   
   private func updateTimeline(callback: @escaping TweetsCallback){
      
      let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
      
      if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {//parameters are for the key value pairing in the url for the API its requesting from.
         request.account = self.account
      request.perform(handler: { (data, response, error) in
      
      if let error = error {
         print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
         callback(nil)
         return
      }
         guard let response = response else { callback(nil); return }
         guard let data = data else { callback(nil); return }
         
         if response.statusCode >= 200 && response.statusCode <= 300 {
         
            JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
               if success {
                  callback(tweets)
               }
            })
            
         } else {
            print("Something else went wrong! We have a status code outside 200-299")
            callback(nil)
         }
      
      })
      }
      
   }
   func getTweets(callback: @escaping TweetsCallback){
   
      if self.account == nil {
         
         login(callback: { (account) in
            if let account = account {
               self.account = account
               self.updateTimeline(callback: { (tweets) in
                  callback(tweets) //need escaping closure to let the callback come out the scope
               })
            }
         })
      } else {
//         self.updateTimeline(callback: callback) // this does the same thing as the one right below
         self.updateTimeline(callback: { (tweets) in
            callback(tweets)
         })
      
      }
      
   }
   
}
