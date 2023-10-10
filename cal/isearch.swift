//
//  search.swift
//  cal
//
//  Created by Rimah on 28/03/1445 AH.
//

import SwiftUI
import Combine

struct Stock: Identifiable, Hashable {
    
    let id: String
    let title: String
    //details:
    let RiskLevel: String
    let payoff: Double
    let FundManger: String
    let subscrbtionFee: Double
    let minLimit: Int
    // istock
    let istock: istockOption
    
    static let stocks : [Stock] = [
        Stock(id: "1", title: "صندوق الاهلي للمتاجرة بالريال السعودي", RiskLevel: "مستوى الخطورة: منخفض", payoff: 0.65 , FundManger: "شركة الاهلي للمتاجرة بالريال السعودي ",subscrbtionFee: 0.00 , minLimit: 5000 , istock: .alahli),
           ]
}

      

enum istockOption: String {
    
    case alahli, alistithmar, bmk, mefic, jazirah, yaaqen
    
}
//end of obj array

final class StocksManager {
    
    func getAllStocks() async throws -> [Stock] {
       
        [
            Stock(id: "1", title: "صندوق الاهلي للمتاجرة بالريال السعودي", RiskLevel: "مستوى الخطورة: منخفض", payoff: 0.65 , FundManger: "شركة الاهلي للمتاجرة بالريال السعودي ",subscrbtionFee: 0.00 , minLimit: 5000 , istock: .alahli),
            Stock(id: "2", title: "صندوق الاستثمار كابيتال للاسهم السعودية", RiskLevel: "مستوى الخطورة: عالي", payoff: 1.75 , FundManger: "شركة الاستثمار للاوراق المالية و الوساطة", subscrbtionFee: 1.00 , minLimit: 5000 , istock: .alistithmar),
            Stock(id: "3", title: "صندوق البيت المال الخليجي للاسهم السعودية", RiskLevel: "مستوى الخطورة: عالي", payoff: 1.9 , FundManger: "بيت المال الخليجي", subscrbtionFee: 2.0 , minLimit: 2000 , istock: .bmk),
            Stock(id: "4", title: "صندوق ميفك المرن للاسهم السعودية", RiskLevel: "مستوى الخطورة: متوسط", payoff: 1.75 , FundManger: "شركة الشرق الاوسط للاستثمار المالي", subscrbtionFee: 0.00 , minLimit: 2000 ,istock: .mefic),
            Stock(id: "5", title: "صندوق الجزيرة للمرابحة بالريال السعودي", RiskLevel: "مستوى الخطورة: منخفض", payoff: 15 , FundManger: "الجزيرة للاسواق الادارية", subscrbtionFee: 0.00 , minLimit: 2000 , istock: .jazirah),
            Stock(id: "6", title: "يقين للاسهم السعودية", RiskLevel: "مستوى الخطورة: عالي", payoff: 1.75 , FundManger: "يقين كابيتال", subscrbtionFee: 1.50, minLimit: 0, istock: .yaaqen),
        ]
    }
}
@MainActor
final class searchableViewModel: ObservableObject {
    
     
    @Published private(set) var allStocks: [Stock] = []
    @Published private(set) var filterStocks: [Stock] = []
    @Published var searchText: String = ""
    @Published var searchScope: SearchScopeOption = .all
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    let manager = StocksManager()
    private var cancellable = Set<AnyCancellable>()
    
    var isSearching: Bool {
        searchText.isEmpty
    }
    var ShowSearchSuggestions: Bool {
        searchText.count < 5
    }
    enum SearchScopeOption: Hashable {
        case all
        case istock(option: istockOption)
        
