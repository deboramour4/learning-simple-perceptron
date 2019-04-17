//
//  Perceptron.swift
//  perceptron
//
//  Created by Débora Oliveira on 17/04/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class Perceptron  {
    // taxa de aprendizado, para não pegar o x todo
    var n = 0.01
    
    //peso inicial
    var w = [Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1)] // w0 é o ultimo
    
    var input : [Pattern] = [Pattern]()
    
    var trainData : [Pattern] = [Pattern]()
    
    var testData : [Pattern] = [Pattern]()
    
    init(withInput input : [[Double]]) {
        for p in input {
            let pattern = Pattern(p)
            self.input.append(pattern)
        }
    }
    
    func train() -> [Double] {
        self.input.shuffle()
        
        let eightPercent = Double(input.count)*0.8
        
        for (index,pattern) in input.enumerated() {
            if (index <= Int(eightPercent)) {
                trainData.append(pattern)
            } else {
                testData.append(pattern)
            }
        }
        return train(data: &trainData, learningRate: n, epochsNumber: 100)
    }
    
    func predict(input: Pattern, w: [Double]) -> Double {
        // remove a classe resultado do array
        let pattern = input.feature
        
        var u = 0.0
        
        // calcula o u = w1x1 + w2x2 + w3x3 + w4x4 + w0x0
        for (index,attribute) in pattern.enumerated() {
            u += attribute * w[index]
        }
        
        if u >= 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func train(data : inout [Pattern], learningRate: Double, epochsNumber: Int) -> [Double]{
        var totalOK = 0.0
        
        for _ in 1...epochsNumber {
            totalOK = 0.0
            
            for feature in data {
                // predict o y
                let y = predict(input: feature, w: w)
                
                // calcula o erro
                let e = feature.target - y
                if e == 0 { totalOK += 1 }
                
                // n * e * x
                let a = multiVectorNumber(feature.feature, n)
                let ajust = multiVectorNumber(a, e)
                
                w = sumVectors(ajust, w)
            }
            data.shuffle()
            
            if (totalOK/Double(data.count) == 1.0) {
                print(totalOK/Double(data.count))
                return w
            }
        }
        return w
    }
    
    func multiVectorNumber(_ v: [Double], _ n : Double) -> [Double] {
        let result = v.map { (elem) -> Double in
            return elem * n
        }
        return result
    }
    
    func sumVectors(_ v1: [Double], _ v2 : [Double]) -> [Double] {
        if v1.count != v2.count {
            fatalError("counts differents")
        }
        var result:[Double] = []
        for i in 0..<v1.count {
            result.append(v1[i] + v2[i])
        }
        return result
    }
    
    // Aqui devemos computar a taxa de acertos para a base de teste
    func test(w: [Double]) -> Double {
        for pattern in testData {
            let desired = pattern.target
            let result = predict(input: pattern, w: w)
            
            print("d|y - \(desired) - \(result)")
        }
        return 0.0
    }
}
