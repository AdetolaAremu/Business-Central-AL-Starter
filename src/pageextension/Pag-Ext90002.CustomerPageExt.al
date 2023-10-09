pageextension 90002 "Customer Page Ext" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Profile Picture"; Rec."Profile Picture")
            {
                ApplicationArea = All;
            }
        }
    }
}
