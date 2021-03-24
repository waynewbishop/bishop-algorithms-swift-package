//
//  File.swift
//  
//
//  Created by Wayne Bishop on 3/22/21.
//

import Foundation

struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}


