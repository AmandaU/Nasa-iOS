//
//  UITextExtensions.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/29.
//

import UIKit
import XCTest

extension XCUIApplication {
    var isDisplayingImages: Bool {
        return otherElements["onImagesView"].exists
    }
    var isDisplayingDetailAndImage: Bool {
        return otherElements["onDetailView"].exists
    }
}
