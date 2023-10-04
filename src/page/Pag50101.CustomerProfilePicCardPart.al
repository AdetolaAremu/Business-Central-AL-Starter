page 50101 "Customer Profile Pic Card Part"
{
    Caption = 'Customer Profile Pic Card Part';
    PageType = CardPart;
    SourceTable = BTLTest;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Profile Picture"; Rec."Profile Picture")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Profile Picture field.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No");
                    Rec.TestField("First_Name");
                    Rec.TestField(Last_Name);

                    if Rec."Profile Picture".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Profile Picture");
                    Rec."Profile Picture".ImportFile(FileName, ClientFileName);
                    Rec.Modify(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No");
                    Rec.TestField("First_Name");
                    Rec.TestField(Last_Name);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Rec."No" + Format(Rec."Profile Picture".MediaId);
                    Rec."Profile Picture".ExportFile(ExportPath);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField(No);

                    if not Confirm(DeleteImageQst) then
                        exit;
                    Clear(Rec."Profile Picture");
                    Rec.Modify(true);
                end;
            }
        }
    }

    var
        inStream: InStream;
        description: Text[100];
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        DeleteExportEnabled: Boolean;

    local procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField(No);
        Rec.TestField(First_Name);
        Rec.TestField(Last_Name);

        if Rec."Profile Picture".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec."Profile Picture");
            Rec."Profile Picture".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Profile Picture".HasValue;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;
}
