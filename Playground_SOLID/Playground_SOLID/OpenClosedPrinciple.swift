//
// OpenClosedPrinciple.swift 
//
// Created by Qantas Dev on 16/5/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// https://marcosantadev.com/solid-principles-applied-swift/
//
//              The Open-Closed Principle (OCP)
// SOFTWARE ENTITIES (CLASSES, MODULES, FUNCTIONS, ETC.) SHOULD BE OPEN FOR EXTENSION, BUT CLOSED FOR MODIFICATION.
//
// Open for extension: You should be able to extend or change the behaviours of a class without efforts.
// Closed for modification: You must extend a class without changing the implementation.
//

import Foundation

class WrongLogger {
    
    func printData() {
        
        // * code duplication
        // 1
        let cars = [
            WrongCar(name: "Batmobile", color: "Black"),
            WrongCar(name: "SuperCar", color: "Gold"),
            WrongCar(name: "FamilyCar", color: "Grey")
        ]
        
        cars.forEach { car in
            print(car.printDetails())
        }
        
        // 2
        let bicycles = [
            WrongBicycle(type: "BMX"),
            WrongBicycle(type: "Tandem")
        ]
        
        bicycles.forEach { bicycles in
            print(bicycles.printDetails())
        }
    }
}

class WrongCar {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class WrongBicycle {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func printDetails() -> String {
        return "I'm a \(type)"
    }
}

// If you want to add the possibility to print also the details of a new class, we should change the implementation of printData *every time* we want to log a new class—breaking OCP:

// CORRECT WAY
// solved via protocol

protocol Printable {
    func printDetails() -> String
}

class Logger {
    
    func printData() {
        let cars: [Printable] = [
            Car(name: "Batmobile", color: "Black"),
            Car(name: "SuperCar", color: "Gold"),
            Car(name: "FamilyCar", color: "Grey"),
            Bicycle(type: "BMX"),
            Bicycle(type: "Tandem")
        ]
        
        cars.forEach { car in
            print(car.printDetails())
        }
    }
}

class Car: Printable {
    let name: String
    let color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}

class Bicycle: Printable {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func printDetails() -> String {
        return "I'm a \(type)"
    }
}



