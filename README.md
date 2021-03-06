# Flipper

Flipper is a very simple Swift library for [feature flipping](http://en.wikipedia.org/wiki/Feature_toggle). Feature flipping is the method of dynamically enabling/disabling pieces of code in your app depending on an availability level. For example, it can be used for enabling beta-only features for beta testers from the same code base as is being shipped to the App Store. No need to maintain multiple branches. It also allows for other use cases such as remote or partial enabling/disabling of features.

First, you need to configure your flipper with various features and their respective enablement level:

```swift
let flipper = Flipper()
flipper.addFeature("my_released_feature", level: .Release)
flipper.addFeature("my_beta_feature", level: .Beta)
flipper.addFeature("my_developing_feature", level: .Development)

// or...

let flipper = Flipper([
  "my_released_feature": .Release,
  "my_beta_feature": .Beta,
  "my_developing_feature": .Development,
])
```

You can then check if a feature is enabled for a certain level. The key point here is that each level includes features enabled for levels "above". So if a feature is enabled for "Beta", it will also be enabled for "Development", as "Beta" is a *higher* feature level. For example:

```swift
flipper.isEnabled("my_beta_feature", level: .Release)     // => false
flipper.isEnabled("my_beta_feature", level: .Beta)        // => true
flipper.isEnabled("my_beta_feature", level: .Development) // => true
```

You can force also forcefully enable/disable a feature:

```swift
flipper.isEnabled("my_beta_feature", level: .Release) // => false

// Force enable
flipper.flipOn("my_beta_feature")
flipper.isEnabled("my_beta_feature", level: .Release) // => true

// Force disable
flipper.flipOff("my_beta_feature")
flipper.isEnabled("my_beta_feature", level: .Beta)    // => false

// Reset to get back to normal
flipper.resetFeature("my_beta_feature")
flipper.isEnabled("my_beta_feature", level: .Beta)   // => true
```

If you omit the level from the `isEnabled()` call, the flipper will compare against it's internally configured level as defined by the `currentLevel` property.

```swift
let flipper = Flipper([ "my_beta_feature": .Beta ])

flipper.currentLevel = .Release
flipper.isEnabled("my_beta_feature") // => false

flipper.currentLevel = .Beta
flipper.isEnabled("my_beta_feature") // => true
```

Finally, for convenience, there is a singleton instance of Flipper available through the read-only `sharedFlipper` class property. This is useful if you only ever want to use a shared instance throughout your app.