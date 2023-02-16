//
//  CustomSecondaryButton.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct CustomSecondaryButton: View{
    @State var title:String?
    @State var height:CGFloat = 36
    var closure: (() -> Void)?
    var body: some View {
        Button(action: closure!,label:{
            Spacer()
            Text(title!)
            Spacer()
        }).frame(maxWidth: .infinity, minHeight: height).overlay{RoundedRectangle(cornerRadius: 8.0, style: .continuous).stroke( Color("Dark"), lineWidth: 6)}.background(Color("Dark")).cornerRadius(8.0).foregroundColor(.white)
    }
}
/*
struct CustomSecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecondaryButton()
    }
}

*/
