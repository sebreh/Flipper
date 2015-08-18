//
//  Feature.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

public struct Feature : Equatable, Hashable {
  
  public let name: String
  public let desc: String?
  
  public init(_ name: String) {
    self.name = name
    self.desc = nil
  }
  
  public init(_ name: String, desc: String) {
    self.name = name
    self.desc = desc
  }
  
  public var hashValue: Int {
    return self.name.hashValue
  }
}

public func ==(lhs: Feature, rhs: Feature) -> Bool {
  return lhs.name == rhs.name
}