//
//  DictionaryAdditions.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

extension Dictionary {

  func map<T, U>(_ mapper: (Key, Value) -> (T, U)) -> Dictionary<T, U> {
    var dict = Dictionary<T, U>()
    
    for (key, value) in self {
      let (newKey, newValue) = mapper(key, value)
      dict[newKey] = newValue
    }
    
    return dict
  }
}