        var title: String {
            switch self {
            case .all:
                return "الكل"
            case .istock(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    init() {
        addFollowers()
    }
    private func addFollowers() {
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText, searchScope) in
                self?.filterStocks(searchText: searchText, currentSeachScope: searchScope)
            }
            .store(in: &cancellable)
    }
    private func filterStocks(searchText: String, currentSeachScope: SearchScopeOption) {
        guard !searchText.isEmpty else {
            filterStocks = []
            searchScope = .all
            return
        }
        
        // filter on search scope
        var stocksinScope = allStocks
        switch currentSeachScope {
        case .all:
            break
        case .istock(let option):
            stocksinScope = allStocks.filter({ $0.istock == option})
        }
        
        // filter on search text
        let search = searchText.lowercased()
        filterStocks = stocksinScope.filter({ Stock in
            let titleContainsSearch = Stock.title.lowercased().contains(search)
            let istockContainsSearch = Stock.istock.rawValue.lowercased().contains(search)
            return titleContainsSearch || istockContainsSearch
        })
    }
    func LoadStocks() async {
        do {
            allStocks = try await manager.getAllStocks()
            
            let allStocks = Set(allStocks.map {$0.istock})
            allSearchScopes = [.all] + allStocks.map ({SearchScopeOption.istock(option: $0)})
            
        } catch {
            print(error)
        }
    }
    
    func getSearchSuggestions() -> [String] {
        guard ShowSearchSuggestions else {
            return []
        }
        var suggestions: [String] = []
        
        let search = searchText.lowercased()
        if search.contains("الاه") {
            suggestions.append("الاهلي")
        }
        if search.contains("الاس") {
            suggestions.append("الاستثمار كابيتال")
        }
        if search.contains("الب") {
            suggestions.append("صندوق البيت")
        }
        if search.contains("مي") {
            suggestions.append("صندوق ميفك المرن")
        }
        if search.contains("الج") {
            suggestions.append("صندوق الجزيرة للمرابحة")
        }
        if search.contains("يق") {
            suggestions.append("يقين للاسهم السعودية")
        }
        suggestions.append(istockOption.alahli.rawValue.capitalized)
        suggestions.append(istockOption.alistithmar.rawValue.capitalized)
        suggestions.append(istockOption.bmk.rawValue.capitalized)
        suggestions.append(istockOption.mefic.rawValue.capitalized)
        suggestions.append(istockOption.jazirah.rawValue.capitalized)
        suggestions.append(istockOption.yaaqen.rawValue.capitalized)
        
        return suggestions
    }
    func getStocksSuggestions() -> [Stock] {
        guard ShowSearchSuggestions else {
            return []
        }
        var suggestions: [Stock] = []
        
        let search = searchText.lowercased()
        if search.contains("الاه") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .alahli }))
        }
        if search.contains("الاس") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .alistithmar }))
        }
        if search.contains("الب") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .bmk }))
        }
        if search.contains("مي") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .mefic }))
        }
        if search.contains("الجز") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .jazirah }))
        }
        if search.contains("يق") {
            suggestions.append(contentsOf: allStocks.filter({$0.istock == .yaaqen }))
        }
        return suggestions
    }
}
    struct isearch: View {
        @StateObject private var viewModel = searchableViewModel()


        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.isSearching ? viewModel.allStocks : viewModel.filterStocks) { Stock in
                            NavigationLink(value: Stock) {
                                StocksRow(stock: Stock)
                            }
                    }
                    
                }
                .padding()
                //            Text("viewModel is searching: \(viewModel.isSearching.description)")
                //            searchChildView()
            }
            
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search Stock..."))
            .searchScopes($viewModel.searchScope, scopes: {
                ForEach(viewModel.allSearchScopes, id: \.self) { scope in
                    Text(scope.title)
                        .tag(scope)
                }
            })
            .searchSuggestions({
                ForEach(viewModel.getSearchSuggestions(), id: \.self) { suggestions in
                    Text(suggestions)
                        .searchCompletion(suggestions)
                    
                }
                ForEach(viewModel.getStocksSuggestions(), id: \.self) { suggestions in
                    NavigationLink(value: suggestions) {
                        Text(suggestions.title)
                           
                        
                    }
                }
                
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("أكتشف")
            
            .task {
                await viewModel.LoadStocks()
            }
            .navigationDestination(for: Stock.self) { stock in
  Form {
                    Text(stock.title.uppercased())
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .foregroundStyle(.green)
                        .padding()
                    // print details
                    Text(stock.RiskLevel.uppercased())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .padding()
                    
                    Text(stock.payoff.description.uppercased())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .padding()
                    
                    Text(stock.FundManger.description.uppercased())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .padding()
                    
                    Text(stock.subscrbtionFee.description.uppercased())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .padding()
                    
                    Text(stock.minLimit.description.uppercased())
     
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .environment(\.layoutDirection, .rightToLeft)
                        .padding()
  }
                
            }
        }
        
        private func StocksRow (stock: Stock) -> some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(stock.title)
                    .font(.headline)
                    .foregroundStyle(.green)
                Text(stock.istock.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
            }
            
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .tint(.primary)
            .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
        }
    }

    
    struct searchChildView: View {
        @Environment(\.isSearching) private var isSearching
        
        var body: some View {
            Text("Child view is searching: \(isSearching.description)")
        }
    }

    #Preview {
        NavigationStack {
            isearch()
                .environment(\.layoutDirection, .rightToLeft)
                .background(Color.black.opacity(0.05))
        }
    }
