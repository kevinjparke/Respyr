//
//  AlertViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/26/21.
//

import Foundation

class AlertViewModel: ObservableObject {
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertToggle: Bool = false
}
