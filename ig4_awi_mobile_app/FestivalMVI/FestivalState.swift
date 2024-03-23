//
//  FestivalState.swift
//  test
//
//  Created by etud on 22/03/2024.
//

enum FestivalState: Equatable {
    
    static func == (lhs: FestivalState, rhs: FestivalState) -> Bool {
        switch lhs{
        case .initial:
            if case .initial = rhs{
                return true
            }else{
                return false
            }
            
        case .loading:
            if case .loading = rhs{
                return true
            }else{
                return false
            }
            
        case .loaded:
            if case .loaded = rhs{
                return true
            }else{
                return false
            }
            
        case .isRegister:
            if case .isRegister = rhs{
                return true
            }else{
                return false
            }
            
        case .error:
            if case .error =
                rhs{
                return true
            }else{
                return false
            }
        }
    }
    
    case initial
    case loading
    case loaded(Festival)
    case isRegister
    case error(Error)
}
