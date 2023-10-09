page 90009 "Country Card"
{
    Caption = 'Country Card';
    PageType = Card;
    SourceTable = Country;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(name; Rec.Name)
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
