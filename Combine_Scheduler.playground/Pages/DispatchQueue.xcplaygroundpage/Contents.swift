//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

let serialQueue = DispatchQueue(label: "Serial queue")
let sourceQueue =  serialQueue//DispatchQueue.main

// 1
let source = PassthroughSubject<Void, Never>()

// 2
let subscription =  sourceQueue.schedule(after: sourceQueue.now,
                                        interval: .seconds(1)) {
  source.send()
}

source
    .map{ _ in
        print("1:\(Thread.current)")
    }
    .receive(on: serialQueue,options: DispatchQueue.SchedulerOptions(qos: .userInteractive))
    .map{ _ in
        print("2:\(Thread.current)")
    }
    .eraseToAnyPublisher()
    .sink(receiveValue: { _ in
        
    })
    .store(in: &subscriptions)

//: [Next](@next)
