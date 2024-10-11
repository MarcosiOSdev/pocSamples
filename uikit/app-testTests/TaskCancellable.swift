//
//  TaskCancellable.swift
//  app-testTests
//
//  Created by Marcos Felipe Souza Pinto on 30/05/23.
//

import XCTest

final class TaskCancellable: XCTestCase {
    
    func testCancellable() async throws {
        let business = Business()
        let expect = expectation(description: "Test")
        
        let task = Task {
            let result = await business.get()
            expect.fulfill()
            XCTAssertEqual(result, "cancel")
        }
        task.cancel()
        _ = await task.result
        wait(for: [expect], timeout: 3)
        
    }
}

func wrappperTask(with: @escaping () async -> String) async -> String {
    let result = await with()
    return result
}

class Business {
    
    var task: Task<String, Never>?
    
    func get() async -> String {
        task = Task {
            let say = "Hello"
            if Task.isCancelled { return "cancel" }
            return say
        }
        let resulTak = await task?.result
        return (try? resulTak?.get()) ?? "error"
    }
    
    
    func getWithCancellable() async -> String {
        return await withTaskCancellationHandler(operation: {
            await withCheckedContinuation { continuation in
                continuation.resume(returning: "PROBANDO")
            }
        }, onCancel: {
            self.cancel()
        })

    }
    
    func cancel() {
        task?.cancel()
    }
}
