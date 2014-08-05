//
//  Flipper.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

private var sharedInstance = Flipper()

public class Flipper {
  
  public enum Level : UInt {
    case Development = 1
    case Beta
    case Release
    
    var description : String {
      switch self {
        case Development:
          return "Development"
        case Beta:
          return "Beta"
        case Release:
          return "Release"
      }
    }
    
    func isIncludedForLevel(level: Level) -> Bool {
      return self.toRaw() >= level.toRaw()
    }
  }
  
  public class var sharedFlipper : Flipper {
    return sharedInstance
  }
  
  public var currentLevel : Level = .Release
  
  private var features = Dictionary<String, Feature>()
  private var featureLevels = Dictionary<String, Level>()
  private var forcedFeatures = Dictionary<String, Bool>()
  
  public init() {}
  
  public init(features: Dictionary<Feature, Level>) {
    for (feature, level) in features {
      self.addFeature(feature, level: level)
    }
  }
  
  public init(features: Dictionary<String, Level>) {
    for (featureName, level) in features {
      self.addFeature(featureName, level: level)
    }
  }
  
  public func addFeature(feature: Feature, level: Level) -> Void {
    features[feature.name] = feature
    featureLevels[feature.name] = level
  }
  
  public func addFeature(featureName: String, level: Level) -> Void {
    addFeature(Feature(featureName), level: level)
  }
  
  public func flipOn(featureName: String) {
    if let feature = features[featureName] {
      forcedFeatures[featureName] = true
    }
  }
  
  public func flipOff(featureName: String) {
    if let feature = features[featureName] {
      forcedFeatures[featureName] = false
    }
  }
  
  public func resetFeature(featureName: String) {
    if let feature = forcedFeatures[featureName]  {
      forcedFeatures.removeValueForKey(featureName)
    }
  }
  
  public func isEnabled(featureName: String, level: Level) -> Bool {
    if let forced = forcedFeatures[featureName] {
      return forced
    }
    
    if let enabled = isFeatureEnabled(featureName, level: level) {
      return enabled
    }
    
    return false
  }
  
  public func isEnabled(featureName: String) -> Bool {
    return self.isEnabled(featureName, level: currentLevel)
  }
  
  private func isFeatureEnabled(featureName: String, level: Level) -> Bool? {
    if let featureLevel = featureLevels[featureName] {
      return featureLevel.isIncludedForLevel(level)
    }
    
    return nil
  }
}