table 50144 Country
{
    Caption = 'Country';
    DataClassification = ToBeClassified;
    DrillDownPageId = Country;
    LookupPageId = Country;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'name';
        }
        field(3; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
        }

    }
    keys
    {
        key(PK; Code, "Country Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; Name, Code) { }
    }
}
