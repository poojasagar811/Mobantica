//
//  Extension.swift
//  mobantica
//
//  Created by Crescendo Worldwide India on 26/06/24.
//

import Foundation
import UIKit

//MARK: Cornor Radius 
extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.layoutIfNeeded()
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        self.layer.mask = mask
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

//MARK: Label Shadow
extension UILabel {
    
    @IBInspectable var isShadowOnText: Bool {
        get {
            return self.isShadowOnText
        }
        set {
            guard (newValue as? Bool) != nil else {
                return
            }
            
            if newValue == true{
                
                self.layer.shadowColor = UIColor.systemGray5.cgColor
                self.layer.shadowRadius = 2.0
                self.layer.shadowOpacity = 1.0
                self.layer.shadowOffset = CGSize(width: 2, height: 2)
                self.layer.masksToBounds = false
            }
        }
    }
}
//MARK: Navigation bar Back Button Setup

class CustomBackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        let backImage = UIImage(systemName: "chevron.left")
        self.setImage(backImage, for: .normal)
        self.tintColor = .black
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
    }
}

//MARK: UTC TO DATE CONVERTER
extension String
{
    func fromUTCToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "SSSZ", with: "")
        //print(formattedString)
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
}

