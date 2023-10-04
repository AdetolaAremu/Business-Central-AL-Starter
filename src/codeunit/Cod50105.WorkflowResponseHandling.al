codeunit 50105 "Workflow Response Handling Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessors(ResponseFunctionName: Code[128])
    var
        workflowEventHandling: Codeunit "Workflow Event Handling Ext";
        workFlowResponseHandler: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workFlowResponseHandler.SetStatusToPendingApprovalCode:
                begin
                    workFlowResponseHandler.AddResponsePredecessor(workFlowResponseHandler.SendApprovalRequestForApprovalCode(), workflowEventHandling.runWorkFlowOnSendCustOnboardingForApprovalCode());
                end;

            workFlowResponseHandler.CreateApprovalRequestsCode:
                begin
                    workFlowResponseHandler.AddResponsePredecessor(workFlowResponseHandler.CreateApprovalRequestsCode(), workflowEventHandling.runWorkFlowOnSendCustOnboardingForApprovalCode());
                end;
            workFlowResponseHandler.SendApprovalRequestForApprovalCode:
                begin
                    workFlowResponseHandler.AddResponsePredecessor(workFlowResponseHandler.SendApprovalRequestForApprovalCode(), workflowEventHandling.runWorkFlowOnSendCustOnboardingForApprovalCode());
                end;
            workFlowResponseHandler.OpenDocumentCode():
                begin
                    workFlowResponseHandler.AddResponsePredecessor(workFlowResponseHandler.OpenDocumentCode(), workflowEventHandling.RunWorkFlowCancelCustomeOnboardingRequestCode());
                end;

            workFlowResponseHandler.CancelAllApprovalRequestsCode():
                begin
                    workFlowResponseHandler.AddResponsePredecessor(workFlowResponseHandler.CancelAllApprovalRequestsCode(), workflowEventHandling.RunWorkFlowCancelCustomeOnboardingRequestCode());
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnApproval(RecRef: RecordRef; var Handled: Boolean)
    var
        customerOnboarding: Record BTLTest;
    begin
        case RecRef.Number of
            Database::BTLTest:
                begin
                    RecRef.SetTable(customerOnboarding);
                    customerOnboarding.Validate(status, customerOnboarding.status::approved);
                    customerOnboarding.Modify(true);
                    Handled := true;
                end
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure MyProcedure(RecRef: RecordRef; var Handled: Boolean)
    var
        customerOnboarding: Record BTLTest;
    begin
        case RecRef.Number of
            Database::BTLTest:
                begin
                    RecRef.SetTable(customerOnboarding);
                    customerOnboarding.Validate(status, customerOnboarding.status::Open);
                    customerOnboarding.Modify(true);
                    Handled := true;
                end
        end;
    end;
}
