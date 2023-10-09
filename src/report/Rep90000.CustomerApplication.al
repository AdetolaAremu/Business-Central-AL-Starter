report 90000 "Customer Application"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './ssrs/Customer Application.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Customer Application"; BTLTest)
        {
            RequestFilterFields = Employer, status;

            column(No; No) { }
            column(First_Name; First_Name) { }
            column(Last_Name; Last_Name) { }
            column(status; status) { }
            column(Employer; Employer) { }

            dataitem(Customer; Customer)
            {
                RequestFilterFields = "No.";
                DataItemLink = "No." = field("No");
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(employer; employerRecord."Employer Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        employer: Code[20];
        employerRecord: Record Employer;
}