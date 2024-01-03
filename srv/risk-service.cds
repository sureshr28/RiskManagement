
using {riskmanagement as rm} from '../db/schema';

@path: 'service/risk'
service RiskService @(requires: 'authenticated-user') {
    /**
     * Risks
     */
    entity Risks @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: [
                'READ',
                'WRITE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ], // Allowing CDS events by explicitly mentioning them
            to   : 'RiskManager'
        }
    ])                      as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;

    /**
     * Mitigations
     */
    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wildcard
            to   : 'RiskManager'
        }
    ])                      as projection on rm.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    /**
     * BusinessPartners
     */
    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;
}
