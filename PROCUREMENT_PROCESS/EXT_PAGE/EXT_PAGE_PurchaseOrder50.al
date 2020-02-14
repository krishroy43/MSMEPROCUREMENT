pageextension 50019 "Ext. Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Short Closed"; "Short Closed")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field(Cancel; Cancel)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Location "; "Location Code")
            {
                ApplicationArea = All;
            }
        }
    }


    actions
    {

        modify(Post)
        {
            Visible = false;
            trigger
            OnBeforeAction()
            begin
                if ("Short Closed" = true) OR (Cancel = true) then
                    Error('Nothing to post .');
            end;
        }
        modify("Post and &Print")
        {
            Visible = false;
            trigger
           OnBeforeAction()
            begin
                if ("Short Closed" = true) OR (Cancel = true) then
                    Error('Nothing to post .');
            end;
        }
        modify(Preview)
        {
            Visible = false;
            trigger
            OnBeforeAction()
            begin
                if ("Short Closed" = true) OR (Cancel = true) then
                    Error('Nothing to post .');
            end;
        }
        addfirst("P&osting")
        {
            action("Cusomize Post")
            {
                ApplicationArea = All;
                Image = Post;
                Caption = 'Post';
                trigger
                OnAction()
                begin
                    if ("Short Closed" = true) OR (Cancel = true) then
                        Error('Nothing to post .');

                    PostCust(50018);
                end;
            }
        }

        addafter(Print)
        {
            // Start Cancel Action
            action("Short Close")
            {
                Image = Close;
                ApplicationArea = All;
                trigger
                OnAction()
                var
                    PurchaseLineRecL: Record "Purchase Line";

                begin
                    TestField("Short Closed", false);
                    TestField(Cancel, false);
                    if not Confirm('Are You Sure to Short Close this Order ??') then
                        exit;
                    PurchaseLineRecL.Reset();
                    PurchaseLineRecL.SetRange("Document No.", "No.");
                    PurchaseLineRecL.SetRange("Document Type", "Document Type"::Order);
                    if PurchaseLineRecL.Count = 0 then
                        Error('There is No Line In this Order. ');

                    if PurchaseLineRecL.FindSet then
                        repeat
                            if (PurchaseLineRecL."Quantity Received" = PurchaseLineRecL."Quantity Invoiced") then
                                CheckShortClosedBoolG := true
                            else
                                CheckShortClosedBoolG := false;

                        until PurchaseLineRecL.Next = 0;
                    if CheckShortClosedBoolG then begin
                        "Short Closed" := true;
                        Modify();
                        Message('Purchase Order %1 Short Closed Successfully', "No.");
                    end
                    else
                        Error('Can not short-close the purchase order as Quantity received and quantity invoiced doesn’t not matches');


                end;
            }
            // Stop Short Close Action
            // Start Cancel Action
            action("Cancel Order")
            {
                Image = Cancel;
                ApplicationArea = All;
                trigger
                OnAction()
                var
                    PurchaseLineRecL: Record "Purchase Line";
                begin
                    TestField("Short Closed", false);
                    TestField(Cancel, false);
                    if not Confirm('Are You Sure to Cancel this Order ??') then
                        exit;
                    PurchaseLineRecL.Reset();
                    PurchaseLineRecL.SetRange("Document No.", "No.");
                    PurchaseLineRecL.SetRange("Document Type", "Document Type"::Order);
                    if PurchaseLineRecL.Count = 0 then
                        Error('There is No Line In this Order. ');
                    if PurchaseLineRecL.FindSet then
                        repeat
                            if (PurchaseLineRecL."Quantity Received" = 0) AND
                                (PurchaseLineRecL."Quantity Invoiced" = 0) then
                                CheckCancelOrderBoolG := true
                            else
                                CheckCancelOrderBoolG := false;

                        until PurchaseLineRecL.Next = 0;

                    if CheckCancelOrderBoolG then begin
                        Cancel := true;
                        Modify();
                        Message('Purchase Order %1 Cancel Successfully', "No.");
                    end
                    else
                        Error('Can not cancel the purchase order as quantities partially received or partially invoiced');

                end;

            }

            // Stop Cancel Action

        }


    }

    var
        CheckShortClosedBoolG: Boolean;
        CheckCancelOrderBoolG: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?';



    trigger
    OnOpenPage()
    begin
        CheckShortClosedBoolG := false;
        CheckCancelOrderBoolG := false;
    end;

    procedure PostCust(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        ApplicationAreaSetup: Record "Application Area Setup";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
    begin
        IF ApplicationAreaSetup.IsFoundationEnabled THEN
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        SendToPosting(PostingCodeunitID);

        IsScheduledPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (NOT PurchaseHeader.GET("Document Type", "No.")) OR IsScheduledPosting;

        IF IsScheduledPosting THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
            EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            ShowPostedConfirmationMessage;

    end;

    procedure ShowPostedConfirmationMessage()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT OrderPurchaseHeader.GET("Document Type", "No.") THEN BEGIN
            PurchInvHeader.SETRANGE("No.", "Last Posting No.");
            IF PurchInvHeader.FINDFIRST THEN
                IF InstructionMgt.ShowConfirm(OpenPostedPurchaseOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        END;

    end;


}