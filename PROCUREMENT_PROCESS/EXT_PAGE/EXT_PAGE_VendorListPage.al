pageextension 50011 "Ext. Vendor Listpage" extends "Vendor List"
{
    layout
    {
        modify("No.")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;

        }
        modify(Name)
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Responsibility Center")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Location Code")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Phone No.")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify(Contact)
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Balance (LCY)")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Balance Due (LCY)")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }
        modify("Payments (LCY)")
        {
            StyleExpr = StypeExprBool;
            Style = Unfavorable;
        }


    }

    var
        StypeExprBool: Boolean;


    trigger
    OnOpenPage()
    begin
        StypeExprBool := false;
    end;

    trigger
    OnAfterGetRecord()
    begin
        AlertCustomerexpiryperiod("No.");
    end;

    procedure AlertCustomerexpiryperiod(CustNo: Code[30])
    var
        VendorRecL: Record Vendor;
    begin
        VendorRecL.Reset();
        if VendorRecL.Get(CustNo) then
            if ("Trade License Expiry Date" < Today()) AND ("Trade License Expiry Date" <> 0D) OR
            (("ID Proof Expiry Date" < Today) AND ("ID Proof Expiry Date" <> 0D))
            then
                StypeExprBool := true
            else
                StypeExprBool := false;


    end;
}