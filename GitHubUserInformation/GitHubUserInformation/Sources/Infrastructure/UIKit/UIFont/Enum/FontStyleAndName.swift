//
//  FontStyleAndName.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import Foundation

/// Text Style with associated font name
enum FontStyleAndName: String, CaseIterable {

    // MARK: - OpenSans fonts

    /// regular style
    case regular = "HelveticaNeue"
    /// bold style
    case bold = "HelveticaNeue-Bold"
    /// bold italic style
    case boldItalic = "HelveticaNeue-BoldItalic"
    /// condensed Black style
    case condensedBlack = "HelveticaNeue-CondensedBlack"
    /// condensed Bold style
    case condensedBold = "HelveticaNeue-CondensedBold"
    /// italic style
    case italic = "HelveticaNeue-Italic"
    /// light style
    case light = "HelveticaNeue-Light"
    /// light italic style
    case lightItalic = "HelveticaNeue-LightItalic"
    /// medium style
    case medium = "HelveticaNeue-Medium"
    /// medium italic style
    case mediumItalic = "HelveticaNeue-MediumItalic"
    /// semi Bold style
    case thin = "HelveticaNeue-Thin"
    /// semi bold italic style
    case thinItalic = "HelveticaNeue-ThinItalic"
    /// ultra light style
    case ultraLight = "HelveticaNeue-UltraLight"
    /// ultra light italic style
    case ultraLightItalic = "HelveticaNeue-UltraLightItalic"
}
