pageextension 50105 OrderProcessExt extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group(Employer)
            {
                action("Employers")
                {
                    ApplicationArea = All;
                    RunObject = Page EmployerList;
                }
            }
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

        addafter("Customer/&Item Sales")
        {
            action("Customer Application")
            {
                ApplicationArea = Basic, Suite;
                image = Customer;
                ToolTip = 'This specifies customer onboarding report';
                RunObject = report "Customer Application";

                // trigger OnAction()
                // begin

                // end;
            }
        }
    }
}
