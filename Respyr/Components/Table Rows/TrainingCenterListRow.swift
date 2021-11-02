//
//  TrainingCenterListRow.swift
//  Respyr
//
//  Created by Kevin Parke on 10/9/21.
//

import SwiftUI

struct TrainingCenterListRow: View {
    var trainingCenter: TrainingCenter
    
    var body: some View {
        VStack(alignment:.leading){
            //Divider
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
            HStack{
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(trainingCenter.title)
                            .font(.headline).bold()
                        
                        Text("ADMIN")
                            .padding(4)
                            .font(.caption2)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .clipShape(Capsule())
                            .opacity(0.7)
                            
                    }
                    Text(trainingCenter.location)
                        .font(.footnote)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 25))
                    .blendMode(.overlay)
                
            }
        }
    }
}

//struct TrainingCenterListRow_Previews: PreviewProvider {
//    static var previews: some View {
////        TrainingCenterListRow()
//    }
//}
