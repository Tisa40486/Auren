import Foundation
import SwiftUI
import Combine

enum LocalizedKey {
    // Navigation & Common
    case home
    case accounts
    case settings
    case logOut
    case cancel
    case retry
    case loading
    case orText
    case delete
    case unknown

    // Auth & Onboarding
    case appTagline
    case connect
    case createAnAccount
    case createAccountTitle
    case createAccountSubtitle
    case username
    case email
    case password
    case confirmPassword

    // Dashboard & Flow
    case greeting(String)
    case totalBalance
    case income
    case expenses
    case cashFlow
    case byCategory
    case netFlow
    case totalExpenses
    case noTransactionsChart
    case noCategoryExpenses
    case myAccounts
    case add
    case noAccountsConfigured
    case addAccountButton
    case recentTransactions
    case noRecentTransactions
    case loadingDashboard

    // Accounts
    case loadingAccounts
    case unableToLoadAccounts
    case noAccountsYet
    case noAccountsDescription
    case account
    case addTransaction
    case transactions
    case noTransactions
    case noTransactionsDescription
    case noComment

    // Create Account & Financial Account
    case newBankAccount
    case accountName
    case creating
    case createAccountButton

    // Create Transaction
    case newTransaction
    case transaction
    case type
    case deposit
    case withdrawal
    case transfer
    case amount
    case comment
    case category
    case selectCategory
    case createTransactionButton

    // Settings
    case general
    case appLanguageTitle
    case languageFooter
    case appearance
    case theme
    case about
    case version

    // Errors
    case errFillAllFields
    case errInvalidCredentials
    case errUserNotLoggedIn
    case errLoadAccounts
    case errDeleteAccount
    case errCreateBankAccount
    case errLoadTransactions
    case errLoadCategories
    case errInvalidAmount
    case errEnterAmount
    case errCreateTransaction
    case errInvalidURL
    case errInvalidResponse

