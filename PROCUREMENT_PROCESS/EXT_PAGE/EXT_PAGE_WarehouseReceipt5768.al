pageextension 50018 "Ext. Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Sorting Method")
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
        modify("Post Receipt")
        {
            trigger
            OnBeforeAction()
            begin
                TestField("Quality Checked");
                TestField("Quality Checked By");
                if WorkDate() <> "Posting Date" then
                    Error('You cannot post a receipt with a date other than Today.');
            end;

        }
    }

    var
        myInt: Integer;
}