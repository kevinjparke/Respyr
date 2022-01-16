//
//  CertificateCardView.swift
//  Respyr
//
//  Created by Kevin Parke on 11/30/21.
//

import SwiftUI

struct CertificateCardView: View {
    var certificate: Certification?
    var isArrayEmpty: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    if certificate != nil {
                        Text(certificate!.trainingCenter)
                            .font(.footnote)
                            .opacity(0.7)
                        
                        Text(certificate!.userCertificationType)
                            .font(.callout.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("Are you certified?")
                            .font(.footnote)
                            .opacity(0.7)
                        
                        Text("Update your certification details")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout.bold())
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 180)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .background(
                Color(#colorLiteral(red: 0.4564613104, green: 0.2352010906, blue: 0.483735919, alpha: 1))
                            .opacity(0.5)
            )
            .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterial))
            .cornerRadius(30)
            
            Image(Certification.getCertificateImage(certificate: certificate))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 170)
                .offset(y: -60)
        }
        
    }
}

let cert = Certification(userCertificationType: TrainingSessionType.PALSProvider.rawValue, trainingCenter: "St. George's University", dateIssued: "01/01/21", expiration: "01/01/23")

let certs: [Certification] = [
    Certification(userCertificationType: TrainingSessionType.PALSProvider.rawValue, trainingCenter: "St. George's University", dateIssued: "01/01/21", expiration: "01/01/23"),
    
    Certification(userCertificationType: TrainingSessionType.BLSProviderInstructor.rawValue, trainingCenter: "St. George's University", dateIssued: "01/01/21", expiration: "01/01/23")
]

struct CertificateCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CertificateCardView(certificate: cert)
//            .preferredColorScheme(.dark)
    }
}
