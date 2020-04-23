//
//  ViewController.swift
//  CodeforceRatingApp
//
//  Created by Amit Biswas on 4/23/20.
//  Copyright © 2020 Amit Biswas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://codeforces.com/api/blogEntry.comments?blogEntryId=79"
        getData(from: url)
        
    }
    
    private func getData(from url: String) {
        
        let task =   URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data , error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            
            var result: JSONResponse?
            do {
                result = try JSONDecoder().decode(JSONResponse.self, from: data)
            }
            catch {
                print ("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.result.first!)
        })
        
        task.resume()
    }
    
    
}

struct JSONResponse: Codable {
    
    var status: String
    var result: [ResultModel]
    
}

struct ResultModel: Codable {
    
    var id: Int
    var creationTimeSeconds: Int
    var commentatorHandle: String
    var locale: String
    var text: String
    
}



