page 90000 "Customer Onboarding Page"
{
    ApplicationArea = All;
    Caption = 'Customer Onbaording Page';
    PageType = List;
    SourceTable = BTLTest;
    UsageCategory = Lists;
    CardPageId = "Customer Onboarding Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(First_Name; Rec.First_Name)
                {
                    ApplicationArea = All;
                }
                field(Middle_Name; Rec.Middle_Name)
                {
                    ApplicationArea = All;
                }
                field(Last_Name; Rec.Last_Name)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                }
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
                Caption = 'Import Customers';

                trigger OnAction()
                var
                    getEmpoyerXML: XmlPort "Customer Onboarding XML";
                begin
                    getEmpoyerXML.Run();
                end;
            }
        }
    }
}
