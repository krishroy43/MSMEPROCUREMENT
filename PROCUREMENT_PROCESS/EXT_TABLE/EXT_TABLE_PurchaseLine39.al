tableextension 50020 "Ext. Purchase Line" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
    }


    var
        PurchHeaderRecG: Record "Purchase Header";


    trigger
    OnBeforeModify()
    begin
        // // PurchHeaderRecG.Reset();
        // // if PurchHeaderRecG.get(PurchHeaderRecG."Document Type"::Order, "Document No.") then begin

        // //     // if PurchHeaderRecG.get("Document No.") then begin
        // //     PurchHeaderRecG.TestField("Short Closed", true);
        // //     PurchHeaderRecG.TestField(Cancel, false);
        // // end;
    end;

    trigger
    OnBeforeDelete()
    begin
        // // PurchHeaderRecG.Reset();
        // // if PurchHeaderRecG.get(PurchHeaderRecG."Document Type"::Order, "Document No.") then begin
        // //     PurchHeaderRecG.TestField("Short Closed", true);
        // //     PurchHeaderRecG.TestField(Cancel, false);
        // // end;
    end;

}