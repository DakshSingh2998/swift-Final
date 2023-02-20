//
//  CustomSecondaryButton.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct CustomSecondaryButton: View{
    @State var title = "Button"
    @State var height:CGFloat = 36
    var closure: (() -> Void)?
    var body: some View {
        Button(action: closure ?? {
            print("Button Action not Defined")
        },label:{
            Spacer()
            Text(title).fontWeight(.bold)
            Spacer()
        }).frame(maxWidth: .infinity, minHeight: height).overlay{RoundedRectangle(cornerRadius: 8.0, style: .continuous).stroke( Color("Blue"), lineWidth: 6)}.cornerRadius(8.0).foregroundColor(Color("Blue"))
    }
}

struct CustomSecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecondaryButton()
    }
}

