//
//  LocalizedTextField.swift
//  FoodooRestaurant
//
//  Created by Techimmense Software Solutions on 28/05/24.
//

import UIKit
import LanguageManager_iOS

@IBDesignable
class LocalizedTextField: UITextField {
    
    enum DirectionVal {
        case on, off
    }
    
    var directionVal: DirectionVal = .on {
        didSet {
            updateTextAlignment()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTextAlignment()
    }
    
    private func updateTextAlignment() {
        switch directionVal {
        case .on where LanguageManager.shared.isRightToLeft:
            textAlignment = .right
        case .on:
            textAlignment = .left
        case .off:
            break
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateTextAlignment()
    }
}

@IBDesignable
class LocalizedTextView: UITextView {
    
    enum DirectionVal {
        case on, off
    }
    
    var directionVal: DirectionVal = .on {
        didSet {
            updateTextAlignment()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTextAlignment()
    }
    
    private func updateTextAlignment() {
        switch directionVal {
        case .on where LanguageManager.shared.isRightToLeft:
            textAlignment = .right
        case .on:
            textAlignment = .left
        case .off:
            break
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateTextAlignment()
    }
}
