page 50146 "Employer Subpage Ext"
{
    Caption = 'Employer Subpage Ext';
    PageType = ListPart;
    SourceTable = Employer;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'This specifies the Employer Name';
                }
                field("Employer No"; Rec."Employer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'This specifies the Employer No';
                }
                field("Employer Phone Number"; Rec."Employer Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'This specifies the phone number of the employer';
                }
                field("Employer Email"; Rec."Employer Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'This specifies the email of the employer';
                }
                field("Business type"; Rec."Business type")
                {
                    ApplicationArea = All;
                    ToolTip = 'This specifies the business type of the employer';
                }

            }
        }
    }
}
