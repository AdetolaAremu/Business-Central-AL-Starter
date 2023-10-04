codeunit 50104 "Workflow Event Handling Ext"
{
    var
        workflowMgt: Codeunit "Workflow Management";
        workFlowEventHanlding: Codeunit "Workflow Event Handling";

    procedure runWorkFlowOnSendCustOnboardingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('runWorkFlowOnSendCustOnboardingForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Ext", 'ONsetCutomerOnboardingForApproval', '', true, true)]
    procedure runWorkFlowOnCancelCustomerOnboarding(var custOnboarding: Record BTLTest)
    begin
        workflowMgt.HandleEvent(runWorkFlowOnSendCustOnboardingForApprovalCode, custOnboarding);
    end;

    procedure RunWorkFlowCancelCustomeOnboardingRequestCode(): Code[100]
    begin
        exit('RunWorkFlowSendCustomeOnboardingCancel');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddToEventLibrary()
    begin
        workFlowEventHanlding.AddEventToLibrary(runWorkFlowOnSendCustOnboardingForApprovalCode, Database::BTLTest, 'Approval for customer onboarding request', 0, false);
        workFlowEventHanlding.AddEventToLibrary(RunWorkFlowCancelCustomeOnboardingRequestCode, Database::BTLTest, 'Recall for customer onboarding request', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkFlowCancelCustomeOnboardingRequestCode:
                workFlowEventHanlding.AddEventPredecessor(runWorkFlowOnSendCustOnboardingForApprovalCode, runWorkFlowOnSendCustOnboardingForApprovalCode);

            workFlowEventHanlding.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    workFlowEventHanlding.AddEventPredecessor(workFlowEventHanlding.RunWorkflowOnApproveApprovalRequestCode, runWorkFlowOnSendCustOnboardingForApprovalCode());
                end;

            workFlowEventHanlding.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    workFlowEventHanlding.AddEventPredecessor(workFlowEventHanlding.RunWorkflowOnRejectApprovalRequestCode, runWorkFlowOnSendCustOnboardingForApprovalCode);
                end;
        end
    end;
}
