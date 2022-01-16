//
//  Checklist.swift
//  Respyr
//
//  Created by Kevin Parke on 12/30/21.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct Checklist: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var sessionType: String
    var lastGradedBy: String
    var sessionID: String
    var pass: Bool
    var fail: Bool
}
