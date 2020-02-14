pageextension 50020 "Ext. Purchase Order List" extends "Purchase Order List"
{
    actions
    {
        addafter("O&rder")
        {

            action("Open Short Closed List")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = page "Purchase Order List ShortClose";
            }
            action("Open Cancel Order List")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = page "Purchase Order List Cancel";
            }

        }
        modify(Post)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
    }
    trigger
    OnOpenPage()
    begin
        SetRange("Short Closed", false);
        SetRange(Cancel, false);
    end;


}