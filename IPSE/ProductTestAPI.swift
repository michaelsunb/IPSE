//
//  ViewController.swift
//  TakeAway
//
//  Created by Rodney Cocker on 19/04/2015.
//  Copyright (c) 2015 RMIT. All rights reserved.
//

import Foundation
import UIKit

class ProductTestAPI
{
	var image: UIImageView!
	var titleOfMovie:String?
	var movieSubTitle:String?
	var movieId:String?
    
    
    /**
    * Reference to thread safe singleton at bottom on page
    * http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    */
    class var sharedInstance: ProductTestAPI {
        struct Static {
            static var instance: ProductTestAPI?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ProductTestAPI()
        }
        
        return Static.instance!
    }
    
    
    
    // Sets up a networking session
	let session = NSURLSession.sharedSession()
	
	// Constants for building various url requests to the service
	let BASE_URL:String = "https://api.themoviedb.org/3/"
	let SEARCH_MOVIE:String = "search/movie"
	let MOVIE_DETAILS:String = "movie/"
	let IMAGES_LOCATION = "images"
	let API_KEY :String = "?api_key=5773cfe9c65c621911d8601f1a3d08c2"
	var ID_LENGTH:Int  = 0
    
    init() {
        
    }
	
    func getMovie(title:String)->UIImage? {
		let methodArguments = [
			"query": title
		]

		var movieTitle:String  = escapedParameters(methodArguments)

		let findMovieId = BASE_URL + SEARCH_MOVIE + API_KEY + "&" + movieTitle
		if let url = NSURL(string: findMovieId) {
			let request = NSURLRequest(URL: url)
			initialiseTaskForGettingData(request, element: "results")
		}
        
        if let imageView:UIImageView = self.image {
            return imageView.image
        }
        
        return nil
	}
	
	func initialiseTaskForGettingData(request: NSURLRequest, element:String)
	{
		let task = session.dataTaskWithRequest(request) {data, response, downloadError in
			if let error = downloadError {
				
			} else {
				var parsingError: NSError? = nil
				let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
				
				// Log the results to the console, so you can see what is being sent back from the service.
				println(parsedResult)
				
				// Extract an element from the data as an array, if your JSON response returns a dictionary
				// you will need to convert it to an NSDictionary
				if let moviesArray = parsedResult.valueForKey(element) as? NSArray
				{
					// Retrieve item from the array that represents in this case a particular movie
					let movieIndex = Int(arc4random_uniform(UInt32(moviesArray.count)))
					
					// Normally, here I would create the NSDictionary from the data in the array,
					// however, in the case of this service, the JSON array is not properly formed
					// some attributes are not enclosed in quotes.
					// In particular, I am interested in the 'id' value, but because it is not enclosed
					// in quotes, I can't just convert it to an NSDictionary because the unquoted attributes
					// will be skipped and not added to the Dictionary.
					let imageDictionary = moviesArray[movieIndex] as? NSDictionary
					
					// Instead, this function passes the JSON array as a string
					// I then search the string for the data I am interested in.
					let stringRepresentationOfJsonArray = self.JSONStringify(parsedResult, prettyPrinted: true)
					
					// Find start of id
					var startOfIdIndex = stringRepresentationOfJsonArray.indexOf("id") + 6
					
					var endOfId = stringRepresentationOfJsonArray.indexOf("adult");
					
					var difference = endOfId-startOfIdIndex-4-2;
					
					self.ID_LENGTH = difference
					
					// Get id
					var movieId:String = stringRepresentationOfJsonArray.substringWithRange(startOfIdIndex..<startOfIdIndex + self.ID_LENGTH)
					
					var newId : String = movieId.stringByReplacingOccurrencesOfString(",", withString: "", options: nil, range: nil);
					
					// Get a random image for the image id
					self.getRandomMovieImage(newId)
				}
			}
		}
		// Execute the task
		task.resume()
	}
	
