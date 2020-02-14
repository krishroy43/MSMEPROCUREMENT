pageextension 50010 "Ext. Vendor" extends "Vendor Card"
{
    layout
    {
        /*addbefore(Name)
        {
            field("Vendor No."; "No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        */
        addafter(General)
        {

            group("Proof & Verification")
            {
                field("ID Proof Type"; "ID Proof Type")
                {
                    ApplicationArea = All;
                }
                field("ID Proof No."; "ID Proof No.")
                {
                    ApplicationArea = All;
                }
                field("ID Proof Expiry Date"; "ID Proof Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Trade License"; "Trade License")
                {
                    ApplicationArea = All;
                }
                field("Trade License Expiry Date"; "Trade License Expiry Date")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}