//
//  AdultChecklist.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation

enum ChecklistItemState: String, Decodable {
    case pass
    case neutral
    case fail
}

struct AdultChecklist: Identifiable, Decodable {
    var id: String
    var lastGradedBy: String
    var sessionID: String
    var userID: String
    var checksPulse: ChecklistItemState
    var checksBreathing: ChecklistItemState
    var checkResponsiveness: ChecklistItemState
    var shoutsHelp: ChecklistItemState
    var performsCompressionsC1: ChecklistItemState
    var givesBreathsC1: ChecklistItemState
    var timeC1: String
    var performsCompressionsC2: ChecklistItemState
    var givesBreathsC2: ChecklistItemState
    var timeC2: String
    var powersOnAED: ChecklistItemState
    var correctlyAttachesPads: ChecklistItemState
    var clearsAnalysis: ChecklistItemState
    var clearsSafety: ChecklistItemState
    var safeShock: ChecklistItemState
    var pass: Bool
    var remediate: Bool
}
