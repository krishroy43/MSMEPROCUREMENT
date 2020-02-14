pageextension 50905 "Ext Source Documents" extends "Source Documents"
{
    layout
    {
        addafter("Destination No.")
        {
            field("Destination Name"; "Destination Name")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger
    OnAfterGetRecord()
    var
        VendorRecL: Record Vendor;
        CustomerRecL: Record Customer;
    begin
        if "Destination Type" = "Destination Type"::Vendor then begin
            VendorRecL.Reset();
            if VendorRecL.Get("Destination No.") then
                "Destination Name" := VendorRecL.Name;
        end else
            if "Destination Type" = "Destination Type"::Customer then begin
                CustomerRecL.Reset();
                if CustomerRecL.get("Destination No.") then
                    "Destination Name" := CustomerRecL.Name;
            end;

        if "Destination No." = '' then
            Clear("Destination Name");

    end;
}