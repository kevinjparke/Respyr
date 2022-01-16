//
//  CertificationViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 12/31/21.
//

import Foundation
import Combine


class CertificationViewModel: ObservableObject {
    @Published var certifications: [Certification] = []
    @Published var trainingSessionType: String = ""
    @Published var trainingCenter: String = ""
    @Published var dateIssued: String = ""
    @Published var expiration: String = ""
    @Published var certificationsStatus: Bool = false
    private var sessionStore = SessionStore()
    private var cancelables = Set<AnyCancellable>()
    
    func fetchUserCertifications(userID: String) {
        self.sessionStore.fetchCertificates(userID: userID)
        self.sessionStore.$userCertificates
            .sink { error in
                //If an error is returned then there are no certs available for the user.
                self.certificationsStatus = false
            } receiveValue: { certs in
                self.certifications = certs
                self.certificationsStatus = true
            }
            .store(in: &cancelables)
    }
    
    func addUserCertification(userCertification: Certification) {
        self.sessionStore.addUserCertification(userCertification: userCertification)
        self.certifications.append(userCertification)
    }

    func removeUserCertification(userCertificateID: String) {
        self.sessionStore.removeUserCertification(userCertificationID: userCertificateID)
    }
    
    func updateUserCertification(userCertification: Certification) {
        self.sessionStore.updateUserCertification(userCertification: userCertification)
    }
}
