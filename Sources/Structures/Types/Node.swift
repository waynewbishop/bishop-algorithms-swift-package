//
//  Node.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/2/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Generic node used for stacks, queues and hash tables.
 - Important: Conformance to `Identifiable` required for used as model in SwiftUI.
 */

class Node<T> : Identifiable {
    var id: UUID = UUID()
    var tvalue: T?
    var next: Node?
}


