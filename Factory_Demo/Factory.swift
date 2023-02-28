//
//  Factory.swift
//  Factory_Demo
//
//  Created by Robin Ellingsen on 2023-02-28.
//
import Foundation

// *** FACTORY PATTERN DEMO ***
/*
 A factory
 In programming, a factory is an object for creating other objects. In Swift that object will typically be a class, and will produce a concrete instance of an object. In the original book ("Design Patterns:
 Elements of Reusable Object-Oriented Software", Erich Gamma) it is declared that there is no strict factory pattern, but rather a factory method pattern and an abstract factory pattern.
 */

// Protocol tells us that the class conforming to it, has to have this method.
protocol Device {
    func aboutDevice() -> String // <-- If not this in class, the class using Device will not conform to the Device protocol.
}


struct OperatingSystem {
    // All operatingsystems and version.
    enum SystemType: String {
        case iOS
        case iPadOS
        case macOS
    }
    // Operating system has to have theese two things..
    var version: Int
    var type: SystemType
}

struct Mac: Device {
    // The Mac has an operating system..
    var system: OperatingSystem

    init(system: OperatingSystem) {
        self.system = system
    }

    //And it conforms to Device protocol so we must have this method!
    func aboutDevice() -> String {
        //and since its a mac it should return "Mac" followed its type and version.
        return "Mac: \(system.type.rawValue) \(system.version)"
    }
}
    // Same with every device..
struct iPhone: Device {
    var system: OperatingSystem

    init(system: OperatingSystem) {
        self.system = system
    }

    func aboutDevice() -> String {
        return "iPhone: \(system.type.rawValue) \(system.version)"
    }
}

struct iPad: Device {
    var system: OperatingSystem

    init(system: OperatingSystem) {
        self.system = system
    }

    func aboutDevice() -> String {
        return "iPad: \(system.type.rawValue) \(system.version)"
    }
}


struct DeviceFactory {
    //Heres the factory. We will return the right OS with the right device.
    static func makeDevice(system: OperatingSystem) -> Device {
        switch system.type {
        case .iOS:
            return iPhone(system: system)
            // Returns the iPhone struct with its OperatingSystem systemType and Version!
            // in this case we give it: (Int, .iOS)
        case .iPadOS:
            return iPad(system: system)
            //(Int, .iPadOS)
        case .macOS:
            return Mac(system: system)
            //(Int, .macOS)
        }
    }
}

//We create a computer using the factory 🙌
let computer = DeviceFactory.makeDevice(system:  OperatingSystem(version: 13, type: .macOS))
// print(computer.aboutDevice()) will print: Mac: MacOS 13

var operatingSystems: [OperatingSystem] = [
    OperatingSystem(version: 16, type: .iOS),
    OperatingSystem(version: 14, type: .macOS),
    OperatingSystem(version: 12, type: .iPadOS)
]

/*
 operatingSystems.forEach{
 print(DeviceFactory.makeDevice(system: $0).aboutDevice())
 }

 */
//This will print:
// iPhone: iOS 16
// Mac: MacOS 14
// iPad: iOS 12

