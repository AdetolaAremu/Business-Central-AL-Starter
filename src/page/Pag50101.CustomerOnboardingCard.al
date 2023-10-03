page 50113 "Customer Onboarding Card"
{
    Caption = 'Customer Onboarding';
    PageType = Card;
    SourceTable = BTLTest;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(First_Name; Rec.First_Name)
                {
                    ApplicationArea = All;
                }
                field(Middle_Name; Rec.Middle_Name)
                {
                    ApplicationArea = All;
                }
                field(Last_Name; Rec.Last_Name)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email_Address)
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec.Phone_Number)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec.Marital_Status)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec.Date_Of_Birth)
                {
                    ApplicationArea = All;
                    ShowMandatory = true; // this field is mandatory
                }
                field("Employer Code"; Rec.Employer)
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                // field("Employer Name"; Rec."Employer Name")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
            }
            group("Audit Details")
            {
                Caption = 'Audit Details';
                field(Created_by; Rec.Created_by)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Created_on; Rec.Created_on)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }

            part(Control1; "Customer Onboarding Employer")
            {
                Caption = 'Employer Details';
                Editable = true;
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = "Employer No." = field(Employer);
            }
        }
        area(FactBoxes)
        {
            part("AttachmentDocument"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachment';
                SubPageLink = "Table ID" = const(50100), "No." = field(No);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Customer")
            {
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                Visible = (Rec.status = Rec.status::Open) and (Rec."Customer ID" = '');

                trigger OnAction()
                var
                    custNo: Code[20];
                begin
                    if not Confirm('Are you sure you want to create customer?') then exit;
                    custNo := custOnboardingMgt.CreateCustomer(Rec);
                    Message(StrSubstNo('The customer %1 was successfully created', custNo));
                end;

            }

            action("Send for approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Visible = 

                trigger OnAction()
                begin
                    if Rec.Date_Of_Birth = 0D
                    then
                        Error('Date of birth is required');
                    if (Rec.status = Rec.status::"Pending Approval") or (Rec.status = Rec.status::approved)
                    then
                        Error('This record has been sent for approval');
                end;
            }

            action("Rejected")
            {
                ApplicationArea = All;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Visible = 

                trigger OnAction()
                begin
                    Rec.TestField(status, Rec.status::"Pending Approval");
                    // Rec.status IN [Rec.status];
                    // if (Rec.status = Rec.status::"Pending Approval");
                end;
            }

            action("Reopen")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Visible = 

                trigger OnAction()
                begin
                    Rec.TestField(is_submitted, false);
                    Rec.TestField(status, Rec.status::approved);
                    // Rec.status IN [Rec.status];
                    // if (Rec.status = Rec.status::"Pending Approval");
                end;
            }

            action("Approved")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    approvalEntry: Record "Approval Entry";
                begin
                    Rec.TestField(status, Rec.status::approved);
                    Rec.TestField(status, Rec.status::"Pending Approval");
                    approvalEntry.Reset();
                    approvalEntry.SetRange("Document No.", Rec.No);
                    approvalEntry.SetFilter("Approver ID", '<>%1', UserId);
                    if approvalEntry.FindFirst() then Error('You are not authorized');
                    // approvalEntry.CanCurrentUserEdit();
                end;
            }

            action(Attachment)
            {
                ApplicationArea = All;
                Image = Approve;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    documentAttachment: Page "Document Attachment Details";
                    recRef: RecordRef;
                begin
                    recRef.GetTable(Rec);
                    documentAttachment.OpenForRecRef(recRef);
                    documentAttachment.RunModal();
                end;
            }
        }
    }

    var
        custOnboardingMgt: codeunit "Customer Onboarding";
}
