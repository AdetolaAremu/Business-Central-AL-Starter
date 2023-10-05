xmlport 50153 "Customer Onboarding XML"
{
    Caption = 'Customer Onboarding XML';
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    FormatEvaluate = Xml;
    Direction = Import;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(CustomerOnboarding; BTLTest)
            {
                fieldelement(FirstName; CustomerOnboarding.First_Name) { }
                fieldelement(LastName; CustomerOnboarding.Last_Name) { }
                fieldelement(Email; CustomerOnboarding.Email_Address) { }
                fieldelement(PhoneNumber; CustomerOnboarding.Phone_Number) { }
                fieldelement(Employer; CustomerOnboarding.Employer) { }
                fieldelement(Gender; CustomerOnboarding.Gender) { }
                fieldelement(MaritalStatus; CustomerOnboarding.Marital_Status) { }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostXmlPort()
    var
        employer: Record Employer;
    begin
        CustomerOnboarding.Reset();

        if CustomerOnboarding.FindSet() then
            repeat
                if employer.Get(CustomerOnboarding.Employer) then begin
                    CustomerOnboarding.Validate(Employer);
                end
            until CustomerOnboarding.Next() = 0;
    end;

    trigger OnPreXmlPort()
    var
        myInt: Integer;
    begin
        CustomerOnboarding.Reset();
    end;
}
