tableextension 50015 "Ext. Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Short Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Cancel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger
    OnModify()
    begin
        if ("Short Closed" = true) OR (Cancel = true) then
            Error('Once Order Short Close/Cancel ,you cannot Modify .');
    end;

    trigger
    OnDelete()
    begin
        if ("Short Closed" = true) OR (Cancel = true) then
            Error('Once Order Short Close/Cancel ,you cannot Delete .');
    end;

}