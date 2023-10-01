table 50130 Employer
{
    Caption = 'Employer';
    DataClassification = ToBeClassified;
    DrillDownPageId = EmployerList;


    fields
    {
        field(6; "Employer No"; Code[20])
        {
            Caption = 'Employer No';
        }
        field(1; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
        }
        field(2; "Business type"; Enum BusinessTypeEnum)
        {
            Caption = 'Business type';
        }
        field(3; Sector; Enum EmployerSector)
        {
            Caption = 'Sector';
        }
        field(4; "Employer Phone Number"; Text[20])
        {
            Caption = 'Employer Phone Number';
        }
        field(5; "Employer Email"; Text[50])
        {
            Caption = 'Employer Email';
        }
        field(7; "Employer Address"; Text[200])
        {
            Caption = 'Employer Address';
        }
        field(8; Created_by; Code[20])
        {
            Caption = 'Created_by';
        }
        field(9; Created_on; DateTime)
        {
            Caption = 'Created_on';
        }
        field(24; "Number series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employer No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Employer No", "Employer Name", "Business type") { }

    }

    trigger OnInsert()
    var
        SSetup: Record "Sales & Receivables Setup";
        Nseries: Codeunit NoSeriesManagement;
    begin
        begin
            // Nseries.GetNextNo(SSetup."Customer Onboard No", Today, true);
            if "Employer No" = '' then begin
                SSetup.Get();
                Ssetup.TestField("Employer No");
                Nseries.InitSeries(SSetup."Employer No", xRec."Number series", 0D, "Employer No", "Number series");
            end;
        end;
        begin
            if "Employer No" = '' then begin
                SSetup.Get();
                Ssetup.TestField("Employer No");
                Nseries.InitSeries(SSetup."Employer No", xRec."Number series", 0D, "Employer No", "Number series");
            end;
        end;

        "Created_by" := UserId;
        "Created_on" := CurrentDateTime;
    end;
}
