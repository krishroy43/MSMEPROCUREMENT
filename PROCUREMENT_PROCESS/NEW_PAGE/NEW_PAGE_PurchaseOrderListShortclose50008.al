page 50008 "Purchase Order List ShortClose"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase Order";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where ("Short Closed" = filter (true), Cancel = filter (false));
    Caption = 'Short closed PO';

    layout
    {
        area(Content)
        {
            repeater("Short Closed List")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Short Closed"; "Short Closed")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; "Order Address Code")
                {
                    ApplicationArea = All;
                }

                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; "Vendor Authorization No.")
                {
                    ApplicationArea = All;

                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Country/Region Code"; "Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; "Pay-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Country/Region Code"; "Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; "Pay-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    ApplicationArea = All;
                }
                field("A. Rcd. Not Inv. Ex. VAT (LCY)"; "A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; "Amt. Rcd. Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    trigger
    OnOpenPage()
    begin
        // SetRange("Short Closed", true);
        //SetRange(Cancel, false);
    end;




}