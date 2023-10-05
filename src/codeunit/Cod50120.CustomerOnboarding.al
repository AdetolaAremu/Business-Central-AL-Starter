codeunit 50120 "Customer Onboarding"
{
    var
        customer: Record Customer;

    procedure CreateCustomer(custOnboarding: Record BTLTest): Code[20]
    var
        ssetup: Record "Sales & Receivables Setup";
        Nseries: Codeunit NoSeriesManagement;
    begin
        OnBeforeCustomerCreation(custOnboarding);
        ssetup.Get();
        customer.Init();
        customer."No." := Nseries.GetNextNo(ssetup."Customer Nos.", Today, true);
        customer.Name := StrSubstNo('%1 %2 %3', custOnboarding.First_Name, custOnboarding.Last_Name, custOnboarding.Middle_Name);
        customer."E-Mail" := custOnboarding.Email_Address;
        customer."Phone No." := custOnboarding.Phone_Number;
        customer.Gender := custOnboarding.Gender;
        customer."Date of birth" := custOnboarding.Date_Of_Birth;
        customer."Marital Status" := custOnboarding.Marital_Status;
        customer.Insert(true); //this is also a trigger like Oninsert
        custOnboarding."Customer ID" := customer."No.";
        custOnboarding."Customer Created" := true;
        custOnboarding.Modify(true);
        OnAferCustomerCreation(custOnboarding);
        exit(customer."No.");
    end;

    procedure CreateCustomerExternal(name: Text[100]; email: Text[100]; phoneNo: Text[100]; gender: Option; dateOfBirth: Date; maritalStatus: Enum "Marital Status"): Code[20]
    var
        SSetup: Record "Sales & Receivables Setup";
        Nseries: Codeunit NoSeriesManagement;
        customer: Record Customer;
    begin
        SSetup.Get();
        SSetup.TestField("Customer Nos.");
        customer.Init();
        customer."No." := Nseries.GetNextNo(SSetup."Customer Nos.", Today, true);
        customer.Name := name;
        customer."E-Mail" := email;
        customer."Phone No." := phoneNo;
        customer.Gender := gender;
        customer."Date of birth" := dateOfBirth;
        customer."Marital Status" := maritalStatus;
        customer.Insert(true);
        exit(customer."No.");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCustomerCreation(custOnboarding: Record BTLTest)
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAferCustomerCreation(custOnboarding: Record BTLTest)
    begin

    end;

    procedure EmailValidation(email: Text[50])
    var
        emailPattern: Text[50];
        regex: Codeunit Regex;
        matchRecord: Record Matches;
    begin
        emailPattern := '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$';
        regex.Match(email, emailPattern, matchRecord);
        if not matchRecord.Success then Error('Email not in the correct format');
    end;

    procedure MyPhoneNumberLength()
    var
        myInt: Integer;
    begin

    end;

    procedure PhoneNumberValidation(phoneNo: Text[15])
    var
        mobilePattern: Text[50];
        regex: Codeunit Regex;
        matchRec: Record Matches;
    begin
        mobilePattern := '/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/';
        regex.Match(phoneNo, mobilePattern, matchRec);
        if not matchRec.Success then Error('Phone number is not valid');
    end;

    procedure ClearCustomerOnboardingTable()
    var
        customerOnboarding: Record BTLTest;
    begin
        customerOnboarding.Reset();
        customerOnboarding.SetRange("Customer Created", true);
        customerOnboarding.SetRange(status, customerOnboarding.status::Open);
        if customerOnboarding.FindFirst() then customerOnboarding.DeleteAll();
    end;

    trigger OnRun()
    var
        custOnboarding: Record BTLTest;
        ccRecipient: Text[100];
        SSetup: Record "User Setup";
    begin
        custOnboarding.Reset();
        custOnboarding.SetRange("Customer Created", false);
        custOnboarding.SetRange(status, custOnboarding.status::Open);
        if custOnboarding.FindSet() then
            repeat
                CreateCustomer(custOnboarding);
                if SSetup.Get(UserId) then begin
                    SSetup.TestField("E-Mail");
                    // ccRecipient := StrSubstNo('%1, %2', custOnboarding.Email_Address, SSetup."E-Mail");
                    ccRecipient := custOnboarding.Email_Address;
                end;
                sendEmail(custOnboarding.Email_Address, StrSubstNo('Customer with %1 %2 has been created', custOnboarding.First_Name, custOnboarding.Last_Name), StrSubstNo('Dear %1, <br> Your record has been created with number %1 <br> with Name %2 %3', custOnboarding.No, custOnboarding.First_Name, custOnboarding.Last_Name));
            until custOnboarding.Next() = 0;

        ClearCustomerOnboardingTable();
    end;

    procedure sendEmail(recipient: Text[100]; subject: Text[50]; Body: Text[200])
    var
        mail: codeunit "Email Message";
        email: codeunit Email;
        // emailExt: codeunit Mail;
        userSetup: Record "User Setup";
    begin
        if (subject <> '') and (body <> '') then begin
            mail.Create(recipient, subject, Body);
            if userSetup.Get(UserId) then
                email.Send(mail, Enum::"Email Scenario"::Default);
        end
    end;
}