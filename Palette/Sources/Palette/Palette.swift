// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// Created by Erik Basargin.
//

import SwiftUI

// MARK: - PaletteCore

#if os(macOS)
public typealias PaletteCore = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
public typealias PaletteCore = UIColor
#endif

public extension PaletteCore {

    static var bluishblack: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Bluishblack", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Bluishblack", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Bluishblack")!
        #endif
    }
    static var dullGray: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "DullGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "DullGray", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "DullGray")!
        #endif
    }
    static var gainsboro: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Gainsboro", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Gainsboro", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Gainsboro")!
        #endif
    }
    static var grayblue: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Grayblue", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Grayblue", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Grayblue")!
        #endif
    }
    static var main: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Main", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Main", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Main")!
        #endif
    }
    static var telegrey: Self {
        #if os(iOS) || os(tvOS) || os(macOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Telegrey", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Telegrey", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Telegrey")!
        #endif
    }

}

// MARK: - Palette

public typealias Palette = Color

public extension Palette {

    static let bluishblack = { Self(.bluishblack) }()
    static let dullGray = { Self(.dullGray) }()
    static let gainsboro = { Self(.gainsboro) }()
    static let grayblue = { Self(.grayblue) }()
    static let main = { Self(.main) }()
    static let telegrey = { Self(.telegrey) }()

}

