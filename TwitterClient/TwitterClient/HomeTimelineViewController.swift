 //
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/20/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   var dataSource = [Tweet]() {
      //so that table view reloads with data
      didSet {
         self.tableView.reloadData()
      }
   }
   
   @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() { //this is a function already in the UIViewController
        super.viewDidLoad()
      
         self.tableView.dataSource = self //need this line to render
         self.tableView.delegate = self
      
      updateTimeline()
      
//         JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
//            if(success){
//               guard let tweets = tweets else { fatalError("Tweets came back nil") }//guard doesnt let it go past if there is nothing or it cant unwrap something, if let  still keeps it going
//               
//               for tweet in tweets {
//                  dataSource.append(tweet)
////                  print(tweet.text)
//               }
//            }
//      }
    }
   
   func updateTimeline(){
      API.shared.getTweets { (tweets) in
         OperationQueue.main.addOperation { //manages thread to not bog down!WILL WORK CONCURRENT 
            self.dataSource = tweets ?? []
         }
         
         
      }
   }



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
   return dataSource.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
   let tweetToShow = dataSource[indexPath.row]
   
   
   let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
   
   cell.textLabel?.text = tweetToShow.text //indexPath know rows and sections
   
   cell.detailTextLabel?.text = tweetToShow.user?.name
   
   return cell
   
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      print("\(indexPath.row)")
      
   }
   
 }
 
 
 
 
 
