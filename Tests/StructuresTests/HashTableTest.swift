//
//  HashTableTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop
//  Copyright © 2025 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


class HashTableTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    // MARK: - Basic Operations

    func testInsertAndRetrieve() {
        let table = HashTable<String, Int>()

        let result = table.insert("score", value: 100)
        XCTAssertEqual(result, .success, "Initial insert should succeed")
        XCTAssertEqual(table.getValue(for: "score"), 100, "Should retrieve inserted value")
        XCTAssertEqual(table.count, 1, "Count should be 1")
    }

    func testUpdateExistingKey() {
        let table = HashTable<String, Int>()

        table.insert("score", value: 100)
        let updateResult = table.insert("score", value: 200)

        XCTAssertEqual(updateResult, .updated, "Update should return .updated")
        XCTAssertEqual(table.getValue(for: "score"), 200, "Value should be updated")
        XCTAssertEqual(table.count, 1, "Count should remain 1 after update")
    }

    func testRemoveKey() {
        let table = HashTable<String, Int>()

        table.insert("score", value: 100)
        let removedValue = table.remove("score")

        XCTAssertEqual(removedValue, 100, "Should return removed value")
        XCTAssertNil(table.getValue(for: "score"), "Value should be nil after removal")
        XCTAssertEqual(table.count, 0, "Count should be 0 after removal")
    }

    func testContainsKey() {
        let table = HashTable<String, Int>()

        table.insert("score", value: 100)

        XCTAssertTrue(table.contains("score"), "Should contain inserted key")
        XCTAssertFalse(table.contains("missing"), "Should not contain non-existent key")
    }

    // MARK: - Collision Handling

    func testCollisionResolution() {
        let table = HashTable<String, String>(capacity: 4) // Small capacity to force collisions

        // Insert multiple items
        table.insert("apple", value: "fruit")
        table.insert("banana", value: "fruit")
        table.insert("carrot", value: "vegetable")
        table.insert("date", value: "fruit")

        // All values should be retrievable despite collisions
        XCTAssertEqual(table.getValue(for: "apple"), "fruit")
        XCTAssertEqual(table.getValue(for: "banana"), "fruit")
        XCTAssertEqual(table.getValue(for: "carrot"), "vegetable")
        XCTAssertEqual(table.getValue(for: "date"), "fruit")
        XCTAssertEqual(table.count, 4, "All items should be stored")
    }

    func testChainTraversal() {
        let table = HashTable<Int, String>(capacity: 4)

        // Insert items that will likely collide
        for i in 0..<10 {
            table.insert(i, value: "value\(i)")
        }

        // Verify all items can be retrieved
        for i in 0..<10 {
            XCTAssertEqual(table.getValue(for: i), "value\(i)", "Should retrieve value for key \(i)")
        }

        XCTAssertEqual(table.count, 10, "Should have 10 items")
    }

    func testRemoveFromChain() {
        let table = HashTable<Int, String>(capacity: 4)

        // Create a collision chain
        table.insert(1, value: "first")
        table.insert(5, value: "second") // May collide with 1
        table.insert(9, value: "third")  // May collide with 1 and 5

        // Remove middle element
        let removed = table.remove(5)
        XCTAssertEqual(removed, "second")

        // Verify chain integrity
        XCTAssertEqual(table.getValue(for: 1), "first")
        XCTAssertNil(table.getValue(for: 5))
        XCTAssertEqual(table.getValue(for: 9), "third")
        XCTAssertEqual(table.count, 2)
    }

    // MARK: - Dynamic Resizing

    func testDynamicResizing() {
        let table = HashTable<Int, String>(capacity: 4)

        // Insert enough items to trigger resize (load factor = 0.75)
        // With capacity 4, inserting 4 items should trigger resize
        for i in 0..<4 {
            table.insert(i, value: "value\(i)")
        }

        // All items should still be retrievable after resize
        for i in 0..<4 {
            XCTAssertEqual(table.getValue(for: i), "value\(i)", "Should retrieve value for key \(i) after resize")
        }

        XCTAssertEqual(table.count, 4, "Count should be 4 after resize")
    }

    func testLoadFactorTriggersResize() {
        let table = HashTable<Int, String>(capacity: 16)

        // Insert items up to load factor threshold (0.75 * 16 = 12)
        for i in 0..<12 {
            table.insert(i, value: "value\(i)")
        }

        let loadFactorBeforeResize = table.loadFactor
        XCTAssertTrue(loadFactorBeforeResize <= 0.75, "Load factor should be at or below threshold")

        // Insert one more to trigger resize
        table.insert(100, value: "trigger")

        // Verify all items still accessible
        for i in 0..<12 {
            XCTAssertEqual(table.getValue(for: i), "value\(i)")
        }
        XCTAssertEqual(table.getValue(for: 100), "trigger")
    }

    // MARK: - Subscript Support

    func testSubscriptGetSet() {
        let table = HashTable<String, Int>()

        // Test subscript set
        table["score"] = 100
        XCTAssertEqual(table["score"], 100, "Subscript get should work")

        // Test subscript update
        table["score"] = 200
        XCTAssertEqual(table["score"], 200, "Subscript update should work")
    }

    func testSubscriptNilRemoval() {
        let table = HashTable<String, Int>()

        table["score"] = 100
        table["score"] = nil // Should remove the key

        XCTAssertNil(table["score"], "Setting nil should remove key")
        XCTAssertEqual(table.count, 0, "Count should be 0 after nil assignment")
    }

    // MARK: - Edge Cases

    func testEmptyHashTable() {
        let table = HashTable<String, Int>()

        XCTAssertTrue(table.isEmpty, "New hash table should be empty")
        XCTAssertEqual(table.count, 0, "Count should be 0")
        XCTAssertNil(table.getValue(for: "key"), "Should return nil for non-existent key")
        XCTAssertFalse(table.contains("key"), "Should not contain any keys")
    }

    func testSingleElement() {
        let table = HashTable<String, Int>()

        table.insert("single", value: 42)

        XCTAssertFalse(table.isEmpty, "Should not be empty")
        XCTAssertEqual(table.count, 1, "Count should be 1")
        XCTAssertEqual(table.getValue(for: "single"), 42)

        table.remove("single")

        XCTAssertTrue(table.isEmpty, "Should be empty after removing single element")
    }

    func testLargeDataset() {
        let table = HashTable<Int, String>()
        let itemCount = 1000

        // Insert large number of items
        for i in 0..<itemCount {
            table.insert(i, value: "value\(i)")
        }

        XCTAssertEqual(table.count, itemCount, "Should contain all items")

        // Verify random access
        XCTAssertEqual(table.getValue(for: 0), "value0")
        XCTAssertEqual(table.getValue(for: 500), "value500")
        XCTAssertEqual(table.getValue(for: 999), "value999")

        // Remove some items
        for i in stride(from: 0, to: itemCount, by: 2) {
            table.remove(i)
        }

        XCTAssertEqual(table.count, itemCount / 2, "Should have half the items after removal")
    }

    func testRemoveNonExistentKey() {
        let table = HashTable<String, Int>()

        table.insert("exists", value: 100)

        let removed = table.remove("missing")
        XCTAssertNil(removed, "Removing non-existent key should return nil")
        XCTAssertEqual(table.count, 1, "Count should remain unchanged")
    }

    // MARK: - Multiple Data Types

    func testIntegerKeys() {
        let table = HashTable<Int, String>()

        table.insert(1, value: "one")
        table.insert(2, value: "two")
        table.insert(3, value: "three")

        XCTAssertEqual(table.getValue(for: 1), "one")
        XCTAssertEqual(table.getValue(for: 2), "two")
        XCTAssertEqual(table.getValue(for: 3), "three")
    }

    func testDoubleValues() {
        let table = HashTable<String, Double>()

        table.insert("pi", value: 3.14159)
        table.insert("e", value: 2.71828)

        XCTAssertEqual(table.getValue(for: "pi"), 3.14159)
        XCTAssertEqual(table.getValue(for: "e"), 2.71828)
    }

    func testCustomHashableType() {
        // Custom type conforming to Hashable
        struct Point: Hashable {
            let x: Int
            let y: Int
        }

        let table = HashTable<Point, String>()

        let point1 = Point(x: 0, y: 0)
        let point2 = Point(x: 1, y: 1)

        table.insert(point1, value: "origin")
        table.insert(point2, value: "diagonal")

        XCTAssertEqual(table.getValue(for: point1), "origin")
        XCTAssertEqual(table.getValue(for: point2), "diagonal")
        XCTAssertEqual(table.count, 2)
    }

    // MARK: - Load Factor Monitoring

    func testLoadFactorCalculation() {
        let table = HashTable<Int, String>(capacity: 10)

        XCTAssertEqual(table.loadFactor, 0.0, "Load factor should be 0 for empty table")

        table.insert(1, value: "one")
        XCTAssertEqual(table.loadFactor, 0.1, accuracy: 0.01, "Load factor should be 0.1")

        for i in 2...5 {
            table.insert(i, value: "value\(i)")
        }

        XCTAssertEqual(table.loadFactor, 0.5, accuracy: 0.01, "Load factor should be 0.5")
    }

    // MARK: - Stress Testing

    func testMixedOperations() {
        let table = HashTable<String, Int>()

        // Mix of insert, update, remove operations
        table.insert("a", value: 1)
        table.insert("b", value: 2)
        table.insert("c", value: 3)

        table["b"] = 20 // Update via subscript
        table.remove("c")

        table.insert("d", value: 4)
        table.insert("e", value: 5)

        XCTAssertEqual(table.getValue(for: "a"), 1)
        XCTAssertEqual(table.getValue(for: "b"), 20)
        XCTAssertNil(table.getValue(for: "c"))
        XCTAssertEqual(table.getValue(for: "d"), 4)
        XCTAssertEqual(table.getValue(for: "e"), 5)
        XCTAssertEqual(table.count, 4)
    }
}
