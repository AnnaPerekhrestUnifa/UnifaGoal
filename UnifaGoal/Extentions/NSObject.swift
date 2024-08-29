//
//  NSObject.swift
//  FamilyApp
//
//  Created by vorona.vyacheslav on 2021/01/05.
//  Copyright © 2021 UniFa. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }
}
