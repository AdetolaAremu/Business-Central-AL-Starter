tableextension 50100 "Customer ext.al" extends Customer
{
    fields
    {
        field(50100; "Date of birth"; Date)
        {
            Caption = 'DOB';
            DataClassification = ToBeClassified;
        }
        field(50111; "Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
            OptionCaption = ' ,Male,Female';
        }
        field(50102; Employer; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Marital Status"; Enum "Marital Status")
        {

        }
        field(50104; "Next of kin"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
    }
}
