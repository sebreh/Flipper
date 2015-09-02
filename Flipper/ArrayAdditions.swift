//
//  ArrayAdditions.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

extension Array {
  
  func firstMatching(matcher: Element -> Bool) -> Element? {
    var match: Element?
    
    for elem in self {
      if matcher(elem) {
        match = elem
        break
      }
    }
    
    return match
  }
}


