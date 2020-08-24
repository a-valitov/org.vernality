# Use AAA

* Status: proposed
* Deciders: [rinat-enikeev](https://github.com/rinat-enikeev)
* Date: 2020-08-20

## Context and Problem Statement

Which architecture is the best choice for TeleGuide iOS app? 

## Decision Drivers

* architecture affects development lifecycle
* source code is going to be open-sourced

## Considered Options

* VIPER
* MVVM+C
* MVC
* MVP
* AAA
* SwiftUI

## Decision Outcome

Chosen option: "AAA", because the project is going to be open-sourced and is made for innovation. 

### Positive Consequences 

* attempt to invent something new
* experiment can be shared
* feedback can be collected

### Negative Consequences 

* risky decision because the aproach is not mature
* the approach is not known by the community

## Pros and Cons of the Options

### VIPER

* Good, because is well known by the community
* Good, because is modular
* Good, because is testable
* Bad, because it is verbose

### MVVM+C

* Good, because is fast for developent
* Good, because uses latest framework
* Bad, because requires iOS 13+

### MVC

* Good, because is simple
* Good, because is promoted by Apple
* Bad, because should be cooked very carefully in order to keep modularity

### MVP

* Good, because is simple but powerful
* Good, because is very well known to different communities
* Bad, because should be cooked very careful in order to keep modularity

### AAA

* Good, because can combine best practices from different architectures
* Good, because keeps modularity while allowing to use different architectures
* Bad, because is not tested in practice and now known by the community

### SwiftUI

* Good, because is new, fancy and exciting
* Good, because is promoted by Apple
* Bad, because requires iOS 13
