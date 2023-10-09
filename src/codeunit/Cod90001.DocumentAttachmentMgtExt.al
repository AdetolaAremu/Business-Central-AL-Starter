codeunit 90001 "Document Attachment Mgt Ext"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure documentAttachmentBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        custOnboarding: Record BTLTest;
    begin
        case DocumentAttachment."Table ID" of
            Database::BTLTest:
                begin
                    RecRef.Open(Database::Customer);

                    if custOnboarding.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(custOnboarding);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]

    procedure DocumentAttachmentAfterOpen(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        fieldRef: FieldRef;
        recNo: Code[20];
        lineNo: Integer;
    begin
        case RecRef.Number of
            Database::BTLTest:
                begin
                    fieldRef := RecRef.Field(1);
                    recNo := fieldRef.Value;
                    DocumentAttachment.SetRange("No.", recNo);
                end;
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]

    procedure DocumentAttachmentAfterInit(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        fieldRef: FieldRef;
        recNo: Code[20];
        lineNo: Integer;
    begin
        DocumentAttachment.Validate("Table ID", RecRef.Number);
        // DocumentAttachment."Table ID" := RecRef.Number;
        case RecRef.Number of
            Database::BTLTest:
                begin
                    fieldRef := RecRef.Field(1);
                    recNo := fieldRef.Value;
                    DocumentAttachment.Validate("No.", recNo);
                end;
        end;
    end;
}
