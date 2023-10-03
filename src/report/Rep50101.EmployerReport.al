report 50144 "Employer Report"
{
    ApplicationArea = All;
    Caption = 'Employer Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './ssrs/Employer Report.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(Employer; Employer)
        {
            column(EmployerNo; "Employer No")
            {
            }
            column(EmployerAddress; "Employer Address")
            {
            }
            column(EmployerEmail; "Employer Email")
            {
            }
            column(EmployerPhoneNumber; "Employer Phone Number")
            {
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
}
