//
//  PlanetView.swift
//  Xplora
//
//  Created by valentina balde on 11/17/25

import SwiftUI

struct PlanetView: View {
    @StateObject var viewModel: PlanetViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {

                Spacer()

                exploredCard
                    .padding(.horizontal)
                    .padding(.bottom, 24)
            }
        }
        .onAppear { viewModel.load() }
    }

    private var exploredCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Explored")
                        .font(.headline.weight(.bold))
                    Spacer()
                    Image(systemName: "plus")
                }

                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.exploredWorldPercent) %")
                            .font(.system(size: 32, weight: .semibold))
                        Text("World")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(viewModel.visitedCountriesCount)")
                            .font(.system(size: 32, weight: .semibold))
                        Text("Countries")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(.systemBackground).opacity(0.95))
        )
    }
}
