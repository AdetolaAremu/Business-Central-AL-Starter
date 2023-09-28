tableextension 50100 "Customer ext.al" extends Customer
{
    fields
    {
        field(50100; "Date of birth"; Date)
        {
            Caption = 'DOB';
            DataClassification = ToBeClassified;
        }
        field(50101; "Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
            OptionCaption = ' ,Male,Female';
        }
        field(50102; Employer; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Married,Single,Divorced,"Not Interested";
            OptionCaption = ' ,Married,Single,Divorced,"Not Interested"';
        }
        field(50104; "Next of kin"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
    }
}
