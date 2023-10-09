codeunit 90006 IntegrationJSON
{
    procedure GetCustomerDetails(customerId: Code[20]; responseMsg: Text)
    var
        customer: Record Customer;
        jsonObject: JsonObject;
        jsonArray: jsonArray;
        base64Converter: Codeunit "Base64 Convert";
        inStream: InStream;
    begin
        Clear(responseMsg);
        customer.Reset();
        customer.SetRange(customer."No.", customerId);
        if customer.FindFirst() then begin
            customer.CalcFields("Profile Picture");
            customer."Profile Picture".CreateInStream(inStream);
            jsonObject.Add('Customer No.', customer."No.");
            jsonObject.Add('Customer name.', customer.Name);
            jsonObject.Add('Customer Email', customer."E-Mail");
            jsonObject.Add('Image', base64Converter.ToBase64(inStream));
            jsonArray.Add(jsonObject);
        end;
        jsonArray.WriteTo(responseMsg);
    end;

    procedure updateCustomer(customerID: Code[20]; base64Image: Text; mobileNumber: Code[20])
    var
        outStream: OutStream;
        customer: Record Customer;
        base64: Codeunit "Base64 Convert";
    begin
        if customer.Get(customerID) then begin
            customer."Profile Picture".CreateOutStream(outStream);
            base64.FromBase64(base64Image, outStream);
            if mobileNumber <> '' then customer."Mobile Phone No." := mobileNumber;
            customer.Modify();
        end
    end;
}