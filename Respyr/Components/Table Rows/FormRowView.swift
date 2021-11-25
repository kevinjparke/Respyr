//
//  FormRowView.swift
//  Respyr
//
//  Created by Kevin Parke on 11/2/21.
//

import SwiftUI

struct FormRowView: View {
    var label: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption).opacity(0.7)
            Text(text)
                .font(.headline)
            
            Rectangle()
                .frame(height: 1)
                .opacity(0.5)
        }
    }
}

//struct FormRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormRowVielabel: <#String#>, text: <#String#>w()
//    }
//}
