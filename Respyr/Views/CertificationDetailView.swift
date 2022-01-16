//
//  CertificationDetailView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/11/22.
//

import SwiftUI

struct CertificationDetailView: View {
    @State private var dismissed: Bool = false
    @State private var showAlert: Bool = false
    @EnvironmentObject private var userViewModel: UserViewModel
    var certification: Certification
    
    var body: some View {
        ZStack {
            //Theme background
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                //Header
                VStack(alignment: .leading) {
                    Image(Certification.getCertificateImage(certificate: certification))
                        .resizable()
                        .scaledToFit()
                        .background(
                            Image("blobblur1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .offset(x: -180, y: -100)
                                .blur(radius: 100)
                                .opacity(self.dismissed ? 0 : 0.5)
                        )
                    
                    Text(certification.userCertificationType)
                        .font(.largeTitle.bold())
                }
                
                VStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Training Center")
                            .font(.caption2)
                        Text(certification.trainingCenter)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Date issued")
                                .font(.caption2)
                            Text(certification.dateIssued)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Expiration date")
                                .font(.caption2)
                            Text(certification.expiration)
                                .bold()
                        }
                    }
                    
                    Button(action: {}) {
                        HStack{
                            Image(systemName: "doc.fill")
                        }
                        
                        Text("Upload Certificate")
                    }
                    .foregroundColor(Color.primary)
                    .frame(maxWidth:.infinity)
                    .frame(height: 44)
                    .background(Color.primary.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 1)
                    )
                    .cornerRadius(12)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                )
                .background(
                    Color(#colorLiteral(red: 0.4564613104, green: 0.2352010906, blue: 0.483735919, alpha: 1))
                                .opacity(0.5)
                )
                .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterial))
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.2), radius: 40, x: 0, y: 20)
                
                //Blurred blob backgrounds
                .background(
                    Image("blobblur2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .offset(x: -100, y: 80)
                        .blur(radius: 70)
                        .opacity(self.dismissed ? 0 : 0.5)
                )
                
                .background(
                    Image("blobblur3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .offset(x: 80, y: -80)
                        .blur(radius: 70)
                        .opacity(self.dismissed ? 0 : 0.5)
                )
                
                
                Spacer()
            }
            .padding()
        }
//        .edgesIgnoringSafeArea(.top)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddCertificateView(certificate: certification)) {
                    SecondaryButton2(iconName: "pencil")
                    
                }
                
                Button(action: {
                    self.showAlert.toggle()
                }) {
                    SecondaryButton2(iconName: "trash.fill")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Delete"), message: Text("Are you sure your want to delete this certification? Your attached file will also be removed."), primaryButton: .destructive(Text("Delete")){
                        self.userViewModel.sessionStore.removeUserCertification(userCertificationID: certification.id!)
                    }, secondaryButton: .cancel())
                }
            }
        }
    }
}

struct CertificationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CertificationDetailView(certification: test_certificate)
                .preferredColorScheme(.dark)
        }
    }
}
