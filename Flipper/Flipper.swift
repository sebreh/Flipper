//
//  Flipper.swift
//  Flipper
//
//  Created by Sebastian Rehnby on 23/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

private var sharedInstance = Flipper()

open class Flipper {
  
  public enum Level : UInt {
    case development = 1
    case beta
    case release
    
    var description : String {
      switch self {
        case .development:
          return "Development"
        case .beta:
          return "Beta"
        case .release:
          return "Release"
      }
    }
    
    func isIncludedForLevel(_ level: Level) -> Bool {
      return self.rawValue >= level.rawValue
    }
  }
  
  open class var sharedFlipper : Flipper {
    return sharedInstance
  }
  
  open var currentLevel : Level = .release
  
  fileprivate var features = Dictionary<String, Feature>()
  fileprivate var featureLevels = Dictionary<String, Level>()
  fileprivate var forcedFeatures = Dictionary<String, Bool>()
  
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
  
  open func addFeature(_ feature: Feature, level: Level) -> Void {
    features[feature.name] = feature
    featureLevels[feature.name] = level
  }
  
  open func addFeature(_ featureName: String, level: Level) -> Void {
    addFeature(Feature(featureName), level: level)
  }
  
  open func flipOn(_ featureName: String) {
    if features[featureName] != nil {
      forcedFeatures[featureName] = true
    }
  }
  
  open func flipOff(_ featureName: String) {
    if features[featureName] != nil {
      forcedFeatures[featureName] = false
    }
  }
  
  open func resetFeature(_ featureName: String) {
    if forcedFeatures[featureName] != nil {
      forcedFeatures.removeValue(forKey: featureName)
    }
  }
  
  open func isEnabled(_ featureName: String, level: Level) -> Bool {
    if let forced = forcedFeatures[featureName] {
      return forced
    }
    
    if let enabled = isFeatureEnabled(featureName, level: level) {
      return enabled
    }
    
    return false
  }
  
  open func isEnabled(_ featureName: String) -> Bool {
    return self.isEnabled(featureName, level: currentLevel)
  }
  
  fileprivate func isFeatureEnabled(_ featureName: String, level: Level) -> Bool? {
    if let featureLevel = featureLevels[featureName] {
      return featureLevel.isIncludedForLevel(level)
    }
    
    return nil
  }
}
