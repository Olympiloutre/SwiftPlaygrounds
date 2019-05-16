//
// DependencyInversionPrinciple.swift 
//
// Created by Qantas Dev on 17/5/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// https://marcosantadev.com/solid-principles-applied-swift/
//
//              The Dependency Inversion Principle (DIP)
//
// A. HIGH LEVEL MODULES SHOULD NOT DEPEND UPON LOW LEVEL MODULES. BOTH SHOULD DEPEND UPON ABSTRACTIONS.
//
// B. ABSTRACTIONS SHOULD NOT DEPEND UPON DETAILS. DETAILS SHOULD DEPEND UPON ABSTRACTIONS.
//

import Foundation


class WrongHandlerDip {
    
    let fm = WrongFilesystemManager()
    
    func handle(string: String) {
        fm.save(string: string)
    }
}

class WrongFilesystemManager {
    
    func save(string: String) {
        // Open a file
        // Save the string in this file
        // Close the file
    }
}

// FilesystemManager is the low-level module and it’s easy to reuse in other projects
// The problem is the high level module Handler, which is not reusable because is tightly coupled with FilesystemManager
// We should be able to reuse the high level module with different kind of storages like a database, Cloud and so on
// Correct:

class HandlerDip {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func handle(string: String) {
        storage.save(string: string)
    }
}

protocol Storage {
    func save(string: String)
}

class FilesystemManager: Storage {
    
    func save(string: String) {
        // Open a file in read-mode
        // Save the string in this file
        // Close the file
    }
}

class DatabaseManager: Storage {
    
    func save(string: String) {
        // Connect to the database
        // Execute the query to save the string in a table
        // Close the connection
    }
}

// We can solve this dependency using a protocol Storage. In this way, Handler can use this abstract protocol without caring of the kind of storage used

// This principle is very useful also for testing. You can easily use a stub class—which implements Storage—and test if handle calls the method save of the Storage object injected:

class StubStorage: Storage {
    
    var isSavedCalled = false
    
    func save(string: String) {
        isSavedCalled = true
    }
}

class HandlerTests {
    
    func test_Handle_IsSaveCalled() {
        let stubStorage = StubStorage()
        let handler = HandlerDip(storage: stubStorage)
        
        handler.handle(string: "test")
        
        // XCTAssertTrue(stubStorage.isSavedCalled)
    }
}

