codeunit 50018 "Purchase Post Yes No"
{
    EventSubscriberInstance = Manual;
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        IF NOT FIND THEN
            ERROR(NothingToPostErr);

        PurchaseHeader.COPY(Rec);
        Code(PurchaseHeader);
        Rec := PurchaseHeader;
    end;

    var
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        NothingToPostErr: Label 'There is nothing to post.';
        ReceiveInvoiceQst1: Label '&Receive';
        ShipInvoiceQst1: Label '&Ship';

    local procedure "Code"(var PurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPostViaJobQueue: Codeunit "Purchase Post via Job Queue";
        HideDialog: Boolean;
    begin
        HideDialog := FALSE;

        // OnBeforeConfirmPost(PurchaseHeader, HideDialog);
        IF NOT HideDialog THEN
            IF NOT ConfirmPost(PurchaseHeader) THEN
                EXIT;

        PurchSetup.GET;
        IF PurchSetup."Post with Job Queue" THEN
            PurchPostViaJobQueue.EnqueuePurchDoc(PurchaseHeader)
        ELSE
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);

        // OnAfterPost(PurchaseHeader);
    end;

    local procedure ConfirmPost(var PurchaseHeader: Record "Purchase Header"): Boolean
    var
        Selection: Integer;
    begin
        WITH PurchaseHeader DO BEGIN
            CASE "Document Type" OF
                "Document Type"::Order:
                    BEGIN
                        Selection := STRMENU(ReceiveInvoiceQst1, 1);
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                        Receive := Selection IN [1, 3];
                        Invoice := Selection IN [2, 3];
                    END;
                "Document Type"::"Return Order":
                    BEGIN
                        Selection := STRMENU(ShipInvoiceQst1, 1);
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                        Ship := Selection IN [1, 3];
                        Invoice := Selection IN [2, 3];
                    END
                ELSE
                    IF NOT CONFIRM(PostConfirmQst, FALSE, LOWERCASE(FORMAT("Document Type"))) THEN
                        EXIT(FALSE);
            END;
            "Print Posted Documents" := FALSE;
        END;
        EXIT(TRUE);
    end;

    [Scope('Cloud')]
    procedure Preview(var PurchaseHeader: Record "Purchase Header")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        BINDSUBSCRIPTION(PurchPostYesNo);
        GenJnlPostPreview.Preview(PurchPostYesNo, PurchaseHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPost(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 19, 'OnRunPreview', '', false, false)]
    local procedure OnRunPreview(var Result: Boolean; Subscriber: Variant; RecVar: Variant)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchPost: Codeunit "Purch.-Post";
    begin
        WITH PurchaseHeader DO BEGIN
            COPY(RecVar);
            Ship := "Document Type" = "Document Type"::"Return Order";
            Receive := "Document Type" = "Document Type"::Order;
            Invoice := TRUE;
        END;
        PurchPost.SetPreviewMode(TRUE);
        Result := PurchPost.RUN(PurchaseHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
    end;



}

