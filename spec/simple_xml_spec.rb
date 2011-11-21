require 'spec_helper'

describe REXML::Element do
  before(:each) do
    @doc = REXML::Document.new(%Q{
      <?xml version="1.0"?>
      <user>
        <address>
          <country iso_code="de" nationality="deutsch">Deutschland</country>
          <zip_code>76135</zip_code>
          <city>Karlsruhe</city>
          <street>
            <name_and_number>Ernst-Frey-Str. 10</name_and_number>
          </street>
        </address>
        <phones>
          <phone type="MOBILE">
            <country>+49</country>
            <provider>171</provider>
            <number>20333232</number>
          </phone>
          <phone type="HOME">+494534520085285</phone>
          <phone type="WORK">+494534523453453</phone>
        </phones>
      </user>
    })
  end
  
  it "should be possible not fail if the node doesn't exists" do
    @doc.simplify("/user/no-element").should == nil
  end
  
  it "should be possible to call on root element without a xpath" do
    @doc.simplify.should == {
      :user => {
        :address => {
          :country => "Deutschland",
          :zip_code => "76135",
          :city => "Karlsruhe",
          :street => {
            :name_and_number => "Ernst-Frey-Str. 10"
          }
        },
        :phones => {
          :phone => [ 
            { :number => "20333232", :provider => "171", :country => "+49" }, 
            "+494534520085285",
            "+494534523453453"
          ]
        }
      }
    }
  end
  
  it "should be possible to" do
    @doc.simplify("/user").should == {
      :address => {
        :country => "Deutschland",
        :zip_code => "76135",
        :city => "Karlsruhe",
        :street => {
          :name_and_number => "Ernst-Frey-Str. 10"
        }
      },
      :phones => {
        :phone => [ 
          { :number => "20333232", :provider => "171", :country => "+49" }, 
          "+494534520085285",
          "+494534523453453"
        ]
      }
    }
  end
  
  it "should be possible to request for attributes of a not existing node" do
    @doc.simplify_attributes("/test").should == nil
  end
  
  it "should be possible to request for existing attributes" do
    @doc.simplify_attributes("/user/phones/phone[1]").should == {
      :type => "MOBILE"
    }
    @doc.simplify_attributes("/user/phones/phone[2]").should == {
      :type => "HOME"
    }
    @doc.simplify_attributes("/user/address/country").should == {
      :iso_code => "de",
      :nationality => "deutsch"
    }
  end
end
