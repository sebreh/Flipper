//
//  FlipperTests.swift
//  FlipperTests
//
//  Created by Sebastian Rehnby on 18/07/14.
//  Copyright (c) 2014 Sebastian Rehnby. All rights reserved.
//

import XCTest
import UIKit

class FlipperTests: XCTestCase {
  
  func testSharedFlipper() {
    let flipper1 = Flipper.sharedFlipper
    let flipper2 = Flipper.sharedFlipper
    XCTAssertTrue(flipper1 === flipper2, "Flippers should be same instance");
  }
  
  func testEmptyFlipperShouldNotHaveEnabledFeature() {
    let flipper = Flipper()
    XCTAssertFalse(flipper.isEnabled("feature", level: .Development), "Feature should be disabled")
  }
  
  func testReleaseFeatureShouldBeEnabledForBetaAndDevelopment() {
    let flipper = Flipper(features: ["feature" : .Release])
    
    XCTAssertTrue(flipper.isEnabled("feature", level: .Release), "Feature should be enabled for release")
    XCTAssertTrue(flipper.isEnabled("feature", level: .Beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .Development), "Feature should be enabled for development")
  }
  
  func testBetaFeatureShouldBeEnabledForDevelopment() {
    let flipper = Flipper(features: ["feature" : .Beta])
    
    XCTAssertFalse(flipper.isEnabled("feature", level: .Release), "Feature should not be enabled for release")
    XCTAssertTrue(flipper.isEnabled("feature", level: .Beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .Development), "Feature should be enabled for development")
  }
  
  func testDevelopmentFeatureShouldBeEnabledForDevelopmentOnly() {
    let flipper = Flipper(features: ["feature" : .Development])
    
    XCTAssertFalse(flipper.isEnabled("feature", level: .Release), "Feature should not be enabled for release")
    XCTAssertFalse(flipper.isEnabled("feature", level: .Beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .Development), "Feature should be enabled for development")
  }
  
  func testCurrentLevelUsed() {
    let flipper = Flipper(features: ["feature" : .Beta])
    flipper.currentLevel = .Release
    
    XCTAssertFalse(flipper.isEnabled("feature"), "Feature should not be enabled for release")
    
    flipper.currentLevel = .Beta
    XCTAssertTrue(flipper.isEnabled("feature"), "Feature should be enabled for beta")
    
    flipper.currentLevel = .Development
    XCTAssertTrue(flipper.isEnabled("feature"), "Feature should be enabled for development")
  }
}
