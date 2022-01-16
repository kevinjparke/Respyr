//
//  CertificationsView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/9/22.
//

import SwiftUI

struct CertifictionListView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            //Background
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical) {
                VStack(spacing: 32) {
                    ForEach(userViewModel.certifications, id: \.self) {cert in
                        NavigationLink(destination: CertificationDetailView(certification: cert)) {
                            CertificateCardView(certificate: cert)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 52)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text("Certifications"))
        .toolbar {
            NavigationLink(destination: AddCertificateView()) {
                Image(systemName: "plus")
                    .font(.body.bold())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CertificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CertifictionListView()
        }
    }
}
