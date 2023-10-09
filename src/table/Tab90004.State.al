table 90004 State
{
    Caption = 'State';
    DataClassification = ToBeClassified;
    DrillDownPageId = "State Card";
    LookupPageId = "State Card";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
        }
        field(3; Name; Text[20])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name) { }
    }
}
