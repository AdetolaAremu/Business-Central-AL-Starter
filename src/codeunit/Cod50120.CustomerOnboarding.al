codeunit 50120 "Customer Onboarding"
{
    var
        customer: Record Customer;

    procedure CreateCustomer(custOnboarding: Record BTLTest): Code[20]
    begin
        OnBeforeCustomerCreation(custOnboarding);
        customer.Init();
        customer.Name := StrSubstNo('%1 %2 %3', custOnboarding.First_Name, custOnboarding.Last_Name, custOnboarding.Middle_Name);
        customer."E-Mail" := custOnboarding.Email_Address;
        customer."Phone No." := custOnboarding.Phone_Number;
        customer.Gender := custOnboarding.Gender;
        customer."Date of birth" := custOnboarding.Date_Of_Birth;
        customer."Marital Status" := custOnboarding.Marital_Status;
        customer.Insert(true); //this is also a trigger like Oninsert
        custOnboarding."Customer ID" := customer."No.";
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
}
