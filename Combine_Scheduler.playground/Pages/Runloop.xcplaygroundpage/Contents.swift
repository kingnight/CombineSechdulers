//: [Previous](@previous)

import Combine
import Foundation

var subscription = Set<AnyCancellable>()

let source = Timer
  .publish(every: 1.0, on: .main, in: .common)
  .autoconnect()
  .scan(0) { counter, _ in counter + 1 }
  
source
    //4
    .receive(on: DispatchQueue.global())
    //1
    .map{ value -> Int in
        print("1:\(Thread.current)")
        return value
    }
    // 2
    .receive(on: RunLoop.current)
    // 3
    .map{ value -> Int in
        print("2:\(Thread.current)")
        return value
    }
    .eraseToAnyPublisher()
    .sink { _ in
        //print(out)
    }
    .store(in: &subscription)

//: [Next](@next)
