page 50104 "Employer Info"
{
    Caption = 'Employer Info';
    PageType = CardPart;
    SourceTable = Employer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Employer Information';
                field("Employer No"; Rec."Employer No")
                {
                    ApplicationArea = All;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                }
                field("Employer Phone Number"; Rec."Employer Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Employer Email"; Rec."Employer Email")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
