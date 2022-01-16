//
//  FormRowView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/8/22.
//

import Foundation
import SwiftUI

struct FormRowView: View {
    var title: String
    var subtitle: String
    var isLastIndex: Bool = false
    
    var body: some View {
        VStack(alignment:.leading){
            
            HStack{
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(self.title)
                            .font(.headline).bold()
                        
                            
                    }
                    Text(self.subtitle)
                        .font(.footnote)
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 25))
                    .opacity(0.7)
                
            }
            
            //Divider
            if !isLastIndex {
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.2)
            }
        }
    }
}


