//
//  String.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// Extension on String providing custom protocol conformance and utility methods
///
/// This extension adds hash table support (via `Indexable` protocol) plus various string
/// manipulation utilities commonly needed in algorithm implementations and interview questions.
///
/// **Key Features:**
/// - **Hash table integration**: ASCII representation for custom hash functions
/// - **String manipulation**: Substring, reverse, whitespace removal
/// - **Uniqueness checking**: Determine if all characters are unique
/// - **Date conversion**: Parse strings to Date objects
extension String: Indexable {

    /// Computes an integer hash value by summing Unicode scalar values
    ///
    /// Required by the `Indexable` protocol for use with `HashSet` and `HashChain`.
    /// Converts the string to an integer by summing the Unicode values of all characters.
    ///
    /// This enables strings to be stored in custom hash tables that require the `Indexable`
    /// protocol (for educational purposes). Production code should use Swift's built-in
    /// `Hashable` protocol instead.
    ///
    /// - Returns: Sum of all Unicode scalar values in the string
    ///
    /// - Complexity: O(n) where n is the string length
   public var asciiRepresentation: Int {
        var divisor: Int = 0

        for item in self.unicodeScalars {
         divisor += Int(item.value)
        }

        return divisor
    }



    /// The number of characters in the string
    ///
    /// Convenience property wrapping `count` for clearer intent in string algorithms.
    ///
    /// - Complexity: O(1) - Swift strings cache their count
    var length: Int {
       return self.count
    }



    /// Checks whether all characters in the string are unique (no duplicates)
    ///
    /// This method implements the classic "unique characters" algorithm using an array
    /// as a hash table. It's a common interview question demonstrating hash-based lookups.
    ///
    /// **Algorithm:**
    /// 1. Creates boolean array of size 128 (ASCII character range)
    /// 2. For each character, checks if its Unicode value was seen before
    /// 3. Returns false if duplicate found, otherwise marks character as seen
    ///
    /// **Edge Case:**
    /// Strings longer than 128 characters automatically contain duplicates (pigeonhole
    /// principle), so we return false immediately.
    ///
    /// - Returns: `true` if all characters are unique, `false` if any character repeats
    ///
    /// - Complexity: O(n) where n is string length, O(1) space (fixed 128-element array)
    func isStringUnique() -> Bool {

        //evaluate trival case
        guard self.count < 128 else {
            return false
        }


        //match unicode representation - O(n)
        var list = Array<Bool?>(repeatElement(nil, count: 128))

        for scalar in self.unicodeScalars {
            let unicode = Int(scalar.value)

            if list[unicode] != nil {
                return false
            }
            list[unicode] = true
        }

        return true
    }




    /// Converts the string to a Date object using MM-dd-yyyy format
    ///
    /// This utility parses date strings in the format "MM-dd-yyyy" (e.g., "12-25-2023").
    /// Uses `DateFormatter` with US POSIX locale for consistent parsing.
    ///
    /// - Returns: A Date object if the string matches the expected format, `nil` otherwise
    ///
    /// - Complexity: O(1) for fixed-format date parsing
    var datevalue: Date? {

        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "MM-dd-yyyy"
        stringFormatter.locale = Locale(identifier: "en_US_POSIX")

        //check for correct date format
        if let d = stringFormatter.date(from: self) {
            return Date(timeInterval: 0, since: d)
        }
        else {
            return nil
        }

    }


    /// Returns a substring containing the first n characters
    ///
    /// Extracts characters from the start of the string up to (but not including) the
    /// specified index. Useful for prefix operations in trie algorithms.
    ///
    /// - Parameter to: The number of characters to extract
    ///
    /// - Returns: Substring containing characters from index 0 to `to-1`
    ///
    /// - Complexity: O(n) where n is the substring length
    func substring(to: Int) -> String {

        //define the range
        let range = self.index(self.startIndex, offsetBy: to)

        return String(self[..<range])
    }


    /// Replaces all occurrences of a substring with a replacement string
    ///
    /// Wrapper around Swift's `replacingOccurrences(of:with:)` providing simpler naming.
    ///
    /// - Parameters:
    ///   - element: The substring to replace
    ///   - replacement: The string to replace it with
    ///
    /// - Returns: A new string with all replacements made
    ///
    /// - Complexity: O(n) where n is the string length
    func replace(element:String, replacement:String) -> String {
        return self.replacingOccurrences(of: element, with: replacement)
    }


    /// Removes all whitespace characters from the string
    ///
    /// This method removes all space characters, useful for string comparison and
    /// normalization in algorithms that should ignore whitespace.
    ///
    /// - Returns: A new string with all spaces removed
    ///
    /// - Complexity: O(n) where n is the string length
    func removingWhitespace() -> String {
        return self.replace(element: " ", replacement: "")
    }


    /// Creates a unique identifier by combining the string with a date's hash value
    ///
    /// Generates a pseudo-unique identifier by concatenating the string with a date
    /// representation and returning the hash value of the result.
    ///
    /// - Parameter date: The date to combine with this string
    ///
    /// - Returns: String representation of the combined hash value
    ///
    /// - Complexity: O(n) where n is the combined string length
    func identifierWithDate(date: Date) -> String {

        let cleartext = self + String(describing: date)
        return String(cleartext.hashValue)
    }



    /// Reverses the string using a stack (LIFO demonstration)
    ///
    /// This method demonstrates string reversal using a stack data structure. Each
    /// character is pushed onto the stack, then popped off in reverse order (LIFO).
    ///
    /// **Educational Purpose:**
    /// Shows practical stack usage - characters go in forward order, come out reversed.
    /// This is less efficient than the native `reversed()` method but demonstrates
    /// stack mechanics clearly.
    ///
    /// - Returns: The reversed string
    ///
    /// - Complexity: O(n) time, O(n) space for the stack
    func reverseWithStack() -> String  {

        let items = Stack<Character>()
        var results = ""


        for s in self {
            items.push(s)
        }


        while items.top.tvalue != nil {

            if let character = items.peek() {
                results += String(character)
            }

            //remove item from stack..
            items.pop()

        }


        return results

    }


    /// Reverses the string in-place using two-pointer technique
    ///
    /// This method implements the classic string reversal algorithm using two pointers
    /// that swap characters while converging from both ends. Common interview question
    /// demonstrating in-place array manipulation.
    ///
    /// **Algorithm:**
    /// 1. Convert string to character array
    /// 2. Use front index (0) and back index (length-1)
    /// 3. Swap characters at these indices
    /// 4. Move indices toward center until they meet
    ///
    /// **Note:**
    /// While Swift provides `characters.reversed()`, this implementation demonstrates
    /// the algorithmic approach commonly asked in interviews.
    ///
    /// - Returns: The reversed string
    ///
    /// - Complexity: O(n) time, O(n) space (must create character array)
    func reverse() -> String {

        //convert to array
        var characters = Array(self)

        var findex: Int = characters.startIndex
        var bindex: Int = characters.endIndex - 1


        while findex < bindex {

            characters.swapAt(findex, bindex)


            //update values
            findex += 1
            bindex -= 1


        } //end while


        return String(characters)

    }


}
