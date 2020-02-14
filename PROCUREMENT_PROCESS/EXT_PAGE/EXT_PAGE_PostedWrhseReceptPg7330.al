pageextension 50026 "Ext. Posted Whrs Receipt" extends "Posted Whse. Receipt"
{
    layout
    {
        addafter("Assignment Time")
        {
            field("Quality Checked"; "Quality Checked")
            {
                ApplicationArea = All;
            }
            field("Quality Checked By"; "Quality Checked By")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}