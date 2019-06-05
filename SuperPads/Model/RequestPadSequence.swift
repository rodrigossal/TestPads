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

struct Pad {
    let color: String
    let pad: Int
    let time: TimeInterval
}

class RequestPadSequence {
    
    var sequence = [Pad]()
    
    init() {
        Alamofire.request("https://next-opala-storage.s3-sa-east-1.amazonaws.com/teste/example.json").responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value {
                    //                    print("JSON: \(json)") // serialized json response
                    let swiftyJson = JSON(json)
                    for item in swiftyJson.arrayValue{
                        self.sequence.append(Pad(color: item["color"].stringValue, pad: item["pad"].intValue, time: item["time"].doubleValue))
//                        print(self.sequence)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

