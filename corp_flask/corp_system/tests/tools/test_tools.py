
def test_RSI_account(RSI_website_account):
    RSI_website_account.RSI_handle == "Cyber-Dreamer"
    assert  RSI_website_account.confirm_token("1sv1b0jTVNSifXyZQcOc2Fh4i0pnLHFm4P0YtqrBrA9mL_vTsIe8m1jI")
    

def test_RSI_funding(RSI_website_funding):
    assert RSI_website_funding.fund > 10
    assert RSI_website_funding.citizens > 10