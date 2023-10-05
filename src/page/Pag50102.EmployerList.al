page 50102 EmployerList
{
    Caption = 'Employer List';
    PageType = List;
    SourceTable = Employer;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = EmployerCard;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employer No"; Rec."Employer No")
                {
                    ApplicationArea = All;
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
    actions
    {
        area(Processing)
        {
            action(ImportEmployerList)
            {
                ApplicationArea = All;
                PromotedCategory = Category5;
                Promoted = true;
                image = Excel;

                trigger OnAction()
                var
                    getEmpoyerXML: XmlPort "Import Employer";
                begin
                    getEmpoyerXML.Run();
                end;
            }
        }
    }
}
