# SimpleXML

A simple add on to rexml to parse xml data simply by converting them to a hash.
That hash can than easily be passed to model objects to validate etc.

Example usage:

```ruby
doc = REXML::Document.new(%Q{
     <?xml version="1.0"?>
     <address>
       <country iso_code="de" nationality="deutsch">Deutschland</country>
       <zip_code>76135</zip_code>
       <city>Karlsruhe</city>
       <street>
         <name_and_number>Ernst-Frey-Str. 10</name_and_number>
       </street>
     </address>
   }
doc.simplify("/address") #=> { :country => "Deutschland", :zip_code => "76135", :city => "Karlsruhe", :street => { :name_and_number => "Ernst-Frey-Str. 10" } }
doc.simplify_attributes("/address/country") #=> { :iso_code => "de", :nationality => "deutsch" }
```
