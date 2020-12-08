//: [Previous](@previous)

import Combine
import Fundation
import UIKit

let queue = OperationQueue()

let subscription = (1...10).publisher
  .receive(on: queue)
  .sink { value in
    print("Received \(value)")
    print("thread = \(Thread.current)")
  }

//: [Next](@next)
