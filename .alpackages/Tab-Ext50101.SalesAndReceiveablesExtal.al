tableextension 50101 "SalesAndReceiveables Ext.al" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Customer Onboard No"; Code[20])
        {
            Caption = 'Customer Onboard No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
