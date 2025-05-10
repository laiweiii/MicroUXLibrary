//
//  ScreenOrientation.swift
//  MicroUXLibrary
//
//  Created by Lai Wei on 2025-04-02.
//
//

import Foundation
import SwiftUI

public enum ScreenOrientation {
    case standard, wide
    
    /// Determines if the screen is in standard or wide mode based on size classes
    public static func screenMode(_ verticalSizeClass: UserInterfaceSizeClass?,
                                  _ horizontalSizeClass: UserInterfaceSizeClass?) -> ScreenOrientation {
        if verticalSizeClass == .compact {
            return .wide
        }
        else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return .wide
        } else {
            return .standard
        }
    }
    
    // Helper method to calculate target Y position outside of the view body
    public static func getTargetY(position: SheetPosition,
                                 collapsedY: CGFloat,
                                 expandedY: CGFloat,
                                 screenHeight: CGFloat) -> CGFloat {
        switch position {
        case .collapsed:
            return collapsedY
        case .expanded:
            return expandedY
        case .custom(let ratio):
            return screenHeight * (1 - ratio)
        }
    }
}
