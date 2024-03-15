//
//  HoraireView.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 15/03/2024.
//

import SwiftUI

struct TrackLink: View {
    
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
                    
                }
                Spacer()
                //Image(systemName: "chevron.right").foregroundColor(Color(.systemGray3))
            }
        }.foregroundColor(.primary)
    }
}

struct TrackListView: View {

    @EnvironmentObject var router: Router
    
    @ObservedObject var tracks: TrackListModelView

    var body: some View {
        List{
            ForEach(Array(tracks), id: \.self){ track in
                TrackLink(track: track)
            }
            .onDelete { indexSet in
                tracks.remove(at: indexSet)
            }
        }
        .navigationTitle("Tracks")
    }
}
