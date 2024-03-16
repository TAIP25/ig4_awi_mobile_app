//
//  HoraireView.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 15/03/2024.
//
/*
import SwiftUI

struct HoraireView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var horaire: HoraireViewModel
    
    var body: some View {
        Button{
            router.navigate(to: .track(horaire))
        } label: {
            HStack(spacing: 0) {
                VStack(alignment: .leading){
                    //Text(horaire.hD+"-"+horaire.hF.).bold()
                    Text(horaire.hashValue).bold()
                    Text(horaire.hD)
                }
                Spacer()
                //Image(systemName: "chevron.right").foregroundColor(Color(.systemGray3))
            }
        }.foregroundColor(.primary)
    }
}

struct TrackListView: View {

    @EnvironmentObject var router: Router
    
    @ObservedObject var horaires: TrackListModelView

    var body: some View {
        List{
            ForEach(Array(horaires), id: \.self){ horaire in
                HoraireView(horaire: horaire)
            }
            .onDelete { indexSet in
                tracks.remove(at: indexSet)
            }
        }
        .navigationTitle("Tracks")
    }
}
*/
