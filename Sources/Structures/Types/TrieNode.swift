// Copyright 2026 Wayne W Bishop. All rights reserved.
//
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.

import Foundation

/// A node class for building trie (prefix tree) data structures
///
/// This class represents a single node in a trie, which stores strings character-by-character
/// in a tree structure. Each node holds one character (or character sequence) and maintains
/// an array of child nodes representing possible next characters.
///
/// Tries excel at prefix-based operations like autocomplete, spell checking, and dictionary
/// lookups. The key insight: words sharing common prefixes share nodes in the tree, making
/// storage and search efficient for large dictionaries.
///
/// Example trie structure for words ["app", "apple", "apply"]:
/// ```
///       (root)
///         |
///        "a"
///         |
///        "p"
///         |
///        "p" (isFinal: true for "app")
///       /   \
///     "l"   (empty)
///      |
///     "e" (isFinal: true for "apple")
///      |
///     "y" (isFinal: true for "apply")
/// ```
///
/// - Note: This implementation stores character sequences in `tvalue` rather than single
///         characters, providing flexibility for various trie variants.
public class TrieNode {

    /// The character or character sequence stored at this node
    ///
    /// Represents the portion of the string stored at this level. For example, in a word
    /// "apple", different nodes might store "a", "p", "p", "l", "e" at successive levels.
    var tvalue: String?

    /// Array of child nodes representing possible next characters
    ///
    /// Each child represents a different continuation from this node. For a node storing
    /// "app", children might include nodes for "l" (to form "apple") and other continuations.
    var children: Array<TrieNode>

    /// Indicates whether this node marks the end of a complete word
    ///
    /// When `true`, the path from root to this node forms a valid word in the dictionary.
    /// For example, in a trie containing both "app" and "apple", the node after the second
    /// "p" would have `isFinal = true` (for "app"), even though it also has children.
    var isFinal: Bool

    /// The depth of this node in the trie (distance from root)
    ///
    /// Root has level 0. Each child has level = parent.level + 1. Useful for tracking
    /// position within words during traversal and debugging.
    var level: Int

    /// Creates a new empty trie node
    ///
    /// Initializes a node with no value, no children, not marking a word end, at level 0.
    /// These properties are set appropriately when the node is inserted into a trie.
  public init() {
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }

}
