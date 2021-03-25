
/**
   Stack algorithm. Provides a model

 - Complexity: O(1) - constant time average time for all operations.
 */

public struct SimpleStack <T> {

       var elements : [T] = [T]()

        public init() {
            //playground support
        }
        
        //the number of items
        var count: Int {
            return elements.count
        }
        
        public func peek() -> T? {
              return elements.last
          }
      
        public mutating func push(_ element: T) {
              elements.append(element)
          }

        public mutating func pop() -> T? {
              return elements.popLast()
          }

        //swap positions
        public mutating func swapAt(lhs: Int, rhs: Int) -> () {
            self.elements.swapAt(lhs, rhs)
        }
        
    }

