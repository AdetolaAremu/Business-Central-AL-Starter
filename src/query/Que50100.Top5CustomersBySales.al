query 50100 "Top 5 Customers By Sales"
{
    Caption = 'Top 5 Customers By Sales';
    QueryType = Normal;
    OrderBy = descending(SalesLCY);
    TopNumberOfRows = 5;
    QueryCategory = 'Customer List';

    elements
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            column(PostingDate; "Posting Date")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(SalesLCY; "Sales (LCY)")
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
