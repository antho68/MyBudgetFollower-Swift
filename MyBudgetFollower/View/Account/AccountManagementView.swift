//
//  AccountManagementView.swift
//  MyBudgetFollower
//
//  Created by Anthony Baumle on 01/10/2024.
//

import SwiftUI

struct AccountManagementView: View {
	@State private var accounts: [Account] = []
	@State private var selectedAccount: Account? = nil
	@State private var isShowingDetailSheet = false
	@State private var isShowingAddAccountSheet = false
	
	var body: some View {
		NavigationView {
			List(accounts, id: \.id) { account in
				Button(action: {
					selectedAccount = account
					isShowingDetailSheet = true
				}) {
					VStack(alignment: .leading) {
						Text(account.accountName)
						Text(account.accountDescription ?? "Pas de description")
							.font(.subheadline)
							.foregroundColor(.gray)
					}
				}
			}
			.navigationTitle("Gestion des comptes")
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Button(action: {
						isShowingAddAccountSheet = true
					}) {
						Image(systemName: "plus")
					}
				}
			}
			.onAppear {
				Task {
					await loadAccounts()
				}
			}
			.sheet(isPresented: $isShowingDetailSheet, content: {
				if let account = selectedAccount {
					AccountDetailView(account: account)
				}
			})
			.sheet(isPresented: $isShowingAddAccountSheet, content: {
				AddAccountView(isPresented: $isShowingAddAccountSheet) {
					Task {
						await loadAccounts()
					}
				}
			})
		}
	}
	
	// Charger les comptes depuis Supabase
	func loadAccounts() async {
		let fetchedAccounts = await AccountService.shared.fetchAllAccounts()
		DispatchQueue.main.async {
			accounts = fetchedAccounts
		}
	}
}

#Preview {
	AccountManagementView()
}
