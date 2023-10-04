page 50143 Country
{
    Caption = 'Country';
    PageType = List;
    SourceTable = Country;
    CardPageId = "Country Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(State)
            {
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page "State List";
                RunPageLink = "Country Code" = field(Code);
                Ellipsis = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}
