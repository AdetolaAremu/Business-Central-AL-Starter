enum 90003 StatusEnum
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; rejected)
    {
        Caption = 'rejected';
    }
    value(3; approved)
    {
        Caption = 'approved';
    }
}
