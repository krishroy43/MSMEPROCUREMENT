tableextension 50014 "Ext. Warehouse Receipt Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50000; "Quality Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
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

}


