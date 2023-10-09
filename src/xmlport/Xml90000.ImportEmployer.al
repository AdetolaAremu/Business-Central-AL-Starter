xmlport 90000 "Import Employer"
{
    Caption = 'Import Employer';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ',';
    FormatEvaluate = Xml;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Employer; Employer)
            {
                XmlName = 'ImportEmployer';
                // fieldelement(No; Employer."Employer No") { }
                fieldelement(EmployerName; Employer."Employer Name") { }
                fieldelement("BusinessType"; Employer."Business type") { }
                fieldelement(Sector; Employer."Sector") { }
                fieldelement(EmployerEmail; Employer."Employer Email") { }
                fieldelement(EmployerPhoneNumber; Employer."Employer Phone Number") { }
                fieldelement(EmployerAddress; Employer."Employer Address") { }
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
    begin

    end;

    trigger OnPreXmlPort()
    var
    // clear before importing
    begin

    end;
}
