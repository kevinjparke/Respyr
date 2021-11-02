//
//  FindTrainingCenterView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/30/21.
//

import SwiftUI

struct FindTrainingCenterView: View {
    //View model
    @EnvironmentObject private var trainingCenterViewModel: TrainingCenterViewModel
    
    //View states
    @State private var searchKey: String = ""
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //Background Color
                Color.themeBackground
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Button(action: {print("Segue to create view")}) {
                            HStack(spacing: 4){
                                Text("Register a training center here")
                                    .font(.caption)
        
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.caption)
        
        
                            }
                            .foregroundColor(Color.gradient1Color1)
                        }
                        
                        //TODO: Setup search function
                        FormTextFieldView(text: $searchKey, placeholder: "Search", icon: "magnifyingglass.circle.fill")
                        
                        //List on Training Centers
                        ForEach(self.trainingCenterViewModel.allTrainingCenters) {tc in
                            TrainingCenterListRow(trainingCenter: tc)
                        }
                    }
                    .padding()
                }
                .onAppear {
                    //Always update list on appear
                    self.trainingCenterViewModel.fetchAllTrainingCenters()
                }
            }
            .navigationBarTitle("Find a training center")
        }
    }
}

struct FindTrainingCenterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindTrainingCenterView()
                .preferredColorScheme(.dark)
        }
    }
}
