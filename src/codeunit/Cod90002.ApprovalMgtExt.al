codeunit 90002 "Approval Mgt Ext"
{

    [IntegrationEvent(false, false)]
    procedure ONsetCutomerOnboardingForApproval(var custOnboarding: Record BTLTest)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure ONCancelCutomerOnboardingForApproval(var custOnboarding: Record BTLTest)
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure setStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        custOnboarding: Record BTLTest;
    begin
        case RecRef.Number of
            Database::BTLTest:
                begin
                    RecRef.SetTable(custOnboarding);
                    custOnboarding.Validate(status, custOnboarding.status::"Pending Approval");
                    custOnboarding.Modify(true);
                    IsHandled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure populateApprovalMgt(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        custOnboarding: Record BTLTest;
    begin
        case RecRef.Number of
            Database::BTLTest:
                begin
                    RecRef.SetTable(custOnboarding);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Customer Onboarding";
                    ApprovalEntryArgument."Document No." := custOnboarding.No;
                end;
        end;
    end;
}
