tableextension 90001 "SalesAndReceiveables Ext.al" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Customer Onboard No"; Code[20])
        {
            Caption = 'Customer Onboard No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "Employer No"; Code[20])
        {
            Caption = 'Employer No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
