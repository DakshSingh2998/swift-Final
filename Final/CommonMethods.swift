//
//  Global.swift
//  Final
//
//  Created by Daksh on 23/02/35.
//

import Foundation
import SwiftUI
class CommonMethods{
    static var shared = CommonMethods()
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var currentOrientation = UIDevice.current.orientation
    static var orientationUpdated: (() -> Void)?
    func updateOrientation(){
        var orientation = UIDevice.current.orientation
        currentOrientation = orientation
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
        CommonMethods.orientationUpdated?()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidDate(_ inputValue: String) -> Bool {
        /*
        let strategy = Date.ParseStrategy(format: "\(day: .twoDigits)/\(month: .twoDigits)/\(year: .defaultDigits)",
                                          timeZone: .current)

        if let _ = inputValue.range(of: #"^\d{2}/\d{2}/\d{4}$"#, options: .regularExpression),
           let dateOfBirth = try? Date(inputValue, strategy: strategy) {
            print(dateOfBirth)
            return true
        }
        else {
            return false
        }
         */
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from: inputValue) else{
            return false
        }
        if(date <= Date.now){
            return true
        }
        return false
    }
    func isValidName(_ name:String) -> Bool{
        let emailRegEx = "(?<! )[-a-zA-Z' ]{2,26}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: name)
    }
    
    
}