    func string(for language: AppLanguage) -> String {
        switch self {
        // MARK: Navigation & Common
        case .home:
            switch language {
            case .french: return "Accueil"
            case .english: return "Home"
            case .spanish: return "Inicio"
            case .german: return "Startseite"
            case .italian: return "Home"
            case .system: return "Accueil"
            }
        case .accounts:
            switch language {
            case .french: return "Comptes"
            case .english: return "Accounts"
            case .spanish: return "Cuentas"
            case .german: return "Konten"
            case .italian: return "Conti"
            case .system: return "Comptes"
            }
        case .settings:
            switch language {
            case .french: return "Paramètres"
            case .english: return "Settings"
            case .spanish: return "Ajustes"
            case .german: return "Einstellungen"
            case .italian: return "Impostazioni"
            case .system: return "Paramètres"
            }
        case .logOut:
            switch language {
            case .french: return "Déconnexion"
            case .english: return "Log Out"
            case .spanish: return "Cerrar sesión"
            case .german: return "Abmelden"
            case .italian: return "Disconnetti"
            case .system: return "Déconnexion"
            }
        case .cancel:
            switch language {
            case .french: return "Annuler"
            case .english: return "Cancel"
            case .spanish: return "Cancelar"
            case .german: return "Abbrechen"
            case .italian: return "Annulla"
            case .system: return "Annuler"
            }
        case .retry:
            switch language {
            case .french: return "Réessayer"
            case .english: return "Retry"
            case .spanish: return "Reintentar"
            case .german: return "Wiederholen"
            case .italian: return "Riprova"
            case .system: return "Réessayer"
            }
        case .loading:
            switch language {
            case .french: return "Chargement…"
            case .english: return "Loading…"
            case .spanish: return "Cargando…"
            case .german: return "Laden…"
            case .italian: return "Caricamento…"
            case .system: return "Chargement…"
            }
        case .orText:
            switch language {
            case .french: return "ou"
            case .english: return "or"
            case .spanish: return "o"
            case .german: return "oder"
            case .italian: return "o"
            case .system: return "ou"
            }
        case .delete:
            switch language {
            case .french: return "Supprimer"
            case .english: return "Delete"
            case .spanish: return "Eliminar"
            case .german: return "Löschen"
            case .italian: return "Elimina"
            case .system: return "Supprimer"
            }
        case .unknown:
            switch language {
            case .french: return "Inconnu"
            case .english: return "Unknown"
            case .spanish: return "Desconocido"
            case .german: return "Unbekannt"
            case .italian: return "Sconosciuto"
            case .system: return "Inconnu"
            }

        // MARK: Auth & Onboarding
        case .appTagline:
            switch language {
            case .french: return "Une seule application pour gérer votre vie."
            case .english: return "One app to manage your life."
            case .spanish: return "Una aplicación para gestionar tu vida."
            case .german: return "Eine App, um Ihr Leben zu verwalten."
            case .italian: return "Un'unica app per gestire la tua vita."
            case .system: return "Une seule application pour gérer votre vie."
            }
        case .connect:
            switch language {
            case .french: return "Se connecter"
            case .english: return "Connect"
            case .spanish: return "Conectar"
            case .german: return "Verbinden"
            case .italian: return "Accedi"
            case .system: return "Se connecter"
            }
        case .createAnAccount:
            switch language {
            case .french: return "Créer un compte"
            case .english: return "Create an account"
            case .spanish: return "Crear una cuenta"
            case .german: return "Konto erstellen"
            case .italian: return "Crea un account"
            case .system: return "Créer un compte"
            }
        case .createAccountTitle:
            switch language {
            case .french: return "Créer un compte"
            case .english: return "Create Account"
            case .spanish: return "Crear cuenta"
            case .german: return "Konto erstellen"
            case .italian: return "Crea account"
            case .system: return "Créer un compte"
            }
        case .createAccountSubtitle:
            switch language {
            case .french: return "Créez votre compte pour continuer"
            case .english: return "Create your account to continue"
            case .spanish: return "Cree su cuenta para continuar"
            case .german: return "Erstellen Sie Ihr Konto, um fortzufahren"
            case .italian: return "Crea il tuo account per continuare"
            case .system: return "Créez votre compte pour continuer"
            }
        case .username:
            switch language {
            case .french: return "Nom d'utilisateur"
            case .english: return "Username"
            case .spanish: return "Nombre de usuario"
            case .german: return "Benutzername"
            case .italian: return "Nome utente"
            case .system: return "Nom d'utilisateur"
            }
        case .email:
            switch language {
            case .french: return "Email"
            case .english: return "Email"
            case .spanish: return "Correo electrónico"
            case .german: return "E-Mail"
            case .italian: return "Email"
            case .system: return "Email"
            }
        case .password:
            switch language {
            case .french: return "Mot de passe"
            case .english: return "Password"
            case .spanish: return "Contraseña"
            case .german: return "Passwort"
            case .italian: return "Password"
            case .system: return "Mot de passe"
            }
        case .confirmPassword:
            switch language {
            case .french: return "Confirmer le mot de passe"
            case .english: return "Confirm Password"
            case .spanish: return "Confirmar contraseña"
            case .german: return "Passwort bestätigen"
            case .italian: return "Conferma password"
            case .system: return "Confirmer le mot de passe"
            }

        // MARK: Dashboard & Flow
        case .greeting(let name):
            switch language {
            case .french: return "Bonjour, \(name)"
            case .english: return "Hello, \(name)"
            case .spanish: return "Hola, \(name)"
            case .german: return "Hallo, \(name)"
            case .italian: return "Ciao, \(name)"
            case .system: return "Bonjour, \(name)"
            }
        case .totalBalance:
            switch language {
            case .french: return "Solde total"
            case .english: return "Total balance"
            case .spanish: return "Saldo total"
            case .german: return "Gesamtsaldo"
            case .italian: return "Saldo totale"
            case .system: return "Solde total"
            }
        case .income:
            switch language {
            case .french: return "Entrées"
            case .english: return "Income"
            case .spanish: return "Ingresos"
            case .german: return "Einnahmen"
            case .italian: return "Entrate"
            case .system: return "Entrées"
            }
        case .expenses:
            switch language {
            case .french: return "Dépenses"
            case .english: return "Expenses"
            case .spanish: return "Gastos"
            case .german: return "Ausgaben"
            case .italian: return "Uscite"
            case .system: return "Dépenses"
            }
        case .cashFlow:
            switch language {
            case .french: return "Flux"
            case .english: return "Cash Flow"
            case .spanish: return "Flujo"
            case .german: return "Geldfluss"
            case .italian: return "Flusso"
            case .system: return "Flux"
            }
        case .byCategory:
            switch language {
            case .french: return "Par catégorie"
            case .english: return "By category"
            case .spanish: return "Por categoría"
            case .german: return "Nach Kategorie"
            case .italian: return "Per categoria"
            case .system: return "Par catégorie"
            }
        case .netFlow:
            switch language {
            case .french: return "Flux net"
            case .english: return "Net flow"
            case .spanish: return "Flujo neto"
            case .german: return "Nettofluss"
            case .italian: return "Flusso netto"
            case .system: return "Flux net"
            }
        case .totalExpenses:
            switch language {
            case .french: return "Total Dépenses"
            case .english: return "Total Expenses"
            case .spanish: return "Gastos totales"
            case .german: return "Gesamtausgaben"
            case .italian: return "Totale Uscite"
            case .system: return "Total Dépenses"
            }
        case .noTransactionsChart:
            switch language {
            case .french: return "Aucune transaction enregistrée pour afficher le camembert de flux."
            case .english: return "No transactions recorded to display the flow chart."
            case .spanish: return "No hay transacciones registradas para mostrar el gráfico de flujo."
            case .german: return "Keine Transaktionen aufgezeichnet, um das Flussdiagramm anzuzeigen."
            case .italian: return "Nessuna transazione registrata per visualizzare il grafico del flusso."
            case .system: return "Aucune transaction enregistrée pour afficher le camembert de flux."
            }
        case .noCategoryExpenses:
            switch language {
            case .french: return "Aucune dépense catégorisée pour le moment."
            case .english: return "No categorized expenses for now."
            case .spanish: return "No hay gastos categorizados por el momento."
            case .german: return "Bisher keine kategorisierten Ausgaben."
            case .italian: return "Nessuna spesa categorizzata per ora."
            case .system: return "Aucune dépense catégorisée pour le moment."
            }
        case .myAccounts:
            switch language {
            case .french: return "Mes comptes"
            case .english: return "My Accounts"
            case .spanish: return "Mis cuentas"
            case .german: return "Meine Konten"
            case .italian: return "I miei conti"
            case .system: return "Mes comptes"
            }
        case .add:
            switch language {
            case .french: return "Ajouter"
            case .english: return "Add"
            case .spanish: return "Añadir"
            case .german: return "Hinzufügen"
            case .italian: return "Aggiungi"
            case .system: return "Ajouter"
            }
        case .noAccountsConfigured:
            switch language {
            case .french: return "Aucun compte bancaire configuré"
            case .english: return "No bank account configured"
            case .spanish: return "No hay cuentas bancarias configuradas"
            case .german: return "Kein Bankkonto eingerichtet"
            case .italian: return "Nessun conto bancario configurato"
            case .system: return "Aucun compte bancaire configuré"
            }
        case .addAccountButton:
            switch language {
            case .french: return "Ajouter un compte"
            case .english: return "Add Account"
            case .spanish: return "Añadir cuenta"
            case .german: return "Konto hinzufügen"
            case .italian: return "Aggiungi conto"
            case .system: return "Ajouter un compte"
            }
        case .recentTransactions:
            switch language {
            case .french: return "Transactions récentes"
            case .english: return "Recent Transactions"
            case .spanish: return "Transacciones recientes"
            case .german: return "Letzte Transaktionen"
            case .italian: return "Transazioni recenti"
            case .system: return "Transactions récentes"
            }
        case .noRecentTransactions:
            switch language {
            case .french: return "Aucune transaction récente"
            case .english: return "No recent transactions"
            case .spanish: return "Sin transacciones recientes"
            case .german: return "Keine aktuellen Transaktionen"
            case .italian: return "Nessuna transazione recente"
            case .system: return "Aucune transaction récente"
            }
        case .loadingDashboard:
            switch language {
            case .french: return "Chargement de votre tableau de bord…"
            case .english: return "Loading your dashboard…"
            case .spanish: return "Cargando su panel…"
            case .german: return "Ihr Dashboard wird geladen…"
            case .italian: return "Caricamento della dashboard…"
            case .system: return "Chargement de votre tableau de bord…"
            }

        // MARK: Accounts
        case .loadingAccounts:
            switch language {
            case .french: return "Chargement des comptes…"
            case .english: return "Loading accounts…"
            case .spanish: return "Cargando cuentas…"
            case .german: return "Konten laden…"
            case .italian: return "Caricamento conti…"
            case .system: return "Chargement des comptes…"
            }
        case .unableToLoadAccounts:
            switch language {
            case .french: return "Impossible de charger les comptes"
            case .english: return "Unable to Load Accounts"
            case .spanish: return "No se pueden cargar las cuentas"
            case .german: return "Konten konnten nicht geladen werden"
            case .italian: return "Impossibile caricare i conti"
            case .system: return "Impossible de charger les comptes"
            }
        case .noAccountsYet:
            switch language {
            case .french: return "Aucun compte pour le moment"
            case .english: return "No Accounts Yet"
            case .spanish: return "Aún no hay cuentas"
            case .german: return "Noch keine Konten"
            case .italian: return "Nessun conto al momento"
            case .system: return "Aucun compte pour le moment"
            }
        case .noAccountsDescription:
            switch language {
            case .french: return "Créez un compte pour commencer à suivre vos finances."
            case .english: return "Create an account to start tracking your finances."
            case .spanish: return "Cree una cuenta para comenzar a realizar un seguimiento de sus finanzas."
            case .german: return "Erstellen Sie ein Konto, um Ihre Finanzen zu verwalten."
            case .italian: return "Crea un conto per iniziare a monitorare le tue finanze."
            case .system: return "Créez un compte pour commencer à suivre vos finances."
            }
        case .account:
            switch language {
            case .french: return "Compte"
            case .english: return "Account"
            case .spanish: return "Cuenta"
            case .german: return "Konto"
            case .italian: return "Conto"
            case .system: return "Compte"
            }
        case .addTransaction:
            switch language {
            case .french: return "Ajouter une transaction"
            case .english: return "Add Transaction"
            case .spanish: return "Añadir transacción"
            case .german: return "Transaktion hinzufügen"
            case .italian: return "Aggiungi transazione"
            case .system: return "Ajouter une transaction"
            }
        case .transactions:
            switch language {
            case .french: return "Transactions"
            case .english: return "Transactions"
            case .spanish: return "Transacciones"
            case .german: return "Transaktionen"
            case .italian: return "Transazioni"
            case .system: return "Transactions"
            }
        case .noTransactions:
            switch language {
            case .french: return "Aucune transaction"
            case .english: return "No Transactions"
            case .spanish: return "Sin transacciones"
            case .german: return "Keine Transaktionen"
            case .italian: return "Nessuna transazione"
            case .system: return "Aucune transaction"
            }
        case .noTransactionsDescription:
            switch language {
            case .french: return "Les transactions que vous ajoutez apparaîtront ici."
            case .english: return "Transactions you add will appear here."
            case .spanish: return "Las transacciones que agregue aparecerán aquí."
            case .german: return "Hinzugefügte Transaktionen werden hier angezeigt."
            case .italian: return "Le transazioni aggiunte appariranno qui."
            case .system: return "Les transactions que vous ajoutez apparaîtront ici."
            }
        case .noComment:
            switch language {
            case .french: return "Sans commentaire"
            case .english: return "No comment"
            case .spanish: return "Sin comentario"
            case .german: return "Kein Kommentar"
            case .italian: return "Nessun commento"
            case .system: return "Sans commentaire"
            }

        // MARK: Create Account & Financial Account
        case .newBankAccount:
            switch language {
            case .french: return "Nouveau compte bancaire"
            case .english: return "New Bank Account"
            case .spanish: return "Nueva cuenta bancaria"
            case .german: return "Neues Bankkonto"
            case .italian: return "Nuovo conto bancario"
            case .system: return "Nouveau compte bancaire"
            }
        case .accountName:
            switch language {
            case .french: return "Nom du compte"
            case .english: return "Account Name"
            case .spanish: return "Nombre de la cuenta"
            case .german: return "Kontoname"
            case .italian: return "Nome del conto"
            case .system: return "Nom du compte"
            }
        case .creating:
            switch language {
            case .french: return "Création en cours…"
            case .english: return "Creating…"
            case .spanish: return "Creando…"
            case .german: return "Wird erstellt…"
            case .italian: return "Creazione in corso…"
            case .system: return "Création en cours…"
            }
        case .createAccountButton:
            switch language {
            case .french: return "Créer le compte"
            case .english: return "Create Account"
            case .spanish: return "Crear cuenta"
            case .german: return "Konto erstellen"
            case .italian: return "Crea conto"
            case .system: return "Créer le compte"
            }

        // MARK: Create Transaction
        case .newTransaction:
            switch language {
            case .french: return "Nouvelle transaction"
            case .english: return "New Transaction"
            case .spanish: return "Nueva transacción"
            case .german: return "Neue Transaktion"
            case .italian: return "Nuova transazione"
            case .system: return "Nouvelle transaction"
            }
        case .transaction:
            switch language {
            case .french: return "Transaction"
            case .english: return "Transaction"
            case .spanish: return "Transacción"
            case .german: return "Transaktion"
            case .italian: return "Transazione"
            case .system: return "Transaction"
            }
        case .type:
            switch language {
            case .french: return "Type"
            case .english: return "Type"
            case .spanish: return "Tipo"
            case .german: return "Typ"
            case .italian: return "Tipo"
            case .system: return "Type"
            }
        case .deposit:
            switch language {
            case .french: return "Dépôt"
            case .english: return "Deposit"
            case .spanish: return "Depósito"
            case .german: return "Einzahlung"
            case .italian: return "Deposito"
            case .system: return "Dépôt"
            }
        case .withdrawal:
            switch language {
            case .french: return "Retrait"
            case .english: return "Withdrawal"
            case .spanish: return "Retiro"
            case .german: return "Auszahlung"
            case .italian: return "Prelievo"
            case .system: return "Retrait"
            }
        case .transfer:
            switch language {
            case .french: return "Virement"
            case .english: return "Transfer"
            case .spanish: return "Transferencia"
            case .german: return "Überweisung"
            case .italian: return "Trasferimento"
            case .system: return "Virement"
            }
        case .amount:
            switch language {
            case .french: return "Montant"
            case .english: return "Amount"
            case .spanish: return "Monto"
            case .german: return "Betrag"
            case .italian: return "Importo"
            case .system: return "Montant"
            }
        case .comment:
            switch language {
            case .french: return "Commentaire"
            case .english: return "Comment"
            case .spanish: return "Comentario"
            case .german: return "Kommentar"
            case .italian: return "Commento"
            case .system: return "Commentaire"
            }
        case .category:
            switch language {
            case .french: return "Catégorie"
            case .english: return "Category"
            case .spanish: return "Categoría"
            case .german: return "Kategorie"
            case .italian: return "Categoria"
            case .system: return "Catégorie"
            }
        case .selectCategory:
            switch language {
            case .french: return "Sélectionner une catégorie"
            case .english: return "Select a category"
            case .spanish: return "Seleccionar una categoría"
            case .german: return "Kategorie auswählen"
            case .italian: return "Seleziona una categoria"
            case .system: return "Sélectionner une catégorie"
            }
        case .createTransactionButton:
            switch language {
            case .french: return "Créer la transaction"
            case .english: return "Create Transaction"
            case .spanish: return "Crear transacción"
            case .german: return "Transaktion erstellen"
            case .italian: return "Crea transazione"
            case .system: return "Créer la transaction"
            }

        // MARK: Settings
        case .general:
            switch language {
            case .french: return "Général"
            case .english: return "General"
            case .spanish: return "General"
            case .german: return "Allgemein"
            case .italian: return "Generale"
            case .system: return "Général"
            }
        case .appLanguageTitle:
            switch language {
            case .french: return "Langue de l'application"
            case .english: return "App Language"
            case .spanish: return "Idioma de la aplicación"
            case .german: return "App-Sprache"
            case .italian: return "Lingua dell'app"
            case .system: return "Langue de l'application"
            }
        case .languageFooter:
            switch language {
            case .french: return "La langue sélectionnée s'applique à l'ensemble de l'interface, aux dates et aux formats numériques."
            case .english: return "The selected language applies to the entire interface, dates, and number formats."
            case .spanish: return "El idioma seleccionado se aplica a toda la interfaz, fechas y formatos numéricos."
            case .german: return "Die ausgewählte Sprache gilt für die gesamte Benutzeroberfläche, Datums- und Zahlenformate."
            case .italian: return "La lingua selezionata si applica all'intera interfaccia, alle date e ai formati numerici."
            case .system: return "La langue sélectionnée s'applique à l'ensemble de l'interface, aux dates et aux formats numériques."
            }
        case .appearance:
            switch language {
            case .french: return "Apparence"
            case .english: return "Appearance"
            case .spanish: return "Apariencia"
            case .german: return "Erscheinungsbild"
            case .italian: return "Aspetto"
            case .system: return "Apparence"
            }
        case .theme:
            switch language {
            case .french: return "Thème"
            case .english: return "Theme"
            case .spanish: return "Tema"
            case .german: return "Design"
            case .italian: return "Tema"
            case .system: return "Thème"
            }
        case .about:
            switch language {
            case .french: return "À propos"
            case .english: return "About"
            case .spanish: return "Acerca de"
            case .german: return "Über"
            case .italian: return "Informazioni"
            case .system: return "À propos"
            }
        case .version:
            switch language {
            case .french: return "Version"
            case .english: return "Version"
            case .spanish: return "Versión"
            case .german: return "Version"
            case .italian: return "Versione"
            case .system: return "Version"
            }

        // MARK: Errors
        case .errFillAllFields:
            switch language {
            case .french: return "Veuillez remplir tous les champs"
            case .english: return "Please fill in all the fields"
            case .spanish: return "Por favor, complete todos los campos"
            case .german: return "Bitte füllen Sie alle Felder aus"
            case .italian: return "Si prega di compilare tutti i campi"
            case .system: return "Veuillez remplir tous les champs"
            }
        case .errInvalidCredentials:
            switch language {
            case .french: return "Identifiants incorrects ou utilisateur inconnu"
            case .english: return "Incorrect credentials or unknown user"
            case .spanish: return "Credenciales incorrectas o usuario desconocido"
            case .german: return "Falsche Anmeldedaten oder unbekannter Benutzer"
            case .italian: return "Credenziali errate o utente sconosciuto"
            case .system: return "Identifiants incorrects ou utilisateur inconnu"
            }
        case .errUserNotLoggedIn:
            switch language {
            case .french: return "Utilisateur non connecté"
            case .english: return "User not logged in"
            case .spanish: return "Usuario no conectado"
            case .german: return "Benutzer nicht angemeldet"
            case .italian: return "Utente non connesso"
            case .system: return "Utilisateur non connecté"
            }
        case .errLoadAccounts:
            switch language {
            case .french: return "Impossible de charger les comptes"
            case .english: return "Unable to load accounts"
            case .spanish: return "No se pueden cargar las cuentas"
            case .german: return "Konten konnten nicht geladen werden"
            case .italian: return "Impossibile caricare i conti"
            case .system: return "Impossible de charger les comptes"
            }
        case .errDeleteAccount:
            switch language {
            case .french: return "Erreur lors de la suppression du compte"
            case .english: return "Error deleting account"
            case .spanish: return "Error al eliminar la cuenta"
            case .german: return "Fehler beim Löschen des Kontos"
            case .italian: return "Errore durante l'eliminazione del conto"
            case .system: return "Erreur lors de la suppression du compte"
            }
        case .errCreateBankAccount:
            switch language {
            case .french: return "Impossible de créer le compte bancaire"
            case .english: return "Unable to create bank account"
            case .spanish: return "No se puede crear la cuenta bancaria"
            case .german: return "Bankkonto konnte nicht erstellt werden"
            case .italian: return "Impossibile creare il conto bancario"
            case .system: return "Impossible de créer le compte bancaire"
            }
        case .errLoadTransactions:
            switch language {
            case .french: return "Impossible de charger les transactions"
            case .english: return "Unable to load transactions"
            case .spanish: return "No se pueden cargar las transacciones"
            case .german: return "Transaktionen konnten nicht geladen werden"
            case .italian: return "Impossibile caricare le transazioni"
            case .system: return "Impossible de charger les transactions"
            }
        case .errLoadCategories:
            switch language {
            case .french: return "Impossible de charger les catégories"
            case .english: return "Unable to load categories"
            case .spanish: return "No se pueden cargar las categorías"
            case .german: return "Kategorien konnten nicht geladen werden"
            case .italian: return "Impossibile caricare le categorie"
            case .system: return "Impossible de charger les catégories"
            }
        case .errInvalidAmount:
            switch language {
            case .french: return "Montant invalide"
            case .english: return "Invalid amount"
            case .spanish: return "Monto no válido"
            case .german: return "Ungültiger Betrag"
            case .italian: return "Importo non valido"
            case .system: return "Montant invalide"
            }
        case .errEnterAmount:
            switch language {
            case .french: return "Veuillez saisir un montant"
            case .english: return "Please enter an amount"
            case .spanish: return "Por favor, introduzca un monto"
            case .german: return "Bitte geben Sie einen Betrag ein"
            case .italian: return "Si prega di inserire un importo"
            case .system: return "Veuillez saisir un montant"
            }
        case .errCreateTransaction:
            switch language {
            case .french: return "Échec de la création de la transaction"
            case .english: return "Failed to create transaction"
            case .spanish: return "Error al crear la transacción"
            case .german: return "Fehler beim Erstellen der Transaktion"
            case .italian: return "Impossibile creare la transazione"
            case .system: return "Échec de la création de la transaction"
            }
        case .errInvalidURL:
            switch language {
            case .french: return "URL invalide"
            case .english: return "Invalid URL"
            case .spanish: return "URL no válida"
            case .german: return "Ungültige URL"
            case .italian: return "URL non valido"
            case .system: return "URL invalide"
            }
        case .errInvalidResponse:
            switch language {
            case .french: return "Réponse du serveur invalide"
            case .english: return "Invalid server response"
            case .spanish: return "Respuesta del servidor no válida"
            case .german: return "Ungültige Serverantwort"
            case .italian: return "Risposta del server non valida"
            case .system: return "Réponse du serveur invalide"
            }
        }
    }
}

@MainActor
class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()

    @AppStorage("appLanguage") var selectedLanguage: String = AppLanguage.system.rawValue {
        didSet {
            objectWillChange.send()
        }
    }

    var effectiveLanguage: AppLanguage {
        if selectedLanguage == AppLanguage.system.rawValue {
            let preferred = Locale.preferredLanguages.first ?? "fr"
            if preferred.hasPrefix("en") { return .english }
            if preferred.hasPrefix("es") { return .spanish }
            if preferred.hasPrefix("de") { return .german }
            if preferred.hasPrefix("it") { return .italian }
            return .french
        }
        return AppLanguage(rawValue: selectedLanguage) ?? .french
    }

    func tr(_ key: LocalizedKey) -> String {
        key.string(for: effectiveLanguage)
    }
}

// Global convenience accessor
func tr(_ key: LocalizedKey) -> String {
    LocalizationManager.shared.tr(key)
}
