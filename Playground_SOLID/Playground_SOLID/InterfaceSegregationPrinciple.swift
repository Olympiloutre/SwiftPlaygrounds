//
// InterfaceSegregationPrinciple.swift 
//
// Created by Qantas Dev on 17/5/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// https://marcosantadev.com/solid-principles-applied-swift/
//
//
//              The Interface Segregation Principle (ISP)
// CLIENTS SHOULD NOT BE FORCED TO DEPEND UPON INTERFACES THAT THEY DO NOT USE.
//


import Foundation

protocol WrongGestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

class WrongPoorButton: WrongGestureProtocol {
    func didTap() {
        // send tap action
    }
    
    func didDoubleTap() { }
    
    func didLongPress() { }
}

// Problem : PoorButton which needs just didTap. It must implement methods which it doesn’t need, breaking ISP !

// We can solve the problem using little protocols instead of a big one:

protocol TapProtocol {
    func didTap()
}

protocol DoubleTapProtocol {
    func didDoubleTap()
}

protocol LongPressProtocol {
    func didLongPress()
}

class SuperButton: TapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        // send tap action
    }
    
    func didDoubleTap() {
        // send double tap action
    }
    
    func didLongPress() {
        // send long press action
    }
}

class PoorButton: TapProtocol {
    func didTap() {
        // send tap action
    }
}


// MARK:- Example with Fat Class

protocol Playable {
    var title: String { get }
    var url: String { get }
    var duration: Int { get }
}

class Video: Playable {
    var title: String = "My Video"
    var description: String = "This is a beautiful video"
    var author: String = "Marco Santarossa"
    var url: String = "https://marcosantadev.com/my_video"
    var duration: Int = 60
    var created: Date = Date()
    var update: Date = Date()
}

// We pass "Playable" not 'Video' because we dont meed all the infos
// func play(video: Video) {
func play(video: Playable) {
    // load the player UI
    // load the content at video.url
    // add video.title to the player UI title
    // update the player scrubber with video.duration
}


// This approach is very useful also for the UNIT TEST. We can create a stub class which implements the protocol Playable:

class StubPlayable: Playable {
    private(set) var isTitleRead = false
    
    var title: String {
        self.isTitleRead = true
        return "My Video"
    }
    
    var duration = 60
    var url: String = "https://marcosantadev.com/my_video"
}

func test_Play_IsUrlRead() {
    let stub = StubPlayable()
    
    play(video: stub)
    
   // XCTAssertTrue(stub.isTitleRead)
}
