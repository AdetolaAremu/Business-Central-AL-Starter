pageextension 90000 "Sales&ReceiveableSetupExt.al" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("Customer Onboard No"; Rec."Customer Onboard No")
            {
                ApplicationArea = All;
            }
            field("Employer No"; Rec."Employer No")
            {
                ApplicationArea = All;
            }
        }

    }
}
