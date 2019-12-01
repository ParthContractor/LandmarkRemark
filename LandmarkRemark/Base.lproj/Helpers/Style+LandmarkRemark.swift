//
//  Style+LandmarkRemark.swift
//  LandmarkRemark
//
//  Created by Parth on 01/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

extension Style {
    static var landmarkRemark: Style {
        return Style(
            backgroundColor: .white,
            preferredStatusBarStyle: .default,
            attributesForStyle: { $0.landmarkRemarkAttributes }
        )
    }
}

private extension Style.TextStyle {
    var landmarkRemarkAttributes: Style.TextAttributes {
        switch self {
        case .navigationBar:
            return Style.TextAttributes(font: .landmarkRemarkTitle, color: .landmarkRemarkGreen, backgroundColor: .black)
        case .title:
            return Style.TextAttributes(font: .landmarkRemarkTitle, color: .landmarkRemarkGreen)
        case .subtitle:
            return Style.TextAttributes(font: .landmarkRemarkSubtitle, color: .landmarkRemarkBlue)
        case .body:
            return Style.TextAttributes(font: .landmarkRemarkBody, color: .black, backgroundColor: .white)
        case .button:
            let layerAttributes = Style.LayerBorderAttributes(borderColor: .lightGray, borderWidth: 1.5, cornerRadius: 5.0)
            return Style.TextAttributes(font: .landmarkRemarkTitle, color: .white, backgroundColor: .landmarkRemarkTheme, layerAttributes: layerAttributes)
        case .textfield:
            let layerAttributes = Style.LayerBorderAttributes(borderColor: .lightGray, borderWidth: 1.0, cornerRadius: 1.0)
            return Style.TextAttributes(font: .landmarkRemarkSubtitle, color: .darkGray, backgroundColor: .clear, layerAttributes: layerAttributes)
        }
    }
}

extension UIColor {
    static var landmarkRemarkTheme: UIColor {
        return UIColor.orange
    }
    static var landmarkRemarkRed: UIColor {
        return UIColor(red: 1, green: 0.1, blue: 0.1, alpha: 1)
    }
    static var landmarkRemarkGreen: UIColor {
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    static var landmarkRemarkBlue: UIColor {
        return UIColor(red: 0, green: 0.2, blue: 0.9, alpha: 1)
    }
}

extension UIFont {
    static var landmarkRemarkTitle: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    static var landmarkRemarkSubtitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    static var landmarkRemarkBody: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
}
