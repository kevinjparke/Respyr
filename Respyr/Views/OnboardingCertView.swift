//
//  OnboardingCertView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/1/22.
//

import SwiftUI

struct OnboardingCertView: View {
    @State private var isExpanded: Bool = false
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var selectedCertification: String = ""
    @State private var certificationType: String = ""
    @State private var trainingCenter: String = ""
    @State private var dateIssued: Date = Date()
    @State private var expiration: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.onboardingColor1, Color.onboardingColor2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Button(action: {
                    //Dismiss and save?
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .onAppear{
                    self.userViewModel.updateUser()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Already Certified?")
                        .font(.largeTitle.bold())
                        
                    Text("Keep all of your certificates in one place with Respyr 🤩")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .opacity(0.7)
                }
                .foregroundColor(.white)
                
                
                VStack(alignment: .leading, spacing: 4) {
                    DisclosureGroup("Select your certification", isExpanded: $isExpanded){
                        VStack {
                            ForEach(UserCertification.allCases, id: \.self){cert in
                                Rectangle()
                                    .frame(height: 1)
                                    .background(Color.white.opacity(0.2))
                                
                                Text(cert.rawValue)
                                    .onTapGesture {
                                        self.selectedCertification = cert.rawValue
                                        self.isExpanded = false
                                    }
                            }
                        }
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                    .accentColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                    )
                    
                    if !selectedCertification.isEmpty{
                        Text("You selected: \(selectedCertification)")
                            .foregroundColor(Color.white)
                    }
                }
                
                TextField("Affiliate Training Center", text: $trainingCenter)
                    .autocapitalization(.sentences)
                    .textContentType(.name)
                    .foregroundColor(.white)
                    .colorScheme(.dark)
                    .padding()
                    .frame(height: 52)
                    .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                )
                
                DatePicker("Date Issued:", selection: $dateIssued, displayedComponents: .date)
                    .padding()
                    .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                    .accentColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                    )
//                    .onChange(of: dateIssued) { newValue in
//                        //Add the predicted 2 years to the expiration date
//                        self.expiration.addTimeInterval(63072000)
//                    }
                
                DatePicker("Expiration:", selection: $expiration, displayedComponents: .date)
                    .padding()
                    .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                    .accentColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                    )
                
                Button(action: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm E, d MMM y"

                    //Update Certificate repository
                    let dateIssued = formatter.string(from: self.dateIssued)
                    let expirationDate = formatter.string(from: self.expiration)
                    let newCert = Certification(userCertificationType: self.selectedCertification, trainingCenter: self.trainingCenter, dateIssued: dateIssued, expiration: expirationDate)

                    self.userViewModel.userCertificationViewModel.addUserCertification(userCertification: newCert)

                    //Dismiss full screen view.
                    self.userViewModel.dismissOnboardingScreen = true
                    
                }) {
                    Text("Save And Add Another")
                        .foregroundColor(Color.white)
                        .font(.headline)
                }
                .disabled(isFormValid())
                
                Spacer()
                
            }
            .padding(20)
        }
        .colorScheme(.dark)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func isFormValid() -> Bool {
        //Check whether form is complete
        return !(self.certificationType.isEmpty && self.trainingCenter.isEmpty && self.expiration == Date() && self.dateIssued == Date())
    }
}

struct OnboardingCertView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCertView()
    }
}
