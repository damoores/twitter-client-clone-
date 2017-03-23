 //
 //  HomeTimelineViewController.swift
 //  TwitterClient
 //
 //  Created by Rio Balderas on 3/20/17.
 //  Copyright © 2017 Jay Balderas. All rights reserved.
 //
 
 import UIKit
 
 class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   var allTweets = [Tweet]() {
      //so that table view reloads with data
      didSet {
         self.tableView.reloadData()
      }
   }
   
   
   override func viewDidLoad() { //this is a function already in the UIViewController
      super.viewDidLoad()
      
      self.navigationItem.title = "My Timeline" //not part of the navigation controller
      
      self.tableView.dataSource = self //need this line to render
      self.tableView.delegate = self
      self.tableView.estimatedRowHeight = 50 //need this to show the height of the cell
      self.tableView.rowHeight = UITableViewAutomaticDimension
      
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
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender) //same segue and sender its passing
      
      if segue.identifier == "showDetailSegue"{//segue its transitioning to
         
         if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {//to know index path, returns Int
            let selectedTweet = self.allTweets[selectedIndex] //above row used to know where tweet is. returns tweet
            
            guard let destinationController = segue.destination as? TweetDetailViewController else { return } //makes seleced go into destination controller
            
            destinationController.tweet = selectedTweet //assigned it back
         }
          
      }
   }
   
   func updateTimeline(){
      
      self.activityIndicator.startAnimating() //starts animation right here for the activity thing
      
      API.shared.getTweets { (tweets) in
         OperationQueue.main.addOperation { //manages thread to not bog down!WILL WORK CONCURRENT
            self.allTweets = tweets ?? []
            self.activityIndicator.stopAnimating() //stops activity at the end of the request
         }
      }
      //      OperationQueue.main.maxConcurrentOperationCount = 1
   }
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      return allTweets.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) //as! TweetCell can use this instead of the if let
      let tweetToShow = allTweets[indexPath.row]
      
      if let cell = cell as? TweetCell {
         cell.tweetLabel.text = tweetToShow.text
         cell.tweetUserLabel.text = tweetToShow.user?.name
      }
//      else {
//         cell.tweetLabel = TweetDetailViewController.tweet.text
//         cell.tweeUserLabel = TweetDetailViewController.tweet.user?.name ?? "Unknown"
//      }
      return cell
   }
   
   
   
//   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      
//      print("\(indexPath.row)")
//      
//   }
   
 }
 
 
 
 
 
