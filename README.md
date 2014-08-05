# Flipper

Flipper is a very simple Swift library used for [feature flipping](http://en.wikipedia.org/wiki/Feature_toggle). Feature flipping is an effective method to dynamically enable/disable pieces of code in your app depending on who it should be available for. For example, it can be used for enabling beta-only features to beta testers from the same code base as is being shipped to the App Store, without maintaining multiple branches.

First, you need to configure your flipper with various features and their respective enablement level:

swift
```
let flipper = Flipper()
flipper.addFeature("my_released_feature", .Release)
flipper.addFeature("my_beta_feature", .Beta)
flipper.addFeature("my_developing_feature", .Development)

// or...

let flipper = Flipper([
  "my_released_feature": .Release,
  "my_beta_feature": .Beta,
  "my_developing_feature": .Development,
])
```

You can then check if a feature is enabled for a certain level. The key point here is that each level includes features enabled for levels "above". So if a feature is enabled for "Beta", it will also be enabled for "Development", as "Beta" is a *higher* feature level. For example:

swift
```
flipper.isEnabled("my_beta_feature", .Release)     // => false
flipper.isEnabled("my_beta_feature", .Beta)        // => true
flipper.isEnabled("my_beta_feature", .Development) // => true
```