//
// SingleResponsibilityPrinciple.swift 
//
// Created by Qantas Dev on 16/5/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// https://marcosantadev.com/solid-principles-applied-swift/
//
//          The Single Responsibility Principle (SRP)
//
// THERE SHOULD NEVER BE MORE THAN ONE REASON FOR A CLASS TO CHANGE.
//

import Foundation



class WrongHandler {
    
    func handle() {
        let data = requestDataToAPI()
        let array = parse(data: data)
        saveToDB(array: array)
    }
    
    private func requestDataToAPI() -> Data? {
        // send API request and wait the response
        return nil
    }
    
    private func parse(data: Data?) -> [String]? {
        // parse the data and create the array
        return nil
    }
    
    private func saveToDB(array: [String]?) {
        // save the array in a database (CoreData/Realm/...)
    }
}

// Handler retrieves the data from the API (1), parses the API response, creating an array of String, (2) and saves the array in a database (3).
// -> Too many responsibilities for a class
//              CORRECT WAY

class Handler {
    
    let apiHandler: APIHandler
    let parseHandler: ParseHandler
    let dbHandler: DBHandler
    
    init(apiHandler: APIHandler, parseHandler: ParseHandler, dbHandler: DBHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.dbHandler = dbHandler
    }
    
    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parse(data: data)
        dbHandler.saveToDB(array: array)
    }
}

class APIHandler {
    
    func requestDataToAPI() -> Data? {
        // send API request and wait the response
        return nil
    }
}

class ParseHandler {
    
    func parse(data: Data?) -> [String]? {
        // parse the data and create the array
        return nil
    }
}

class DBHandler {
    
    func saveToDB(array: [String]?) {
        // save the array in a database (CoreData/Realm/...)
    }
}

// This principle helps you to keep your classes as clean as possible. Moreover, in the first example you couldn’t test requestDataToAPI, parse and saveToDB directly, since those were private methods. After the refactor, you can easily do it testing APIHandler, ParseHandler and DBHandler.
