codeunit 50101 "Global Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Onboarding", 'OnBeforeCustomerCreation', '', true, true)]
    local procedure customerValidation(custOnboarding: Record BTLTest)
    var
        customer: Record Customer;
    begin
        custOnboarding.TestField(Email_Address);
        custOnboarding.TestField(Phone_Number);
        custOnboarding.TestField(First_Name);
        custOnboarding.TestField(Last_Name);
        customer.Reset();
        customer.SetRange("E-Mail", custOnboarding.Email_Address);
        // customer.SetFilter(Balance, '<>%1', 0);
        if customer.FindFirst() then
            Error(StrSubstNo('The customer already exist with customer number %1', customer."No."));
    end;
}