	func getRandomMovieImage(movieId: String)
	{
		// First request to the service is the title of the image, so that we
		// can retrieve the movie id for subsequent requests
		let getRandomImage : String = BASE_URL + MOVIE_DETAILS + movieId + "/images" + API_KEY
		let newString : String = getRandomImage.stringByReplacingOccurrencesOfString("[\\s\\;\\'\\&\n]", withString: "", options: .RegularExpressionSearch, range: nil);
		
		println(newString);
		
    if let url = NSURL(string: newString) {
      let request = NSURLRequest(URL: url)
      
      // Initialise the task for getting the data
      let task = session.dataTaskWithRequest(request) {data, response, downloadError in
        if let error = downloadError
        {
        }
        else
        {
          // Parse the data received from the service
          var parsingError: NSError? = nil
          let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
          
          // Extract an element from the data as an array, if your JSON response returns a dictionary
          // you will need to convert it to an NSDictionary
          if let photosArray = parsedResult.valueForKey("backdrops") as? NSArray {
            
            if(photosArray.count != 0) {
              // Grab a random image from the array
              let randomPhotoIndex = Int(arc4random_uniform(UInt32(photosArray.count)))
              
              // This time, I can convert to an NSDictionary, even though it is illformed
              // the attribute I am after is quoted and so I can access it from the dictionary
              let imageDictionary = photosArray[randomPhotoIndex] as? NSDictionary
              
              // Extract a random image url from the dictionary
              let imageUrlString = imageDictionary?.valueForKey("file_path") as? NSString
              
              // Build the full url of the image
              let baseImageUrlString = "https://image.tmdb.org/t/p/original"
              let fullImageUrlString = baseImageUrlString + imageUrlString!
              let imageURL = NSURL(string: fullImageUrlString)
              
              println(fullImageUrlString);
              
              // If the image exists at the url specified set the UIImageView to reference that image
              if let imageData = NSData(contentsOfURL: imageURL!) {
                dispatch_async(dispatch_get_main_queue(), {
                  self.image.image = UIImage(data: imageData)
                  
                })
              }
              else
              {
                println("Image does not exist at \(imageURL)")
              }
            }
          }
        }
      }
      // Execute the task
      task.resume()
    }
	}
	
	// https://
	// medium.com/swift-programming/4-json-in-swift-144bf5f88ce4
	func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
		var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
		if NSJSONSerialization.isValidJSONObject(value) {
			if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
				if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
					return string
				}
			}
		}
		return ""
	}
	
	func JSONParseArray(jsonString: String) -> [AnyObject] {
		if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
			if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
				return array
			}
		}
		return [AnyObject]()
	}
	
	/* Helper function: Given a dictionary of parameters, convert to a string for a url */
	/*    udacity.com/course/viewer#!/c-ud421/l-3561819198/m-3763008970  */
	func escapedParameters(parameters: [String : AnyObject]) -> String {
		
		var urlVars = [String]()
		
		for (key, value) in parameters {
			
			/* Make sure that it is a string value */
			let stringValue = "\(value)"
			
			/* Escape it */
			let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
			
			/* Append it */
			urlVars += [key + "=" + "\(escapedValue!)"]
		}
		
		return (!urlVars.isEmpty ? "" : "") + join("&", urlVars)
	}
}

/* stackoverflow.com/questions/28182441/swift-how-to-get-substring-from-start-to-last-index-of-character */
extension String {
	
	var length: Int {
		get {
			return countElements(self)
		}
	}
	
	func indexOf(target: String) -> Int {
		var range = self.rangeOfString(target)
		if let range = range {
			return distance(self.startIndex, range.startIndex)
		} else {
			return -1
		}
	}
	
	func indexOf(target: String, startIndex: Int) -> Int {
		var startRange = advance(self.startIndex, startIndex)
		var range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
		if let range = range {
			return distance(self.startIndex, range.startIndex)
		} else {
			return -1
		}
	}
	
	func lastIndexOf(target: String) -> Int {
		var index = -1
		var stepIndex = self.indexOf(target)
		while stepIndex > -1 {
			index = stepIndex
			if stepIndex + target.length < self.length {
				stepIndex = indexOf(target, startIndex: stepIndex + target.length)
			} else {
				stepIndex = -1
			}
		}
		return index
	}
	
	func substringWithRange(range:Range<Int>) -> String {
		let start = advance(self.startIndex, range.startIndex)
		let end = advance(self.startIndex, range.endIndex)
		return self.substringWithRange(start..<end)
	}
}




