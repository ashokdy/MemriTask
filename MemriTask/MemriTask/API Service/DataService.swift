//
//  DataService.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import Foundation
import Combine
import Networking
import SwiftUI

struct DataService: APIService {
    var needsHeaders: Bool { false }
    func getData(_ path: APIPath) -> AnyPublisher<[DataResponse], Error> {
        requestAPI(path).eraseToAnyPublisher()
    }
}

struct DataAPI: APIPath {
    public var subURL: String { "chaitanyapandit/daede3d24d0f31541af1242e5454f39e/raw/86068da9ef2f043b06c4a0817047ec7865dd1d02/demo.json"
    }
}
