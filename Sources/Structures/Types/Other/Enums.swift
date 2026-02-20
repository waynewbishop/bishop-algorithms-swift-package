//
//  enums.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/7/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// Natural language relationship tokens for knowledge graph modeling
///
/// The `Token` enum defines semantic relationship types used in knowledge graph
/// implementations. Each case represents a different kind of connection between entities
/// in a graph-based knowledge representation system.
///
/// **Purpose:**
/// Knowledge graphs model real-world information by connecting entities through typed
/// relationships. These tokens enable structured querying like "What is X?" (isA),
/// "Where does X work?" (worksAt), etc.
///
/// **Example Usage:**
/// ```swift
/// // Model relationships in a knowledge graph
/// let relationship1 = Token.occupation  // "John is a Teacher"
/// let relationship2 = Token.worksAt     // "John works at MIT"
/// let relationship3 = Token.livesAt     // "John lives at Boston"
/// ```
///
/// - Note: This is typically used with graph-based data structures to create semantic
///         networks representing real-world knowledge.
public enum Token {
    /// Identity relationship: "X is a Y" (e.g., "Dog is a Mammal")
    case isA

    /// Possession relationship: "X has a Y" (e.g., "Car has a Engine")
    case hasA

    /// Job title relationship: "X's occupation is Y"
    case occupation

    /// Employment location: "X works at Y"
    case worksAt

    /// Residence location: "X lives at Y"
    case livesAt

    /// Population count: "X has population Y"
    case population

    /// Creation relationship: "X creates Y"
    case creates

    /// Weather condition: "X has weather Y"
    case weather

    /// Unknown or unrecognized relationship type
    case unknown
}


/// Card game move types for generic game modeling
///
/// The `Turn` enum defines possible moves in card games, used as a parent type for
/// game-specific move enums. This provides a general vocabulary of card game actions.
///
/// - Note: Game-specific variants are defined in nested `Game` struct types.
enum Turn {
    /// Cards match (successful pairing)
    case match

    /// Cards don't match (failed pairing)
    case nomatch

    /// Draw a card from the deck
    case draw

    /// Request another card (Blackjack)
    case hit

    /// Keep current hand without drawing (Blackjack)
    case hold
}

/// Namespace for game-specific turn types
///
/// The `Game` struct provides nested types for different card games, each with
/// their own set of valid moves. This demonstrates type namespacing and scoped enums.
struct Game {

    /// Hearts card game moves
    struct Hearts {

        /// Valid turns in Hearts
        enum Turn {
            /// Cards match
            case match

            /// Cards don't match
            case nomatch

            /// Draw from deck
            case draw
        }
    }

    /// Blackjack card game moves
    struct BlackJack {

        /// Valid turns in Blackjack
        enum Turn {
            /// Request another card
            case hit

            /// Keep current hand
            case hold
        }
    }
}


/// Blockchain transaction types for cryptocurrency exchange modeling
///
/// The `BTransType` enum categorizes different kinds of blockchain transactions in a
/// cryptocurrency network. This distinguishes between banking operations, mining rewards,
/// and peer-to-peer transfers.
///
/// **Purpose:**
/// In blockchain networks, different transaction types have different validation rules
/// and permissions. While both peers and miners participate in the blockchain network,
/// only peers are granted the ability to exchange funds with others.
///
/// **Transaction Categories:**
/// - **Bank**: Institutional or centralized banking operations
/// - **Reward**: Mining rewards distributed to blockchain validators
/// - **Peer**: Direct peer-to-peer fund transfers between users
///
/// - Note: This is used in blockchain algorithm implementations to model transaction
///         authorization and validation rules.
public enum BTransType{
    /// Banking or institutional transaction
    case bank

    /// Mining reward distribution to validators
    case reward

    /// Peer-to-peer fund transfer between users
    case peer
}


