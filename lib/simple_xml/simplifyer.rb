module SimpleXML
  # Extension to the element class of rexml to make working with simple xml
  # documents more easy and intuitive. Therefor it uses the combination of hashes
  # and the rexml XPath implementation.
  # @example Usage with a simple document
  #   doc = REXML::Document.new(%Q{
  #     <?xml version="1.0"?>
  #     <address>
  #       <country iso_code="de" nationality="deutsch">Deutschland</country>
  #       <zip_code>76135</zip_code>
  #       <city>Karlsruhe</city>
  #       <street>
  #         <name_and_number>Ernst-Frey-Str. 10</name_and_number>
  #       </street>
  #     </address>
  #   }
  #   doc.simplify("/address") #=> { :country => "Deutschland", :zip_code => "76135", :city => "Karlsruhe", :street => { :name_and_number => "Ernst-Frey-Str. 10" } }
  #   doc.simplify_attributes("/address/country") #=> { :iso_code => "de", :nationality => "deutsch" }
  # 
  module Simplifyer
    # Simplifies the current element or an xpath to a subelement to a hash.
    # @param [String] xpath an optional xpath for an element to convert
    # @return [Hash, NilClass] nil if the xpath didn't match to a node or a hash otherwise.
    #   If elements have the same name they will be merged into an array.
    def simplify(xpath = nil)
      if xpath
        if element = REXML::XPath.first(self, xpath)
          element.simplify
        else
          nil
        end
      else
        # just convert the elements if there are some
        if contains_no_text_elements?
          tree = {} # the subtree
          last_name = nil # helper for detecting duplicate element names
          self.each do |element|
            # we ignore all text elements that are in between the elements
            if element.is_a? REXML::Element
              name = element.name.to_sym
              if last_name == name
                # create an array if there is more than one element with
                # the same name
                tree[name] = [tree[name]] unless tree[name].is_a?(Array)
                tree[name] += [element.simplify]
              else
                # create a simple element (key - value) in the hash
                tree[name] = element.simplify
                last_name = name
              end
            end
          end
          tree
        else
          # if there is just text left the text elements will be used
          self.text
        end
      end
    end
  
    # Simplifies the current element attributes or an xpath to subelement
    # attributes to a hash.
    # @param [String] xpath an optional xpath for an element to convert
    # @return [Hash, NilClass] nil if the xpath didn't match to a node or a hash otherwise.
    def simplify_attributes(xpath = nil)
      if xpath
        if element = REXML::XPath.first(self, xpath)
          element.simplify_attributes
        else
          nil
        end
      else
        hash = {}
        attributes.each { |key, value| hash[key.to_sym] = value }
        hash
      end    
    end
  
  private
  
    # Checks if the sub element has any other elements than text elements.
    # @returns [Boolean] ture if there is at least one REXML::Element
    def contains_no_text_elements?
      children.each do |element| 
        return true if element.is_a? REXML::Element
      end
      false
    end
  end
end
