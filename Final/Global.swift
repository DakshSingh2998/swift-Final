//
//  Global.swift
//  Final
//
//  Created by Daksh on 23/02/35.
//

import Foundation
import SwiftUI
class Global{
    static var shared = Global()
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    static var orientationUpdated: (() -> Void)?
    func updateOrientation(){
        var orientation = UIDevice.current.orientation
        if(orientation == .portrait || orientation == .portraitUpsideDown){
            print("Portrait")
            width = UIScreen.main.bounds.width
            height = UIScreen.main.bounds.height
        }
        if(orientation == .landscapeLeft || orientation == .landscapeRight){
            print("Landscape")
            width = UIScreen.main.bounds.width
            height = UIScreen.main.bounds.height
        }
        print(width, height)
        Global.orientationUpdated?()
    }
    
    
}
