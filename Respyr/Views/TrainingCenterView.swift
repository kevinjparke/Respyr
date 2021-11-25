//
//  TrainingCenterView.swift
//  Respyr
//
//  Created by Kevin Parke on 11/2/21.
//

import SwiftUI
import Combine

struct TrainingCenterView: View {
    //Environment Objects
    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var trainingCenterViewModel: TrainingCenterViewModel
    
    //View states
    @State private var isInstructor: Bool = false
    @State private var administratorName: String = ""
    @State private var isPendingRequest: Bool = false
    
    //Alert view
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertToggle: Bool = false
    
    //Passed variables
    var trainingCenter: TrainingCenter
    
    //Cancel bag
    var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack {
            //Background Color
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            //Main content
            VStack(alignment: .leading, spacing: 16){
                //Title
                VStack(alignment: .leading, spacing: 4) {
                    Text(trainingCenter.title)
                        .font(.largeTitle.bold())
                        .lineLimit(2)
                    
                    Text(trainingCenter.location)
                        .font(.footnote)
                        .opacity(0.7)
                }
                
                //Description
                VStack(alignment: .leading, spacing: 16) {
                    FormRowView(label: "Administrator", text: trainingCenterViewModel.admin)
                    
                    FormRowView(label: "AHA Training Center ID", text: trainingCenter.trainingCenterID)
                    
                    FormRowView(label: "Sessions Conducted", text: "\(trainingCenter.sessions.count)")
                    
                    FormRowView(label: "Students", text: "\(trainingCenter.students.count)")
                    
                    Text("Member since \(trainingCenter.membershipDate)")
                        .font(.caption)
                        .opacity(0.5)
                }
                .padding()
                .background(Color.primary.opacity(0.1))
                .cornerRadius(30)
                
                Toggle("I want to join as an instructor", isOn: $isInstructor)
                    .accentColor(Color.gradient1Color1)
                    .moveDisabled(!isPendingRequest)
                
                if isInstructor {
                    HStack(spacing: 0){
                        withAnimation {
                            Text("It is the responsibility of the training center administrator to determine or verify your role")
                                .opacity(0.7).font(.caption2)
                        }
                    }
                }
                
                //TODO: Fix invalid document error
                SecondaryButton(text: isPendingRequest ? "Cancel Request" : "Send Request"){
                    if isInstructor && !isPendingRequest{
                        //Add training center to list of user instructor training centers
                        userViewModel.sentInstructorRequest.append(trainingCenter.id!)
                        
                        //Update user requests on Firestore and on Core Data
                        userViewModel.updateUser()
                        
                        //Add user id to list of training center instructors on Firestore and Core Data
                        trainingCenterViewModel.createTrainingCenterRequest(userID: userViewModel.currentUserID, trainingCenterID: trainingCenter.id!, isInstructor: true)
                    } else if !isPendingRequest  {
                        //Add training center to list of student training centers
                        userViewModel.trainingCenters.append(trainingCenter.id!)
                        
                        //Update user requests on Firestore and on Core Data
                        userViewModel.updateUser()
                        
                        //Update training center to include student request
                        trainingCenterViewModel.createTrainingCenterRequest(userID: userViewModel.currentUserID, trainingCenterID: trainingCenter.id!, isInstructor: false)
                    }
                    
                    if isPendingRequest {
                        //Ask user if they would like to cancel their request
//                        self.alertTitle
                    }
                    
                    //Disable instructor toggle and present an alert with the changed state
                    self.isPendingRequest.toggle()
                    self.alertTitle = "Request sent"
                    self.alertMessage = "Something"
                    self.alertToggle.toggle()
                    
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .onAppear {
                if !trainingCenter.administrators.isEmpty {
                    self.trainingCenterViewModel.fetchTrainingCenterAdministrator(id: trainingCenter.administrators[0])
                } else {
                    trainingCenterViewModel.admin = "N/A"
                }
                self.getRequestStatus()
            }
            .alert(isPresented: self.$alertToggle) {
                //If cancel logic to go here
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
            }
        }
    }
    
    func getRequestStatus() {
        if let userDocument = userViewModel.userDocument {
            let sentRequests = userDocument.sentRequests
            if sentRequests.contains(trainingCenter.id!) {
                self.isPendingRequest = true
            } else {
                self.isPendingRequest = false
            }
        }
    }
}

struct TrainingCenterView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingCenterView(trainingCenter: TrainingCenter(id: "wefwef", title: "St. George's University", location: "True Blue, St. George, Grenada", administrators: [""], trainingCenterID: "1234123", sessionsConducted: 0, instructors: [""], students: [""], membershipDate: "Monday, 10 October, 2021", studentRequests: [], instructorRequests: [], sessions: []))
//            .preferredColorScheme(.dark)
    }
}
