table 50100 BTLTest
{
    Caption = 'BTLTest';
    DataClassification = ToBeClassified;
    // DrillDownPageId = 

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            Editable = false;
        }
        field(2; First_Name; Text[50])
        {
            Caption = 'First_Name';
        }
        field(3; Middle_Name; Text[50])
        {
            Caption = 'Middle_Name';
        }
        field(4; Last_Name; Text[50])
        {
            Caption = 'Last_Name';
        }
        field(5; Created_by; Code[20])
        {
            Caption = 'Created_by';
        }
        field(6; Created_on; DateTime)
        {
            Caption = 'Created_on';
        }
        field(7; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = Male,Female;
            OptionCaption = ' ,Male,Female';
        }
        field(8; Date_Of_Birth; Date)
        {
            Caption = 'Date_Of_Birth';
            trigger OnValidate()

            begin
                if Date_Of_Birth <> 0D then begin
                    if Today - Date_Of_Birth < 18 then
                        Error('Only 18 and above can register');
                end;
            end;
        }
        field(9; Phone_Number; Text[20])
        {
            Caption = 'Phone_Number';
            ExtendedDatatype = PhoneNo;

            // trigger OnValidate()
            // var
            //     phoneNoCodeUnit: Codeunit "Customer Onboarding";
            // begin
            //     phoneNoCodeUnit.PhoneNumberValidation(Phone_Number);
            // end;
        }
        field(10; Marital_Status; Enum "Marital Status")
        {
            Caption = 'Martial_Status';
        }
        field(11; Email_Address; Text[50])
        {
            Caption = 'Email_Address';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                customerOnboarding: CodeUnit "Customer Onboarding";
            begin
                customerOnboarding.EmailValidation("Email_Address");
            end;
        }
        field(12; Physical_Address; Text[100])
        {
            Caption = 'Physical_Address';
        }
        field(13; Employer; Code[20])
        {
            Caption = 'Employer Code';
            TableRelation = Employer;

            trigger OnValidate()
            var
                getEmployer: Record Employer;
            begin
                if getEmployer.Get("Employer Name") then
                    "Employer Name" := getEmployer."Employer Name";
            end;
        }
        field(25; "Employer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Next_of_kin; Code[20])
        {
            Caption = 'Next_of_kin';
            TableRelation = Contact;
        }
        field(15; status; Enum StatusEnum)
        {
            Caption = 'status';
        }
        field(16; approved_by; Code[20])
        {
            Caption = 'approved_by';
        }
        field(17; approved_on; DateTime)
        {
            Caption = 'approved_on';
        }
        field(18; submitted_by; Code[20])
        {
            Caption = 'submitted_by';
        }
        field(19; submitted_on; DateTime)
        {
            Caption = 'submitted_on';
        }
        field(20; is_submitted; Boolean)
        {
            Caption = 'is_submitted';
        }
        field(21; modifiedOn; DateTime)
        {
            Caption = 'modified on';
            DataClassification = ToBeClassified;
        }
        field(22; modifiedby; Code[20])
        {
            Caption = 'modifiedby';
            DataClassification = ToBeClassified;
        }
        field(24; "Number series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Customer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Editable = false;
        }
        field(27; "Profile Picture"; Media)
        {
            DataClassification = ToBeClassified;
            ExtendedDataType = Person;
        }
        field(28; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(29; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(30; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            // Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(31; Country; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Country;

            trigger OnValidate()
            var
                getCountryName: Record Country;
            begin
                if getCountryName.Get(Country) then
                    "Country Name" := getCountryName.Name;
            end;
        }
        field(32; State; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code where("Country Code" = field(Country));

            trigger OnValidate()
            var
                getStateName: Record State;
            begin
                if getStateName.Get(State) then
                    "State Name" := getStateName.Name;
            end;
        }
        field(33; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "State Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Customer Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, First_Name, Last_Name, Middle_Name, Phone_Number, Email_Address) { }
        fieldgroup(Brick; No, First_Name, Last_Name, Middle_Name, Phone_Number, Email_Address) { }
    }

    trigger OnInsert()
    var
        SSetup: Record "Sales & Receivables Setup";
        Nseries: Codeunit NoSeriesManagement;
    begin
        begin
            // Nseries.GetNextNo(SSetup."Customer Onboard No", Today, true);
            if No = '' then begin
                SSetup.Get();
                Ssetup.TestField("Customer Onboard No");
                Nseries.InitSeries(SSetup."Customer Onboard No", xRec."Number series", 0D, No, "Number series");
            end;
        end;

        "Created_by" := UserId;
        "Created_on" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        // TestField("Customer ID", '');
    end;
}
