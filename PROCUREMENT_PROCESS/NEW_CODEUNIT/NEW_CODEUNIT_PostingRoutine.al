codeunit 50001 "Posting Routine"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Codeunit, 5760, 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun_LT(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        WrhseRecptHeader: Record "Warehouse Receipt Header";
    begin
        if WrhseRecptHeader.get(WarehouseReceiptLine."No.") then begin
            WrhseRecptHeader."Quality Checked" := false;
            Clear(WrhseRecptHeader."Quality Checked By");
        end;

    end;
}