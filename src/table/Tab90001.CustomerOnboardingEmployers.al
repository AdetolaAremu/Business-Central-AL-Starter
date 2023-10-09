table 90001 "Customer Onboarding Employers"
{
    Caption = 'Customer Onboarding Employers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Onboarding No."; Code[20])
        {
            Caption = 'Customer Onboarding No.';
            TableRelation = BTLTest;
        }
        field(2; "Employer No."; Code[20])
        {
            Caption = 'Employer No.';
            TableRelation = Employer;
            trigger OnValidate()
            var
                employerRec: Record Employer;
            begin
                "Employer Name" := '';
                "Employer Email" := '';
                "Employer Address" := '';

                if employerRec.Get("Employer No.") then begin
                    "Employer Name" := employerRec."Employer Name";
                    "Employer Email" := employerRec."Employer Email";
                    "Employer Address" := employerRec."Employer Address";
                end;
            end;

        }
        field(3; "Employer Name"; Text[200])
        {
            Caption = 'Employer Name';
            Editable = false;
        }
        field(4; "Employer Email"; Text[100])
        {
            Caption = 'Employer Email';
            Editable = false;
        }
        field(5; "Employer Address"; Text[100])
        {
            Caption = 'Employer Address';
        }
    }
    keys
    {
        key(PK; "Customer Onboarding No.")
        {
            Clustered = true;
        }
    }
}
