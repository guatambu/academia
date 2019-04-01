//
//  PaymentProgramDelegateProtocols.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 12/13/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

// MARK: - PaymentProgramBillingDetailsVC to TypeCollectionViewCell Delegate protocol to access VC's billingTypes array property
protocol BillingTypeDelegate: class {
    var billingTypes: [Billing.BillingType] { get set }
}


// MARK: - PaymentProgramBillingDetailsVC to DateCollectionViewCell Delegate protocol to access VC's billingDates array property
protocol BillingDateDelegate: class {
    var billingDates: [Billing.BillingDate] { get set }
}


// MARK: - PaymentProgramBillingDetailsVC to SignatureCollectionViewCell Delegate protocol to access VC's signatureTypes array property
protocol SignatureTypeDelegate: class {
    var signatureTypes: [Billing.BillingSignature] { get set }
}
