pageextension 50122 "Ext Purchase Return Order" extends "Purchase Return Order"
{
    actions
    {
        addlast("P&osting")
        {
            action("Customize Posting")
            {
                ApplicationArea = All;
                Image = Post;
                Caption = 'Post';
                trigger
                OnAction()
                begin
                    Post(50018);
                end;
            }

        }
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }


    }
    var
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseReturnOrderQst: Label 'The return order has been posted and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?';

    procedure Post(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        SendToPosting(PostingCodeunitID);

        DocumentIsPosted := NOT PurchaseHeader.GET("Document Type", "No.");

        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
            EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            ShowPostedConfirmationMessage;
    end;

    procedure ShowPostedConfirmationMessage()
    var
        ReturnOrderPurchaseHeader: Record "Purchase Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT ReturnOrderPurchaseHeader.GET("Document Type", "No.") THEN BEGIN
            PurchCrMemoHdr.SETRANGE("No.", "Last Posting No.");
            IF PurchCrMemoHdr.FINDFIRST THEN
                IF InstructionMgt.ShowConfirm(OpenPostedPurchaseReturnOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        END;
    end;
}


pageextension 50123 "Ext Purchase Return Order List" extends "Purchase Return Order List"
{
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }

    }
}