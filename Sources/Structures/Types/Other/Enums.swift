//
//  enums.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/7/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// Provides details on natural language tokens used in the knowledge graph

public enum Token {
    case isA, hasA, occupation, worksAt, livesAt, population, creates, weather, unknown
}


/// Governs types card game moves (deck of cards)

enum Turn {
    case match, nomatch, draw, hit, hold
}

struct Game {
    struct Hearts {
        enum Turn {
            case match, nomatch, draw
        }
    }
    struct BlackJack {
        enum Turn {
            case hit, hold
        }
    }
}


/**
The type of blockchain `Exchange`. While both peers and miners participate in the blockchain network, only peers are granted the ability to exchange funds with others.
 */

public enum BTransType{
    case bank
    case reward
    case peer
}


/**
 Recusive enum used to help build example Algorithm `models`.
 */

indirect enum Algorithm<T> {
    
    case Empty
    case Elements(Array<T>)
    case InsertionSort(Algorithm<T>)
    case BubbleSort(Algorithm<T>)
    case SelectionSort(Algorithm<T>)
    
}


//use for decision tree modeling
enum LearningType {
    
    case Feature
    case Label
}

//used for generic heap data structure processing
public enum HeapType {
    
    case Min
    case Max
}


//used for unit test cases
enum SortOrder {
    
    case Ascending
    case Descending
}


//used for generic processing
enum Result {
    
    case Success
    case Collision
    case NotFound
    case NotSupported
    case Fail
}


