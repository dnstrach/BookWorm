//
//  Extensions.swift
//  Bookworm
//
//  Created by Dominique Strachan on 12/19/23.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty    
    }
}
