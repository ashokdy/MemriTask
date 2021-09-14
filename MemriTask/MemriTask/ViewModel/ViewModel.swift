//
//  ViewModel.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import Foundation
import Networking
import Combine
import SwiftUI

class ViewModel: ObservableObject {
    @Published var datamodel = [DataResponse]()
    @Binding var isLoading: Bool
    @Binding var showError: Bool
    @Binding var errorMessage: String

    var cancellables = [AnyCancellable]()
    
    init() {
        self._isLoading = .constant(true)
        self._showError = .constant(false)
        self._errorMessage = .constant("")
    }
    
    func getData() {
        isLoading = true
        let localTask = DataService().getData(DataAPI())
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?._isLoading = .constant(false)
                case .failure(let error):
                    self?._isLoading = .constant(false)
                    self?._showError = .constant(true)
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] model in
                self?._isLoading = .constant(false)
                self?.datamodel = model
            }
        cancellables.append(localTask)
    }
}
