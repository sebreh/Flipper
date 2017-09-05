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
    XCTAssertFalse(flipper.isEnabled("feature", level: .development), "Feature should be disabled")
  }
  
  func testReleaseFeatureShouldBeEnabledForBetaAndDevelopment() {
    let flipper = Flipper(features: ["feature" : .release])
    
    XCTAssertTrue(flipper.isEnabled("feature", level: .release), "Feature should be enabled for release")
    XCTAssertTrue(flipper.isEnabled("feature", level: .beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .development), "Feature should be enabled for development")
  }
  
  func testBetaFeatureShouldBeEnabledForDevelopment() {
    let flipper = Flipper(features: ["feature" : .beta])
    
    XCTAssertFalse(flipper.isEnabled("feature", level: .release), "Feature should not be enabled for release")
    XCTAssertTrue(flipper.isEnabled("feature", level: .beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .development), "Feature should be enabled for development")
  }
  
  func testDevelopmentFeatureShouldBeEnabledForDevelopmentOnly() {
    let flipper = Flipper(features: ["feature" : .development])
    
    XCTAssertFalse(flipper.isEnabled("feature", level: .release), "Feature should not be enabled for release")
    XCTAssertFalse(flipper.isEnabled("feature", level: .beta), "Feature should be enabled for beta")
    XCTAssertTrue(flipper.isEnabled("feature", level: .development), "Feature should be enabled for development")
  }
  
  func testCurrentLevelUsed() {
    let flipper = Flipper(features: ["feature" : .beta])
    flipper.currentLevel = .release
    
    XCTAssertFalse(flipper.isEnabled("feature"), "Feature should not be enabled for release")
    
    flipper.currentLevel = .beta
    XCTAssertTrue(flipper.isEnabled("feature"), "Feature should be enabled for beta")
    
    flipper.currentLevel = .development
    XCTAssertTrue(flipper.isEnabled("feature"), "Feature should be enabled for development")
  }
}
