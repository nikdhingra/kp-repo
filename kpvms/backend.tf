#Azure backend
terraform {
  backend "azurerm" {
    resource_group_name  = "East US"
    storage_account_name = "mytfacc"
    container_name       = "statefile"
    key                  = "terraform.tfstate"
    subscription_id      = "9bd2fe7b-8da1-4dad-ac7c-7766fe130a05"
    use_azuread_auth   = true
    sas_token = "sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2025-03-03T20:12:03Z&st=2025-03-03T12:12:03Z&spr=https,http&sig=kBJyQ5kVZU06u9q49TbCeJH33fOSQxa%2F4wKf9xMRVa8%3D"
  }
}