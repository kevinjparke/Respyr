//
//  AddCertificateView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/9/22.
//

import SwiftUI

struct AddCertificateView: View {
    @State private var isExpanded: Bool = false
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var selectedCertification: String = ""
    @State private var certificationType: String = ""
    @State private var trainingCenter: String = ""
    @State private var dateIssued: Date = Date()
    @State private var expiration: Date = Date()
    let formatter = DateFormatter()
    
    var certificate: Certification?
    
    //Alert View
    @State private var alertTitle: String = "Incomplete form!"
    @State private var alertMessage: String = "Please ensure all the required fields are completed before continuing"
    @State private var showAlertView: Bool = false
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    Text("Keep all of your certificates in one place with Respyr 🤩")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .opacity(0.7)
                    
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
                                .foregroundColor(Color.primary)
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
                    
                    DatePicker("Expiration:", selection: $expiration, displayedComponents: .date)
                        .padding()
                        .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                        .accentColor(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 1)
                                    .blendMode(.overlay)
                        )
                    
                    Button(action: {
                        formatter.dateFormat = "d MMM y"

                        //Update Certificate repository
                        if isFormValid() {
                            let dateIssued = formatter.string(from: self.dateIssued)
                            let expirationDate = formatter.string(from: self.expiration)
                            var newCert = Certification(userCertificationType: self.selectedCertification, trainingCenter: self.trainingCenter, dateIssued: dateIssued, expiration: expirationDate)
                            //If certificate is nil that it should be updated.
                            if certificate != nil {
                                newCert.id = certificate!.id
                                self.userViewModel.updateUserCertification(certification: newCert)
                            } else {
                                //If certificate is nil this is the add user interface
                                self.userViewModel.userCertificationViewModel.addUserCertification(userCertification: newCert)
                            }
                        } else {
                            self.showAlertView.toggle()
                        }
                        
                        
                    }) {
                        Text(certificate != nil ? "Update and Save" : "Save And Add Another")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 52)
                    .background(Color.gradient1Color1.opacity(isFormValid() ? 1 : 0.5))
                    .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                .stroke(Color.white, lineWidth: 3)
                                .blendMode(.overlay)
                    )
                    .cornerRadius(16.0)
                    .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
                    .onAppear {
                        //Causing a bug that dismisses view once document is updated in Firebase.
                        if certificate != nil {
                            self.formatter.dateFormat = "d MMM y"
                            self.selectedCertification = certificate?.userCertificationType ?? ""
                            self.trainingCenter = certificate?.trainingCenter ?? ""
                            self.dateIssued = formatter.date(from: certificate!.dateIssued) ?? Date()
                            self.expiration = formatter.date(from: certificate!.expiration) ?? Date()
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(20)
            }
        }
        .navigationBarTitle(Text(certificate != nil ? "Edit Certification" : "Add Certification"))
        .alert(isPresented: $showAlertView) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func isFormValid() -> Bool {
        if (self.certificationType.isEmpty && self.trainingCenter.isEmpty) {
            return false
        } else {
            return true
        }
    }
}

struct AddCertificateView_Previews: PreviewProvider {
    static var previews: some View {
        AddCertificateView()
    }
}
