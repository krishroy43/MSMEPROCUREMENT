tableextension 50018 "Ext Post Warehr Recpt Header" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50000; "Quality Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger
            OnValidate()
            begin
                if "Quality Checked" then
                    "Quality Checked By" := UserId()
                else
                    Clear("Quality Checked By");
            end;

        }
        field(50001; "Quality Checked By"; Code[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}