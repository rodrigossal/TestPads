//
//  PadSequence.swift
//  SuperPads
//
//  Created by Rodrigo Salles Stefani on 05/06/19.
//  Copyright © 2019 Rodrigo Salles Stefani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PadSequence {
    
    var color = [String]()
    
    init() {
        Alamofire.request("https://next-opala-storage.s3-sa-east-1.amazonaws.com/teste/example.json").responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value {
                    //                    print("JSON: \(json)") // serialized json response
                    let swiftyJson = JSON(json)
                    for item in swiftyJson.arrayValue{
                        print(item["color"].stringValue)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

