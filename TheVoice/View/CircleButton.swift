//
//  CircleButton.swift
//  TheVoice
//
//  Created by Kimaya Desai on 1/6/18.
//  Copyright © 2018 SDSU. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{
        setUp()
            
            
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUp()
    }
    
    func setUp(){
        layer.cornerRadius = cornerRadius
    }

}
