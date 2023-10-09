page 90015 "Registration Processor"
{
    Caption = 'Registration Processor';
    PageType = RoleCenter;
    // SourceTable = "";

    layout
    {
        area(RoleCenter)
        {
            part(Control1; "Headline RC Accountant")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "Customer List";
            }
        }

        area(Sections)
        {
            group("Customer Onboarding")
            {
                group("Customer Applications")
                {
                    group("Onboarding")
                    {
                        action("Open Onboarding")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Onboarding', comment = '="Customer Onboarding"';
                            RunObject = Page "Customer Onboarding Page";
                            RunPageView = Where(status = const(Open));
                        }
                        action("Pending approval Onboarding")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Onboarding', comment = '="Customer Onboarding"';
                            RunObject = Page "Customer Onboarding Page";
                            RunPageView = Where(status = const("Pending Approval"));
                        }
                        action("Rejected approval Onboarding")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Onboarding', comment = '="Customer Onboarding"';
                            RunObject = Page "Customer Onboarding Page";
                            RunPageView = Where(status = const("rejected"));
                        }
                        action("Submitted for approval")
                        {
                            ApplicationArea = All;
                            Caption = 'Submitted for approval Onboarding', comment = '="Customer Onboarding"';
                            RunObject = Page "Customer Onboarding Page";
                            RunPageView = Where("Customer ID" = filter(<> ''));
                        }
                    }
                }
                group(Employer)
                {
                    action("Employers")
                    {
                        ApplicationArea = All;
                        RunObject = Page EmployerList;
                    }
                }
                action("$Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
            }
        }
    }
}
