page 90010 "Customer Onboarding Employer"
{
    Caption = 'Customer Onboarding Employer';
    PageType = ListPart;
    SourceTable = "Customer Onboarding Employers";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employer No."; Rec."Employer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer No. field.';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field("Employer Email"; Rec."Employer Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Email field.';
                }
                field("Customer Onboarding No."; Rec."Customer Onboarding No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Onboarding No. field.';
                }
                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Address field.';
                }
            }
        }
    }
}
