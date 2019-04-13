//
//  MyGitHub.swift
//  Playground_JSON_decode
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//



import Foundation


struct MyGitHub: Codable { // 1 - Codable protocol is the one that helps for encode/decode
    
    // 2 - we won't use every entry there
    let name: String
    let location: String
    let followers: Int
    let avatarUrl: URL  // 3 - avatar_url is not CamelCase so we have to use CodingKeys
    let repos: Int      // 3 - idem
    let creation: Date  // 3 - idem
    let missing: Int?    // a missing element in the JSON cf NOTE

    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case followers
        case repos = "public_repos"
        case avatarUrl = "avatar_url"
        case creation = "created_at"
        case missing
        
    }
}


/*
 
 Note: if the 'missing' key is not optional, the line :
 
   > try decoder.decode(MyGitHub.self, from: data)
 
 will THROW -> then catch and not pursue implementation
 
 if set optional, the value will be nil but still the 'decode' method won't THROW
 
 The same throw can occure with the date if the decodeStrategy is wront
 
 */

/*
 JSON :
 -> https://api.github.com/users/shashikant86
 
 {
     "login": "Shashikant86",
     "id": 683799,
     "node_id": "MDQ6VXNlcjY4Mzc5OQ==",
     "avatar_url": "https://avatars0.githubusercontent.com/u/683799?v=4",
     "gravatar_id": "",
     "url": "https://api.github.com/users/Shashikant86",
     "html_url": "https://github.com/Shashikant86",
     "followers_url": "https://api.github.com/users/Shashikant86/followers",
     "following_url": "https://api.github.com/users/Shashikant86/following{/other_user}",
     "gists_url": "https://api.github.com/users/Shashikant86/gists{/gist_id}",
     "starred_url": "https://api.github.com/users/Shashikant86/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/Shashikant86/subscriptions",
     "organizations_url": "https://api.github.com/users/Shashikant86/orgs",
     "repos_url": "https://api.github.com/users/Shashikant86/repos",
     "events_url": "https://api.github.com/users/Shashikant86/events{/privacy}",
     "received_events_url": "https://api.github.com/users/Shashikant86/received_events",
     "type": "User",
     "site_admin": false,
     "name": "Shashikant",
     "company": "@XCTEQ ",
     "blog": "http://shashikantjagtap.net",
     "location": "London",
     "email": null,
     "hireable": null,
     "bio": "Mobile DevOps, CI/CD,  Mobile Build & Test Automation. Swift, Kotlin, XCTest, XCUITest, Xcode Server, Apple Developer tools, Flutter, Ruby, PHP etc",
     "public_repos": 125,
     "public_gists": 8,
     "followers": 171,
     "following": 55,
     "created_at": "2011-03-22T12:39:11Z",
     "updated_at": "2019-04-03T09:20:18Z"
 }
 
 */