/// Recursive enum for composing algorithm pipelines
///
/// The `Algorithm` enum demonstrates Swift's `indirect` enum feature by creating a
/// recursive type that can represent algorithm composition and chaining. Each case wraps
/// another `Algorithm<T>`, enabling functional-style algorithm pipelines.
///
/// **Purpose:**
/// This enum shows how to model algorithm transformations as a recursive data structure,
/// similar to how functional programming languages represent computation pipelines.
///
/// **Example Usage:**
/// ```swift
/// // Build an algorithm pipeline
/// let pipeline: Algorithm<Int> = .insertionSort(
///     .bubbleSort(
///         .elements([5, 2, 8, 1])
///     )
/// )
/// ```
///
/// - Note: The `indirect` keyword is required because enum cases contain references to
///         the enum type itself, creating a recursive structure that needs heap allocation.
indirect enum Algorithm<T> {
    /// Empty algorithm with no data
    case empty

    /// Algorithm containing input elements
    case elements(Array<T>)

    /// Insertion sort applied to another algorithm's output
    case insertionSort(Algorithm<T>)

    /// Bubble sort applied to another algorithm's output
    case bubbleSort(Algorithm<T>)

    /// Selection sort applied to another algorithm's output
    case selectionSort(Algorithm<T>)
}


/// Data type classification for decision tree machine learning
///
/// The `LearningType` enum distinguishes between features (input variables) and labels
/// (output/target variables) in supervised machine learning algorithms like decision trees.
///
/// **Purpose:**
/// Decision trees split data based on features to predict labels. This enum tags data
/// points to indicate their role in the learning process.
///
/// - Note: Used in decision tree implementations for machine learning algorithms.
enum LearningType {
    /// Input variable used for prediction
    case feature

    /// Output variable being predicted
    case label
}

/// Heap ordering constraint for priority queue implementations
///
/// The `HeapType` enum specifies whether a heap maintains min-heap or max-heap ordering.
/// This determines whether the root node contains the minimum or maximum element.
///
/// **Heap Properties:**
/// - **Min-heap**: Parent ≤ children (smallest element at root) - useful for priority queues
/// - **Max-heap**: Parent ≥ children (largest element at root) - useful for finding maximums
///
/// **Example Usage:**
/// ```swift
/// let minHeap = Heap<Int>(type: .min)  // Root is smallest
/// let maxHeap = Heap<Int>(type: .max)  // Root is largest
/// ```
///
/// - Note: Used by `Heap<T>` to configure heap ordering during initialization.
public enum HeapType {
    /// Min-heap: parent ≤ children, smallest element at root
    case min

    /// Max-heap: parent ≥ children, largest element at root
    case max
}


/// Sort order direction for test validation
///
/// The `SortOrder` enum specifies the expected ordering direction when validating
/// sorting algorithm outputs in unit tests.
///
/// - Note: Used in test cases to verify sorting algorithms produce correct ascending
///         or descending order.
enum SortOrder {
    /// Ascending order (smallest to largest)
    case ascending

    /// Descending order (largest to smallest)
    case descending
}


/// Operation result status for hash table and data structure operations
///
/// The `Result` enum represents the outcome of data structure operations, particularly
/// for hash tables where collisions and lookup failures are common.
///
/// **Common Use Cases:**
/// - Hash table insertions (success vs collision)
/// - Lookups (found vs notFound)
/// - Unsupported operations (notSupported)
/// - General failures (fail)
///
/// **Example:**
/// ```swift
/// func insert(key: String, value: Int) -> Result {
///     if bucketIsFull {
///         return .collision
///     }
///     // ...perform insertion
///     return .success
/// }
/// ```
///
/// - Note: Used throughout data structure implementations to communicate operation outcomes.
enum Result {
    /// Operation completed successfully
    case success

    /// Hash collision occurred during insertion
    case collision

    /// Element not found during lookup
    case notFound

    /// Operation not supported by this implementation
    case notSupported

    /// Operation failed for unspecified reason
    case fail
}


