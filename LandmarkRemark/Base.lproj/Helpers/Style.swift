//
//  Style.swift
//  LandmarkRemark
//
//  Created by Parth on 01/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class Style {
    enum TextStyle {
        case navigationBar
        case title
        case subtitle
        case body
        case button
        case textfield
    }
    
    struct TextAttributes {
        let font: UIFont
        let color: UIColor
        let backgroundColor: UIColor?
        let layerAttributes: LayerBorderAttributes?

        init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil, layerAttributes: LayerBorderAttributes? = nil) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
            self.layerAttributes = layerAttributes
        }
    }
    
    struct LayerBorderAttributes {
        let borderColor: UIColor
        let borderWidth: CGFloat
        let cornerRadius: CGFloat
        
        init(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - General Properties
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle
    
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes
    
    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes)
    {
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }
    
    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }
    
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    
    func apply(textStyle: TextStyle, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .button, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
        
        button.layer.borderColor = attributes.layerAttributes?.borderColor.cgColor
        button.layer.borderWidth = attributes.layerAttributes?.borderWidth ?? 0
        button.layer.cornerRadius = attributes.layerAttributes?.cornerRadius ?? 0
    }
    
    func apply(textStyle: TextStyle = .navigationBar, to navigationBar: UINavigationBar) {
        let attributes = attributesForStyle(textStyle)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: attributes.font,
            NSAttributedString.Key.foregroundColor: attributes.color
        ]
        
        if let color = attributes.backgroundColor {
            navigationBar.barTintColor = color
        }
        
        navigationBar.tintColor = attributes.color
        navigationBar.barStyle = preferredStatusBarStyle == .default ? .default : .black
    }
    
    func apply(textStyle: TextStyle = .textfield, placeHolderText:String?, to textField: UITextField) {
        let attributes = attributesForStyle(textStyle)
        textField.textColor = attributes.color
        textField.font = attributes.font
        textField.backgroundColor = attributes.backgroundColor
        
        textField.layer.borderColor = attributes.layerAttributes?.borderColor.cgColor
        textField.layer.borderWidth = attributes.layerAttributes?.borderWidth ?? 0
        textField.layer.cornerRadius = attributes.layerAttributes?.cornerRadius ?? 0
        
        textField.placeholder = placeHolderText
    }

}
