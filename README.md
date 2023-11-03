# iniplus

An extended INI parser for Nim

[products]
sort: "alphabetically"

[products.1]
id: 1
name: "Ultra Product #1"
price: 75
inStock: false
isDeprecated: true
newProductId: 2
; iniplus does not support timestamps.
; as a workaround, you can format your time to an ISO-compatible date
; and format it when you read it again
releaseDate: "2020-10-29T16:17:07Z"

[products.2]
id = 2
name = "Ultra Product #2"
price = 150 
inStock = true
isDeprecated = false
# iniplus does not support timestamps.
# as a workaround, you can format your time to an ISO-compatible date
# and format it when you read it again
releaseDate = "2023-10-29T16:17:07Z"

[legal]
shippingTo = [
    "US", "UK", "EU"
]

bannedCustomers = {
    "John Doe": "Asked for a refund",
    "Jane McKenzie": "Made a bird implode"
}