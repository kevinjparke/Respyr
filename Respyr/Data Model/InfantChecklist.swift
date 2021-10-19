//
//  InfantChecklist.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import Foundation

struct InfantChecklist: Decodable, Identifiable {
    var id: String
    var lastGradedBy: String
    var sessionID: String
    var userID: String
    var checksPulse: ChecklistItemState
    var checksBreathing: ChecklistItemState
    var checkResponsiveness: ChecklistItemState
    var performsCompressionsC1: ChecklistItemState
    var givesBreathsC1: ChecklistItemState
    var timeC1: String
    var performsCompressionsC2: ChecklistItemState
    var givesBreathsC2: ChecklistItemState
    var timeC2: String
    var performsCompressionsC3: ChecklistItemState
    var givesBreathsC3: ChecklistItemState
    var timeC3: String
    var shoutsHelp: ChecklistItemState
}
