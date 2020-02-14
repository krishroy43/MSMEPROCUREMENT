tableextension 50006 "Ext. Vendor" extends Vendor
{
    fields
    {
        field(50005; "ID Proof Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Emirates ID","Passport";
            trigger
            OnValidate()
            begin
                if (Xrec."ID Proof Type" <> "ID Proof Type") OR
                    ("ID Proof Type" = "ID Proof Type"::" ") then
                    ClearVendorIDProofVariable();
            end;


        }
        field(50006; "ID Proof No."; Text[150])
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if ("ID Proof No." = '') OR (xRec."ID Proof No." <> "ID Proof No.") then
                    Clear("ID Proof Expiry Date");
            end;
        }
        field(50007; "ID Proof Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Trade License"; Text[150])
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if ("Trade License" = '') OR (xRec."Trade License" <> "Trade License") then
                    ClearVendorTradeVariable();
            end;
        }
        field(50009; "Trade License Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    procedure ClearVendorIDProofVariable()
    begin
        Clear("ID Proof No.");
        Clear("ID Proof Expiry Date");

    end;

    procedure ClearVendorTradeVariable()
    begin
        Clear("Trade License Expiry Date");
    end;

}