pageextension 50101 OrderProcessExt extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
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
                    RunPageView = Where(is_submitted = const(false));
                }
            }
        }
    }
}
