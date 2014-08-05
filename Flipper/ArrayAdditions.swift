//
//  ArrayAdditions.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

extension Array {
  
  func firstMatching(matcher: T -> Bool) -> T? {
    var match: T?
    
    for elem in self {
      if matcher(elem) {
        match = elem
        break
      }
    }
    
    return match
  }
}


