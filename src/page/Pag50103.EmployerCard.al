page 50103 EmployerCard
{
    Caption = 'Employer Card';
    PageType = Card;
    SourceTable = Employer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employer No"; Rec."Employer No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Employer No';
                    Tooltip = 'This specifies the Employer No';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employer Name';
                    Tooltip = 'This specifies the Employer Name';
                }
                field("Business Type"; Rec."Business type")
                {
                    ApplicationArea = All;
                    Caption = 'Business Type';
                    Tooltip = 'This specifies the business type of the employer';
                }
                field("Sector"; Rec.Sector)
                {
                    ApplicationArea = All;
                    Caption = 'Sector';
                    ToolTip = 'This specifies the sector of the employer';
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
                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = All;
                    Tooltip = 'This specifies the employer address';
                }
            }
        }

        area(FactBoxes)
        {
            part("Employer Information"; "Employer Info")
            {
                SubPageLink = "Employer No" = FIELD("Employer No");
            }
        }
    }
}
