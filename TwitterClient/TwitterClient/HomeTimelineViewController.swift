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
   
   var profile : User?
   
   
   override func viewDidLoad() { //this is a function already in the UIViewController
      super.viewDidLoad()
      
      self.navigationItem.title = "My Timeline" //not part of the navigation controller
      
      self.tableView.dataSource = self //need this line to render
      
      let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
      self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
      
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
      
      if segue.identifier == TweetDetailViewController.identifier{//segue its transitioning to
         
         if let selectedIndex = tableView.indexPathForSelectedRow?.row {//to know index path, returns Int
            let selectedTweet = allTweets[selectedIndex] //above row used to know where tweet is. returns tweet
            
            if let destinationController = segue.destination as? TweetDetailViewController {
               destinationController.tweet = selectedTweet
            } //makes seleced go into destination controller
            
 //           destinationController.tweet = selectedTweet //assigned it back
         }
         
          	
      }
      if segue.identifier == ProfileViewController.identifier {
         print("inside of prepare (for segue) in ProfileViewController")
         
         guard let destinationController = segue.destination as?
            ProfileViewController else { return }
         
         API.shared.getUser(callback: { (user) in
         destinationController.user = user})      }
   }
   
   
   
   func updateTimeline(){
      
      self.activityIndicator.startAnimating() //starts animation right here for the activity thing
      
      API.shared.getTweets { (tweets) in
         OperationQueue.main.addOperation { //manages thread to not bog down!WILL WORK CONCURRENT
            self.allTweets = tweets ?? []
            self.activityIndicator.stopAnimating() //stops activity at the end of the request
         
      }
    
      API.shared.getUser(callback: { (aUser) in
         guard let userProfile = aUser else { fatalError ("Cannot access profile") }
         
         OperationQueue.main.addOperation {
            self.profile = userProfile
         }
      })
      
      OperationQueue.main.addOperation {
         self.activityIndicator.stopAnimating()
         self.allTweets = tweets!
      }
      
      
      //      OperationQueue.main.maxConcurrentOperationCount = 1
   }
}
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      return allTweets.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TweetNibCell //can use this instead of the if let
      
      let tweetToShow = self.allTweets[indexPath.row]
      
         cell.tweet.text = tweet
         //cell.tweetUserLabel.text = tweetToShow.user?.name
     
//
      return cell
   }
   
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
      self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
   
  }
   
 }
 
 
 
 
 
