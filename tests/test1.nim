# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import iniplus

const file = """
name ="Acme Gadgets LLC"
founder: "Jane Doe"

[products]
fromCountry="US"
shippingTo = [
    "US", "UK", "EU"
]

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
"""

var
  table = newConfigTable()
  # Creates a String ConfigValue object
  valueStr = newValue("Hello World!")
  # Creates a Sequence ConfigValue object
  valueArr = newValue(
    newValue("Hello World!"),
    newValue(1000)
  )
  
# Inserting a handmade string into a table
table.setKey("handmade","quote",valueStr)
assert table.getString("handmade","quote") == "Hello World!"

# Inserting a handmade array into a table
table.setKey("handmade","list",valueArr)
assert table.getArray("handmade", "list")[0].stringVal == "Hello World!"
assert table.getArray("handmade", "list")[1].intVal == 1000

table.setKeySingleVal("single","number","1000")
table.setKeySingleVal("single","quote","\"Hello World!\"")
table.setKeySingleVal("single","true_false","false")

assert table.getString("single","quote") == "Hello World!"
assert table.getInt("single","number") == 1000
assert table.getBool("single", "true_false") == false

table.setKeyMultiVal("multi","list","[\"Hello World!\",1000]")

assert table.getArray("multi","list")[0].stringVal == "Hello World!"
assert table.getArray("multi","list")[1].intVal == 1000

table = parseString("employees = [\"John\",\"Katie\",1000]")
var employees = table.getArray("","employees")

assert employees[0].kind == String
assert employees[1].kind == String
assert employees[2].kind == Int

assert employees[0].stringVal == "John"
assert employees[1].stringVal == "Katie"
assert employees[2].intVal == 1000

table = parseString("employees = [\"John\",\"Katie\",1000]")
var employees2 = table.getStringArray("","employees")
    
assert employees2[0] == "John"
assert employees2[1] == "Katie"
assert len(employees2) == 2

table = parseString("numbers = [1000, 2000, \"Michael\"]")
var number = table.getIntArray("","numbers")

assert number[0] == 1000
assert number[1] == 2000
assert len(number) == 2

table = parseString("[my_favorite]\nbooleans=[true, \"Jimmy\", false]")
var myFavoriteBooleans = table.getBoolArray("my_favorite","booleans")
    
assert myFavoriteBooleans[0] == true
assert myFavoriteBooleans[1] == false
assert len(myFavoriteBooleans) == 2

table = parseString("name = \"John Doe\"")
assert table.getValue("","name").kind == String
assert table.getValue("","name").stringVal == "John Doe"

table = parseString("""
[dialog]
info_text = "Insert some informational text here."
""")
assert table.getString("dialog","info_text") == "Insert some informational text here."
assert table.getStringOrDefault("dialog","help_text","Insert some helpful text here.") == "Insert some helpful text here."

table = parseString("enable_feature = true")
assert table.getBool("","enable_feature") == true

table = parseString("port = 8080")
assert table.getInt("","port") == 8080

table = parseString(file)
echo table.dump()