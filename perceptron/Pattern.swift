//
//  Pattern.swift
//  perceptron
//
//  Created by Débora Oliveira on 17/04/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class Pattern {
    //bigpicturezação
    var feature = [Double]()
    var target = 0.0
    
    init(_ input : [Double]) {
        //getting all ys
        self.target = input.last!
        
        //getting all x
        self.feature = Array(input.dropLast())
        self.feature.append(-1)
    }
}
