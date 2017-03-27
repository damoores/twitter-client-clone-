//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Rio Balderas on 3/23/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

extension UIImage {  //taking any imge url and return an image.  fetch image with url
   
   typealias ImageCallback = (UIImage?)->()
   
   class func fetchImageWith(_ urlString: String, callback: @escaping ImageCallback) {
      OperationQueue().addOperation {
         
         guard let url = URL(string: urlString) else { callback(nil); return }
         
         if let data = try? Data(contentsOf: url) { //using try? instead of using do, try, catch
            
            let image = UIImage(data: data)
            
            OperationQueue.main.addOperation {
               callback(image)
            }
         } else {
         }
         
         OperationQueue.main.addOperation {
            callback(nil)
         }
      }
   }
}


extension UIResponder {                  //parent class of all UIView.  UIViewController comes back and inherits from UIView
   static var identifier: String {     //static means applies to the type, not the instance
      return String(describing: self)
   }
}
